// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {MintBasicNft, MintMoodNft, FlipMoodNft} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    MintBasicNft public mintBasicNft;
    MintMoodNft public mintMoodNft;
    FlipMoodNft public flipMoodNft;

    function setUp() external {
        mintBasicNft = new MintBasicNft();
        mintMoodNft = new MintMoodNft();
        flipMoodNft = new FlipMoodNft();
    }

    function testMintBasicNft(address contractAddress) public {
        mintBasicNft.mintNftOnContract(contractAddress);
    }

    function testMintMoodNft(address moodNftContractAddress) public {
        mintMoodNft.mintMoodNftOnContract(moodNftContractAddress);
    }

    function testFlipMoodNft(address moodNftContractAddress) public {
        flipMoodNft.flipMoodNftOnContract(moodNftContractAddress);
    }
}
