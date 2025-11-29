// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInt {
    // 罗马数字到数值的映射
    mapping(bytes1 => uint256) private romanValues;

    constructor() {
        romanValues["I"] = 1;
        romanValues["V"] = 5;
        romanValues["X"] = 10;
        romanValues["L"] = 50;
        romanValues["C"] = 100;
        romanValues["D"] = 500;
        romanValues["M"] = 1000;
    }

    function romanToInt(string memory romanStr) public pure returns (uint256) {
        bytes memory romanBytes = bytes(romanStr);
        uint256 len = romanBytes.length;
        require(len > 0, "Roman number cannot empty");
        uint256 result = 0;

        for (uint256 i = 0; i < len; i++) {
            uint256 currentValue = getRomanValue(romanBytes[i]);

            //与下一个字符相比 如果 小于则需要相减
            if (i + 1 < len) {
                uint256 nextValue = getRomanValue(romanBytes[i + 1]);
                if (currentValue < nextValue) {
                    result += (nextValue - currentValue);
                    //处理过了 跳过
                    i++;
                    continue;
                }
            }
            result += currentValue;
        }
        return result;
    }

    //获取罗马字符对应的数值
    function getRomanValue(bytes1 romanChar) private pure returns (uint256) {
        if (romanChar == "I") return 1;
        if (romanChar == "V") return 5;
        if (romanChar == "X") return 10;
        if (romanChar == "L") return 50;
        if (romanChar == "C") return 100;
        if (romanChar == "D") return 500;
        if (romanChar == "M") return 1000;
        revert("Invalid Roman character");
    }
}
