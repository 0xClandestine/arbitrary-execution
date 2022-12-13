// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public magicNumber;

    modifier isContract() {
        assembly {
            if iszero(iszero(extcodesize(caller()))) { revert(0x00, 0x00) }
        }
        _;
    }

    function increase() external {
        ++magicNumber;
    }

    ///@notice Simple fallback function that transfers ETH if the msg.sender's codesize is 0
    fallback() external isContract {
        unchecked {
            ++magicNumber;
        }
    }
}
