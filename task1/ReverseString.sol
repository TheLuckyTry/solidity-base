// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString{
         function reverseString(string memory str) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory reversed = new bytes(strBytes.length);
        
        for (uint256 i = 0; i < strBytes.length; i++) {
            reversed[i] = strBytes[strBytes.length - 1 - i];
        }
        
        return string(reversed);
    }
}