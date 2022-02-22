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
