pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  // 1. Change modifier name to `onlyOwnerOf`
  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now);
  }

  // 2. Change modifier name here as well
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie));
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}


//Chapter 2.7 Storage vs Memory
//When a zombie feeds on some other lifeform, its DNA will combine with the other lifeform's DNA to create a new zombie.

/**Create a function called feedAndMultiply. It will take two parameters: _zombieId (a uint) and _targetDna (also a uint). This function should be public.

We don't want to let someone else feed our zombie! So first, let's make sure we own this zombie. 
Add a require statement to verify that msg.sender is equal to this zombie's owner (similar to how we did in the createRandomZombie function).

Again, because our answer-checker is primitive, it's expecting msg.sender to come first and will mark it wrong if you switch the order. 
But normally when you're coding, you can use whichever order you prefer — both are correct.

We're going to need to get this zombie's DNA. 
So the next thing our function should do is declare a local Zombie named myZombie (which will be a storage pointer). 
Set this variable to be equal to index _zombieId in our zombies array.
/*

//Chapter 2.10 Get the CryptoKitty DNA
We've looked up the CryptoKitties source code for you, and found a function called getKitty that returns all the kitty's data, including its "genes" (which is what our zombie game needs to form a new zombie!).
Define an interface called KittyInterface. Remember, this looks just like creating a new contract — we use the contract keyword.

Inside the interface, define the function getKitty (which should be a copy/paste of the function above, but with a semi-colon after the returns statement, instead of everything inside the curly braces.

//Chapter 2. 11 Let's set up our contract to read from the CryptoKitties smart contract!

I've saved the address of the CryptoKitties contract in the code for you, under a variable named ckAddress. 
In the next line, create a KittyInterface named kittyContract, and initialize it with ckAddress — just like we did with numberContract above.

//Chapter 2.12: Handling Multiple Return Values
Let's make a function that gets the kitty genes from the contract:

Make a function called feedOnKitty. It will take 2 uint parameters, _zombieId and _kittyId, and should be a public function.

The function should first declare a uint named kittyDna.

//Note: In our KittyInterface, genes is a uint256 — but if you remember back to lesson 1, uint is an alias for uint256 — they're the same thing.

The function should then call the kittyContract.getKitty function with _kittyId and store genes in kittyDna. Remember — getKitty returns a ton of variables. (10 to be exact — I'm nice, I counted them for you!). But all we care about is the last one, genes. Count your commas carefully!

Finally, the function should call feedAndMultiply, and pass it both _zombieId and kittyDna.

//Chapter 13. Bonus Kitty Genes - using if statement
First, let's change the function definition for feedAndMultiply so it takes a 3rd argument: a string named _species which we'll store in memory.

Next, after we calculate the new zombie's DNA, let's add an if statement comparing the keccak256 hashes of _species and the string "kitty". We can't directly pass strings to keccak256. Instead, we will pass abi.encodePacked(_species) as an argument on the left side and abi.encodePacked("kitty") as an argument on the right side.

Inside the if statement, we want to replace the last 2 digits of DNA with 99. One way to do this is using the logic: newDna = newDna - newDna % 100 + 99;.

Explanation: Assume newDna is 334455. Then newDna % 100 is 55, so newDna - newDna % 100 is 334400. Finally add 99 to get 334499.

Lastly, we need to change the function call inside feedOnKitty. When it calls feedAndMultiply, add the parameter "kitty" to the end.

//Chapter 3.1: Immutability of Contracts: 
Let's update our code from Lesson 2 to be able to change the CryptoKitties contract address.

Delete the line of code where we hard-coded ckAddress.

Change the line where we created kittyContract to just declare the variable — i.e. don't set it equal to anything.

Create a function called setKittyContractAddress. It will take one argument, _address (an address), and it should be an external function.

Inside the function, add one line of code that sets kittyContract equal to KittyInterface(_address).

//Chapter 3.3 onlyOwner Function Modifier
//Now we can restrict access to setKittyContractAddress so that no one but us can modify it in the future.

//Add the onlyOwner modifier to setKittyContractAddress.

Chapter 3.6 Passing Structs as Arguments:
Start by defining a _triggerCooldown function. It will take 1 argument, _zombie, a Zombie storage pointer. The function should be internal.

The function body should set _zombie.readyTime to uint32(now + cooldownTime).

Next, create a function called _isReady. This function will also take a Zombie storage argument named _zombie. It will be an internal view function, and return a bool.

The function body should return (_zombie.readyTime <= now), which will evaluate to either true or false. This function will tell us if enough time has passed since the last time the zombie fed.

Chapter 3.7 : Public Functions and Security:
Currently feedAndMultiply is a public function. Let's make it internal so that the contract is more secure. We don't want users to be able to call this function with any DNA they want.

Let's make feedAndMultiply take our cooldownTime into account. First, after we look up myZombie, let's add a require statement that checks _isReady() and passes myZombie to it. This way the user can only execute this function if a zombie's cooldown time is over.

At the end of the function let's call _triggerCooldown(myZombie) so that feeding triggers the zombie's cooldown time.

Chapter 4.6
Create a modifier called ownerOf. It will take 1 argument, _zombieId (a uint).
The body should require that msg.sender is equal to zombieToOwner[_zombieId], then continue with the function. 
You can refer to zombiehelper.sol if you don't remember the syntax for a modifier.
Change the function definition of feedAndMultiply such that it uses the modifier ownerOf.
Now that we're using a modifier, you can remove the line require(msg.sender == zombieToOwner[_zombieId]);

Chapter 4.7 do the same for changeName() and changeDna()

Chapter 5.4 
We're back in zombiefeeding.sol. We're going to change the name of our modifier from ownerOf to onlyOwnerOf.

Change the name of the modifier definition to onlyOwnerOf

Scroll down to the function feedAndMultiply, which uses this modifier. We'll need to change the name here as well.