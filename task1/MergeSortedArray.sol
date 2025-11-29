// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    function mergeSortedArray(
        uint256[] memory arr1,
        uint256[] memory arr2
    ) public pure returns (uint256[] memory) {
        uint256 m = arr1.length;
        uint256 n = arr2.length;

        // 创建结果数组
        uint256[] memory result = new uint256[](m + n);

        uint256 i = 0; // arr1 的指针
        uint256 j = 0; // arr2 的指针
        uint256 k = 0; // result 的指针

        // 合并两个数组，直到其中一个遍历完
        while (i < m && j < n) {
            if (arr1[i] <= arr2[j]) {
                result[k] = arr1[i];
                i++;
            } else {
                result[k] = arr2[j];
                j++;
            }
            k++;
        }

        // 将 arr1 剩余的元素添加到结果中
        while (i < m) {
            result[k] = arr1[i];
            i++;
            k++;
        }

        // 将 arr2 剩余的元素添加到结果中
        while (j < n) {
            result[k] = arr2[j];
            j++;
            k++;
        }

        return result;
    }
}
