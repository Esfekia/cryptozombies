pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;
    // 1. Define `cooldownTime` here
    uint256 cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        // 2. Update the following line:
        uint256 id = zombies.push(
            Zombie(_name, _dna, 1, uint32(now + cooldownTime))
        ) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        randDna = randDna - (randDna % 100);
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
