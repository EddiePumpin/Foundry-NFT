// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    error BasicNft__TokenUriNotFound();

    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;
    uint256 private s_tokenCounter; // tokenCounter representing the tokenId

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0; // The toeknCounter is updated every time each NFT is minted
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri; // See it as each NFT has a tokenId(tokenCounter) already and we are storing the tokenUri at that location with tokenId
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    // This is the function that tells what an NFT looks like
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function getTokenIdToTokenUri(uint256 Id) public view returns (string memory) {
        return s_tokenIdToUri[Id];
    }
}
