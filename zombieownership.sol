pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

/// @title A contract that manages transferring zombie ownership.
/// @author Sertac
/// @dev Compliant with OpenZeppelin's implementation of the ERC721 spec draft
/// @dev uses SafeMath libraries for uint256,32 & 16.
contract ZombieOwnership is ZombieAttack, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) zombieApprovals;

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
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

Chapter 5.5:
Let's define the logic for _transfer.

Define a function named _transfer. It will take 3 arguments, address _from, address _to, and uint256 _tokenId. 
It should be a private function.

We have 2 mappings that will change when ownership changes: ownerZombieCount 
(which keeps track of how many zombies an owner has) and zombieToOwner (which keeps track of who owns what).

The first thing our function should do is increment ownerZombieCount for the person receiving the zombie (address _to). 
Use ++ to increment.

Next, we'll need to decrease the ownerZombieCount for the person sending the zombie (address _from). Use -- to decrement.

Lastly, we'll want to change zombieToOwner mapping for this _tokenId so it now points to _to.

I lied, that wasn't the last step. There's one more thing we should do.

The ERC721 spec includes a Transfer event. The last line of this function should fire Transfer with the correct information 
??? check erc721.sol to see what arguments it's expecting to be called with and implement it here.


Chapter 5.6:
First, we want to make sure only the owner or the approved address of a token/zombie can transfer it. 
Let's define a mapping called zombieApprovals. It should map a uint to an address. 
This way, when someone that is not the owner calls transferFrom with a _tokenId, 
we can use this mapping to quickly look up if he is approved to take that token.

Next, let's add a require statement to transferFrom. 
It should make sure that only the owner or the approved address of a token/zombie can transfer it.

Lastly, don't forget to call _transfer.

Note: Checking that only the owner or the approved address of a token/zombie can transfer 
it means that at least one of these conditions must be true:

zombieToOwner for _tokenId is equal to msg.sender

or

zombieApprovals for _tokenId is equal to msg.sender

Chapter 5.7: 
In the approve function, we want to make sure only the owner of the token can give someone approval to take it. 
So we need to add the onlyOwnerOf modifier to approve

For the body of the function, set zombieApprovals for _tokenId equal to the _approved address.

Chapter 5.8 :
Let's fire the Approval event. Take a look at the erc721.sol file for the arguments, and be sure to use msg.sender as _owner.
Great, we have finished our ERC721 implementation!
contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

Chapter 5.9:
We've already included OpenZeppelin's SafeMath library for you in safemath.sol. 
You can take a quick peek at the code now if you want to, but we'll be looking at it in depth in the next chapter.

First let's tell our contract to use SafeMath. 
We'll do this in ZombieFactory, our very base contract ??? 
that way we can use it in any of the sub-contracts that inherit from this one.

Import safemath.sol into zombiefactory.sol.

Add the declaration using SafeMath for uint256;.

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;

Chapter 5.10 Use SafeMath to replace ++ and --

Chapter 5.13 Added comments using natspec.