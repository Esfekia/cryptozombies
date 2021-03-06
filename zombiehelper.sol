//Chapter 3.8
//In ZombieHelper, create a modifier called aboveLevel. It will take 2 arguments, _level (a uint) and _zombieId (also a uint).

//The body should check to make sure zombies[_zombieId].level is greater than or equal to _level.

//Remember to have the last line of the modifier call the rest of the function with _;.

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    uint256 levelUpFee = 0.001 ether;

    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    // 1. Create withdraw function here
    function withdraw() external onlyOwnerOf {
        address payable _owner = address(uint160(owner()));
        _owner.transfer(address(this).balance);
    }

    // 2. Create setLevelUpFee function here
    function setLevelUpFee(uint256 _fee) external onlyOwnerOf {
        levelUpFee = _fee;
    }

    function levelUp(uint256 _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level = zombies[_zombieId].level.add(1);
    }

    function changeName(uint256 _zombieId, string calldata _newName)
        external
        aboveLevel(2, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint256 _zombieId, uint256 _newDna)
        external
        aboveLevel(20, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](ownerZombieCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}

//Chapter 3.9
//Create a function called changeName. It will take 2 arguments: _zombieId (a uint), and _newName (a string with the data location set to calldata ), and make it external.
//It should have the aboveLevel modifier, and should pass in 2 for the _level parameter. (Don't forget to also pass the _zombieId).
//Note: calldata is somehow similar to memory, but it's only available to external functions.
//In this function, first we need to verify that msg.sender is equal to zombieToOwner[_zombieId]. Use a require statement.
//Then the function should set zombies[_zombieId].name equal to _newName.
//Create another function named changeDna below changeName. Its definition and contents will be almost identical to changeName,
//except its second argument will be _newDna (a uint), and it should pass in 20 for the _level parameter on aboveLevel.
//And of course, it should set the zombie's dna to _newDna instead of setting the zombie's name.

//Chapter 3.10
//We're going to implement a function that will return a user's entire zombie army. We can later call this function from web3.js if we want to display a user profile page with their entire army.
//This function's logic is a bit complicated so it will take a few chapters to implement.
//Create a new function named getZombiesByOwner. It will take one argument, an address named _owner.
//Let's make it an external view function, so we can call it from web3.js without needing any gas.
//The function should return a uint[] (an array of uint) as memory data location.
//Leave the function body empty for now, we'll fill it in in the next chapter.

//Chapter 3.11
//In our getZombiesByOwner function, we want to return a uint[] array with all the zombies a particular user owns.
//Declare a uint[] memory variable called result
//Set it equal to a new uint array. The length of the array should be however many zombies this _owner owns, which we can look up from our mapping with: ownerZombieCount[_owner].
//At the end of the function return result. It's just an empty array right now, but in the next chapter we'll fill it in.

//Chapter 3.12
//Let's finish our getZombiesByOwner function by writing a for loop that iterates through all the zombies in our DApp, compares their owner to see if we have a match, and pushes them to our result array before returning it.
//Declare a uint called counter and set it equal to 0. We'll use this variable to keep track of the index in our result array.
//Declare a for loop that starts from uint i = 0 and goes up through i < zombies.length. This will iterate over every zombie in our array.
//Inside the for loop, make an if statement that checks if zombieToOwner[i] is equal to _owner. This will compare the two addresses to see if we have a match.
//Inside the if statement:
//Add the zombie's ID to our result array by setting result[counter] equal to i.
//Increment counter by 1 (see the for loop example above).
//That's it ??? the function will now return all the zombies owned by _owner without spending any gas.

/*Chapter 4.1 Payable
Let's create a payable function in our zombie game.
Let's say our game has a feature where users can pay ETH to level up their zombies. The ETH will get stored in the contract, which you own ??? this a simple example of how you could make money on your games!
Define a uint named levelUpFee, and set it equal to 0.001 ether.
Create a function named levelUp. It will take one parameter, _zombieId, a uint. It should be external and payable.
The function should first require that msg.value is equal to levelUpFee.
It should then increment this zombie's level: zombies[_zombieId].level++.
*/
/*Chapter 4.2 Withdraws
Create a withdraw function in our contract, which should be identical to the GetPaid example above.
The price of Ether has gone up over 10x in the past year. So while 0.001 ether is about $1 at the time of this writing, if it goes up 10x again, 0.001 ETH will be $10 and our game will be a lot more expensive.
So it's a good idea to create a function that allows us as the owner of the contract to set the levelUpFee.
a. Create a function called setLevelUpFee that takes one argument, uint _fee, is external, and uses the modifier onlyOwner.
b. The function should set levelUpFee equal to _fee.
*/
