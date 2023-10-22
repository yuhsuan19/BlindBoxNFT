// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {BlindBoxNFT} from "../src/BlindBoxNFT.sol";

contract BlindBoxNFTTest is Test {
    
    string constant private baseURIBeforeOpen = "https://my.blind.box/";
    string constant private baseURIAfterOpen = "https://my.base/";
    
    BlindBoxNFT public blindBoxNFT;
    address public user;

    function setUp() public {
        blindBoxNFT = new BlindBoxNFT();
        user = makeAddr("user");
    }

    function test_OpenBlindBox() public {

        vm.startPrank(user);
        uint256 tokenId = blindBoxNFT.freeMint();
        vm.stopPrank();

        // check token uri before open blind box
        string memory tokenURIBeforeOpen = blindBoxNFT.tokenURI(tokenId);
        assertEq(tokenURIBeforeOpen, string.concat(baseURIBeforeOpen, Strings.toString(tokenId)));

        blindBoxNFT.openBlindbox();

        // check token uri after open blind box
        string memory tokenURIAfterOpen = blindBoxNFT.tokenURI(tokenId);
        assertEq(tokenURIAfterOpen, string.concat(baseURIAfterOpen, Strings.toString(tokenId)));
    }
}
