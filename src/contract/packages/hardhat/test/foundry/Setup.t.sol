// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {TokenMonster} from "../../contracts/TokenMonster.sol";

contract Setup is Test {
    TokenMonster public tokenMonster;
    address public admin = address(1);
    address public user1 = address(2);
    address public user2 = address(3);
    address public user3 = address(4);
    string public name = "Cardene Hardhat Foundry";
    string public symbol = "CHFT";
    string public tokenURI = "token/1";
    string public baseUri = "https://ipfs.com/";
    uint256 public category = 3;
    uint256 public freeMintDuration = 1000;

    function setUp() public {
        vm.startPrank(admin);
        tokenMonster = new TokenMonster(
            baseUri,
            category,
            freeMintDuration
        );

        vm.label(admin, "Admin");
        vm.label(user1, "User1");
        vm.label(user2, "User2");
        vm.label(user3, "User3");

        vm.stopPrank();
    }
}
