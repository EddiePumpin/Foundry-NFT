// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant BUNNY =
        "ipfs://QmPbn9TF7ErtSXuV1YPZjoMTczn4RahopFBQK6DqATna2x";
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // String is an array of bytes
        // And an array cannot be compare with another array, we can onlu compare primitive types or elementary types like uint256, address, bool, bytes32
        // assert(expectedName == actualName);
        // We can for(loop through the array of bytes32) and compare the elements of the array
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();
        assert(
            keccak256(abi.encodePacked(expectedSymbol)) ==
                keccak256(abi.encodePacked(actualSymbol))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    function testGetTheTokenIdOfMintNft() public {
        vm.prank(USER);
        basicNft.mintNft(BUNNY);
        string memory tokenUri = basicNft.getTokenIdToTokenUri(0);
        assert(
            keccak256(abi.encodePacked(tokenUri)) ==
                keccak256(abi.encodePacked(BUNNY))
        );
    }

    function testTokenCounterShouldIncreaseAfterMint() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);
        uint256 tokenCounter = basicNft.getTokenCounter();
        assertEq(tokenCounter, 1);
    }
}
