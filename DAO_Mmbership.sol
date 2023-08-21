// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAOMembership {
    address[] public daoMembers;
    address[] public newAppliers;
    mapping(address => uint256) public votesToApplicants;
    mapping(address => bool) public isApplier;
    mapping(address => bool) public isMemberVar;

    constructor () {
        daoMembers.push(msg.sender);
        isMemberVar[msg.sender] = true;
    }

    //To apply for membership of DAO
    function applyForEntry() public {
        require(!isApplier[msg.sender], "");
        require(!isMemberVar[msg.sender], "already a member");
        newAppliers.push(msg.sender);
        votesToApplicants[msg.sender] = 0;
    }
    
    //To approve the applicant for membership of DAO
    function approveEntry(address _applicant) public {
        require(isMemberVar[msg.sender], "You are not a member!");
        votesToApplicants[_applicant] += 1;
        
        uint requiredVotes = (30*daoMembers.length)/100;
        if (votesToApplicants[_applicant] >= requiredVotes){
            daoMembers.push(_applicant);
        }
    }

    //To check membership of DAO
    function isMember(address _user) public view returns (bool) {
        return isMemberVar[_user];
    }

    //To check total number of members of the DAO
    function totalMembers() public view returns (uint256) {
        return uint256(daoMembers.length);
    }
}

