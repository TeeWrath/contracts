// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.19;

contract Ballot{

    // struct containing details of a voter
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    // struct containing details of a proposal
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    // address of the chairperson, who can delegate votes
    address public chairperson;

    mapping (address => Voter) voters ;

    Proposal[] public proposals ;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        for(uint i =0; i< proposalNames.length ; i++) {
            proposals.push(Proposal({
                name : proposalNames[i],
                voteCount : 0
            }));
        }
    }

    function giveRightToVote( address voter) external {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter has already voted."
        );
        require(voters[voter].weight ==0);
        voters[voter].weight = 1;        
    }
}