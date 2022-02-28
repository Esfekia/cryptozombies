//Chapter 3.8
//In ZombieHelper, create a modifier called aboveLevel. It will take 2 arguments, _level (a uint) and _zombieId (also a uint).

//The body should check to make sure zombies[_zombieId].level is greater than or equal to _level.

//Remember to have the last line of the modifier call the rest of the function with _;.

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    // Start here
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
}
