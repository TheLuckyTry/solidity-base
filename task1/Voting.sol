// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
 // 存储候选人得票数的mapping
    mapping(string => uint256) private  votes;

      // 存储所有候选人的数组
    string[] private candidates;

      // 记录候选人是否已经存在的mapping
    mapping(string => bool) private candidateExists;

       // 给候选人投票  
     function vote(string memory candidate) public {
         require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        // 如果是新候选人，添加到候选人列表
        if (!candidateExists[candidate]) {
            candidates.push(candidate);
            candidateExists[candidate] = true;
        }
         votes[candidate] = votes[candidate] + 1;
    }
    

     // 获取候选人的得票数
    function getVotes(string memory candidate) public view returns (uint256) {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        return votes[candidate];
    }
    
    // 重置所有候选人的得票数
    function resetVotes() public {
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
    }

}    

