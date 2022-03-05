pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

  function balanceOf(address _owner) external view returns (uint256) {
    // 1. Return the number of zombies `_owner` has here
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    // 2. Return the owner of `_tokenId` here
    return zombieToOwner[_tokenId];
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {

  }

  function approve(address _approved, uint256 _tokenId) external payable {

  }
}


/*Chapter 5.1:
We're going to dive into the ERC721 implementation in the next chapter. 
But first, let's set up our file structure for this lesson.
We're going to store all the ERC721 logic in a contract called ZombieOwnership.
Declare our pragma version at the top of the file (check previous lessons' files for the syntax).
This file should import from zombieattack.sol.
Declare a new contract, ZombieOwnership, that inherits from ZombieAttack. Leave the body of the contract empty for now.

Chapter 5.2:
We've already created erc721.sol with the interface above for you.
Import erc721.sol into zombieownership.sol
Declare that ZombieOwnership inherits from ZombieAttack AND ERC721

Chapter 5.3:
I'll leave it to you to figure out how to implement these 2 functions.
Each function should simply be 1 line of code, a return statement. 
Take a look at our code from previous lessons to see where we're storing this data. 
If you can't figure it out, you can hit the "show me the answer" button for some help.
Implement balanceOf to return the number of zombies _owner has.
Implement ownerOf to return the address of whoever owns the zombie with ID _tokenId.

contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;