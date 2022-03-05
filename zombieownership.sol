pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
// Import file here
import "./erc721.sol";

// Declare ERC721 inheritance here
contract ZombieOwnership is ZombieAttack, erc721 {

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



contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;