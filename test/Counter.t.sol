// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ArbitraryExecution.sol";
import "./ExamplePayloads.sol";
import "./Counter.sol";

contract GhostTest is Test {
    ArbitraryExecution ghost;
    Counter callee;

    function setUp() public {
        ghost = new ArbitraryExecution();
        callee = new Counter();
    }

    /// @notice credit to 0xKitsune
    function testEmptyCall() public {
        // bypass isContract check with ghost tx
        ghost.executePayload(ExamplePayloads.emptyCall(address(callee)));

        // assert magicNumber has increased thus proving isContract check was bypassed
        assertEq(callee.magicNumber(), 1);

        // prove contract cannot normally get past isContract check
        (bool success,) = address(callee).call("");
        assertTrue(!success);
    }

    function testEip1167() public {
        address instance =
            ghost.executePayload(ExamplePayloads.eip1167(address(callee)));

        Counter(instance).increase();

        assertEq(Counter(instance).magicNumber(), 1);
    }
}
