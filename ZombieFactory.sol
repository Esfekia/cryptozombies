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
