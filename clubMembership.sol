// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    address[] public clubMembers;
    mapping(address => bool) isMember;

    function join() public payable {
        require(msg.value == 1 ether, "Joining fee is 1 ether");
        require(!isMember[msg.sender], "You are already a member.");
        clubMembers.push(msg.sender);
        isMember[msg.sender] = true;
    }

    function join_referrer(address payable referrer) public payable {
        require(msg.value == 1 ether, "value is not one ether");
        require(!isMember[msg.sender], "You are already a member.");
        require(isMember[referrer], "referrer is not club member, try joining without referrer");
        clubMembers.push(msg.sender);
        isMember[msg.sender] = true;

        // send reward to referrrer
        uint256 award = 0.1 ether;
        payable(referrer).transfer(award);
    }

    function get_members() public view returns(address[] memory){
        return clubMembers;
    }
    
}
