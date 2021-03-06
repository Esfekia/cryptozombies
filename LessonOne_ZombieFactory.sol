//Chapter 4: Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    //start here
    uint256 dnaModulus = 10**dnaDigits;
}

//Chapter 5: Create a struct named Zombie.
//Our Zombie struct will have 2 properties: name (a string), and dna (a uint).

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    // start here
    struct Zombie {
        string name;
        uint256 dna;
    }
}

//Chapter 6: Create a public array of Zombies:
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    // start here
}

//Chapter 7: Create a public function named createZombie. It should take two parameters: _name (a string), and _dna (a uint).
//Don't forget to pass the first argument by value by using the memory keyword

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    // start here
    function createZombie(string memory _name, uint256 _dna) public {}
}

//Chapter 8: Fill in the function body so it creates a new Zombie, and adds it to the zombies array.
//The name and dna for the new Zombie should come from the function arguments.

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function createZombie(string memory _name, uint256 _dna) public {
        // start here
        zombies.push(Zombie(_name, _dna));
    }
}

//Chapter 9: Our contract's createZombie function is currently public by default —
//this means anyone could call it and create a new Zombie in our contract! Let's make it private.
//Modify createZombie so it's a private function. Don't forget the naming convention!

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }
}

//Chapter 10: We're going to want a helper function that generates a random DNA number from a string.
//Create a private function called _generateRandomDna. It will take one parameter named _str (a string), and return a uint.
//Don't forget to set the data location of the _str parameter to memory.
//This function will view some of our contract's variables but not modify them, so mark it as view.
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    // start here
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {}
}

//Chapter11: Let's fill in the body of our _generateRandomDna function! Here's what it should do:
//The first line of code should take the keccak256 hash of abi.encodePacked(_str) to generate a pseudo-random hexadecimal,
//typecast it as a uint, and finally store the result in a uint called rand.
//We want our DNA to only be 16 digits long (remember our dnaModulus?).
//So the second line of code should return the above value modulus (%) dnaModulus.

pragma solidity ^0.4.25;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        // start here
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
}

//Chapter 12: Put it all together and call the functions in a function named createRandomZombie

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // start here
    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}

//Chapter 13: Events
//We want an event to let our front-end know every time a new zombie was created, so the app can display it.
//Declare an event called NewZombie. It should pass zombieId (a uint), name (a string), and dna (a uint).
//Modify the _createZombie function to fire the NewZombie event after adding the new Zombie to our zombies array.
//You're going to need the zombie's id. array.push() returns a uint of the new length of the array -
//and since the first item in an array has index 0, array.push() - 1 will be the index of the zombie we just added.
//Store the result of zombies.push() - 1 in a uint called id, so you can use this in the NewZombie event in the next line.

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    // declare our event here
    event NewZombie(uint256 zombieId, string name, uint256 dna);
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint256 _dna) private {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        // and fire it here
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
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
