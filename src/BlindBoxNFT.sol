// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BlindBoxNFT is ERC721 {
    uint256 constant private maxSupply = 500;
    uint256 totalSupply;
    bool public isOpened;

    string constant private baseURIBeforeOpen = "https://my.blind.box/";
    string constant private basedURI = "https://my.base/";

    constructor() ERC721("BlindBoxNFT", "BD") {}

    function freeMint() external returns (uint256) {
        require(totalSupply < maxSupply);

        uint256 tokenId = totalSupply;
        _mint(msg.sender, tokenId);
        totalSupply = totalSupply + 1;
        return tokenId;
    }

    function openBlindbox() public {
        isOpened = true;
    }

    function _baseURI() internal view override virtual returns (string memory) {
        if (isOpened) {
            return basedURI;
        } else {
            return baseURIBeforeOpen;
        }
    }
}
