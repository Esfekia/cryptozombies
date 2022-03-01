//Chapter 3.8
//In ZombieHelper, create a modifier called aboveLevel. It will take 2 arguments, _level (a uint) and _zombieId (also a uint).

//The body should check to make sure zombies[_zombieId].level is greater than or equal to _level.

//Remember to have the last line of the modifier call the rest of the function with _;.

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
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
        // Start here
        uint256[] memory result = new uint256[](ownerZombieCount[_owner]);
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
