// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ArbitraryExecution {
    function executePayload(bytes calldata payload)
        public
        payable
        returns (address instance)
    {
        assembly {
            calldatacopy(0x80, payload.offset, payload.length)

            instance := create(callvalue(), 0x80, payload.length)

            if iszero(instance) { revert(0x00, 0x00) }
        }
    }
}
