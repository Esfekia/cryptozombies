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

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

  // define function here
  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna);
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