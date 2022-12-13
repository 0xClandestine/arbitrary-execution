// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Opcodes.sol";

library ExamplePayloads {
    function eip1167(address implementation)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(
            // Creation code:
            RETURNDATASIZE, // 0
            PUSH1, // 2d 0
            hex"2d",
            DUP1, // 2d 2d  0
            PUSH1, // 0a 2d 2d  0
            hex"0a",
            RETURNDATASIZE, // 0 0a 2d 2d  0
            CODECOPY, //
            DUP2,
            RETURN,
            // Runtime code:
            CALLDATASIZE,
            RETURNDATASIZE,
            RETURNDATASIZE,
            CALLDATACOPY,
            RETURNDATASIZE,
            RETURNDATASIZE,
            RETURNDATASIZE,
            CALLDATASIZE,
            RETURNDATASIZE,
            PUSH20,
            implementation,
            GAS,
            DELEGATECALL,
            RETURNDATASIZE,
            DUP3,
            DUP1,
            RETURNDATACOPY,
            SWAP1,
            RETURNDATASIZE,
            SWAP2,
            PUSH1,
            hex"2b",
            JUMPI,
            REVERT,
            JUMPDEST,
            RETURN
        );
    }

    function emptyCall(address target) internal pure returns (bytes memory) {
        return abi.encodePacked(
            RETURNDATASIZE,
            RETURNDATASIZE,
            RETURNDATASIZE,
            RETURNDATASIZE,
            RETURNDATASIZE,
            PUSH20,
            target,
            GAS,
            CALL
        );
    }
}
