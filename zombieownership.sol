pragma solidity >=0.5.0 <0.6.0;
import "./zombieattack.sol";
contract ZombieOwnership is ZombieAttack {
}



/*Chapter 5.1:
We're going to dive into the ERC721 implementation in the next chapter. 
But first, let's set up our file structure for this lesson.
We're going to store all the ERC721 logic in a contract called ZombieOwnership.
Declare our pragma version at the top of the file (check previous lessons' files for the syntax).
This file should import from zombieattack.sol.
Declare a new contract, ZombieOwnership, that inherits from ZombieAttack. Leave the body of the contract empty for now.