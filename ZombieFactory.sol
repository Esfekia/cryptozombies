//Chapter 4: Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    //start here
    uint dnaModulus = 10 ** dnaDigits;
}

//Chapter 5: Create a struct named Zombie.
//Our Zombie struct will have 2 properties: name (a string), and dna (a uint).


pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // start here
    struct Zombie {
        string name;
        uint dna;
    }
}

//Chapter 6: Create a public array of Zombies:
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // start here

}

//Chapter 7 Create a public function named createZombie. It should take two parameters: _name (a string), and _dna (a uint). 
//Don't forget to pass the first argument by value by using the memory keyword

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // start here
    function createZombie(string memory _name, uint _dna) public {
        
    }
}
