pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  // Start here
  uint randNonce = 0;
  function randMod(uint _modulus) internal returns(uint) {
      randNonce++;
      return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

}




/* Chapter 4.4 Random Numbers
Let's implement a random number function we can use to determine the outcome of our battles, even if it isn't totally secure from attack.
Give our contract a uint called randNonce, and set it equal to 0.
Create a function called randMod (random-modulus). It will be an internal function that takes a uint named _modulus, and returns a uint.
The function should first increment randNonce (using the syntax randNonce++).
Finally, it should (in one line of code) calculate the uint typecast of the keccak256 hash of abi.encodePacked(now,msg.sender,randNonce) — and return that value % _modulus. 
(Whew! That was a mouthful. If you didn't follow that, just take a look at the example above where we generated a random number — the logic is very similar).