pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    // Here's one!
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
      // Here's 3 more!
      myZombie.winCount = myZombie.winCount.add(1);
      myZombie.level = myZombie.level.add(1);
      enemyZombie.lossCount = enemyZombie.lossCount.add(1);
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
      // ...annnnd another 2!
      myZombie.lossCount = myZombie.lossCount.add(1);
      enemyZombie.winCount = enemyZombie.winCount.add(1);
      _triggerCooldown(myZombie);
    }
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

Chapter 4.8 modifier in zombieattack
Add the ownerOf modifier to attack to make sure the caller owns _zombieId.
The first thing our function should do is get a storage pointer to both zombies so we can more easily interact with them:
a. Declare a Zombie storage named myZombie, and set it equal to zombies[_zombieId].
b. Declare a Zombie storage named enemyZombie, and set it equal to zombies[_targetId].
We're going to use a random number between 0 and 99 to determine the outcome of our battle. 
So declare a uint named rand, and set it equal to the result of the randMod function with 100 as an argument.

Chapter 4.10: Zombie Victory!
Create an if statement that checks if rand is less than or equal to attackVictoryProbability.
If this condition is true, our zombie wins! So:
a. Increment myZombie's winCount.
b. Increment myZombie's level. (Level up!!!!!!!)
c. Increment enemyZombie's lossCount. (Loser!!!!!! 😫 😫 😫)
d. Run the feedAndMultiply function. Check zombiefeeding.sol to see the syntax for calling it. 
For the 3rd argument (_species), pass the string "zombie". 
(It doesn't actually do anything at the moment, but later we could add extra functionality 
for spawning zombie-based zombies if we wanted to).

Chapter 4.11 Zombie Loss (else statements)
Add an else statement. If our zombie loses:

a. Increment myZombie's lossCount.

b. Increment enemyZombie's winCount.

c. Run the _triggerCooldown function on myZombie. 
This way the zombie can only attack once per day. 
(Remember, _triggerCooldown is already run inside feedAndMultiply. 
So the zombie's cooldown will be triggered whether he wins or loses.)

Chapter 12: replaced ++'s with SafeMath .add()