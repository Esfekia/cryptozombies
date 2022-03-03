pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  uint randNonce = 0;
  // Create attackVictoryProbability here
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

  // Create new function here
  function attack(uint _zombieId, uint _targetId) external {
      
  }
}





/* Chapter 4.4 Random Numbers
Let's implement a random number function we can use to determine the outcome of our battles, even if it isn't totally secure from attack.
Give our contract a uint called randNonce, and set it equal to 0.
Create a function called randMod (random-modulus). It will be an internal function that takes a uint named _modulus, and returns a uint.
The function should first increment randNonce (using the syntax randNonce++).
Finally, it should (in one line of code) calculate the uint typecast of the keccak256 hash of abi.encodePacked(now,msg.sender,randNonce) — and return that value % _modulus. 
(Whew! That was a mouthful. If you didn't follow that, just take a look at the example above where we generated a random number — the logic is very similar).

Chapter 4.5 Zombie Fightin'
Give our contract a uint variable called attackVictoryProbability, and set it equal to 70.
Create a function called attack. It will take two parameters: _zombieId (a uint) and _targetId (also a uint). It should be an external function.
Leave the function body empty for now.