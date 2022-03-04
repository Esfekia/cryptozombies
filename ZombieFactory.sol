pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
      string name;
      uint dna;
      uint32 level;
      uint32 readyTime;
      // 1. Add new properties here
      uint16 winCount;
      uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 2. Modify new zombie creation here:
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}


//Chapter 3.2 Ownable Contracts
//We've gone ahead and copied the code of the Ownable contract into a new file, ownable.sol. Let's go ahead and make ZombieFactory inherit from it.

//Modify our code to import the contents of ownable.sol. If you don't remember how to do this take a look at zombiefeeding.sol.

//Modify the ZombieFactory contract to inherit from Ownable. Again, you can take a look at zombiefeeding.sol if you don't remember how this is done.

//Chapter 3.4 Struct Packing:
//In this lesson, we're going to add 2 new features to our zombies: level and readyTime — the latter will be used to implement a cooldown timer to limit how often a zombie can feed.

//So let's jump back to zombiefactory.sol.

//Add two more properties to our Zombie struct: level (a uint32), and readyTime (also a uint32). We want to pack these data types together, so let's put them at the end of the struct.
//32 bits is more than enough to hold the zombie's level and timestamp, so this will save us some gas costs by packing the data more tightly than using a regular uint (256-bits).

//Chapter 3.5 Time Units
//Let's add a cooldown time to our DApp, and make it so zombies have to wait 1 day after attacking or feeding to attack again.

//Declare a uint called cooldownTime, and set it equal to 1 days. (Forgive the poor grammar — if you set it equal to "1 day", it won't compile!)

//Since we added a level and readyTime to our Zombie struct in the previous chapter, we need to update _createZombie() to use the correct number of arguments when we create a new Zombie struct.

//Update the zombies.push line of code to add 2 more arguments: 1 (for level), and uint32(now + cooldownTime) (for readyTime).

//Note: The uint32(...) is necessary because now returns a uint256 by default. So we need to explicitly convert it to a uint32.

//now + cooldownTime will equal the current unix timestamp (in seconds) plus the number of seconds in 1 day — which will equal the unix timestamp 1 day from now.
//Later we can compare to see if this zombie's readyTime is greater than now to see if enough time has passed to use the zombie again.

/*
Chapter 4.9 Zombie Wins and Losses
Modify our Zombie struct to have 2 more properties:
a. winCount, a uint16
b. lossCount, also a uint16
Note: Remember, since we can pack uints inside structs, we want to use the smallest uints we can get away with. 
A uint8 is too small, since 2^8 = 256 — if our zombies attacked once per day, they could overflow this within a year. 
But 2^16 is 65536 — so unless a user wins or loses every day for 179 years straight, we should be safe here.
Now that we have new properties on our Zombie struct, we need to change our function definition in _createZombie().
Change the zombie creation definition so it creates each new zombie with 0 wins and 0 losses.