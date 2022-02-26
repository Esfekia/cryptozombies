pragma solidity >=0.5.0 <0.6.0;

// 1. Import here
import "./ownable.sol";

// 2. Inherit here:
contract ZombieFactory is Ownable {
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
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
