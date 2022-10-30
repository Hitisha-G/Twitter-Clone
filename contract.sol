// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract TwitterDapp is ERC721("TwitterDApp", "TDAPP") 
{
    uint tokenid;
    tweet[] public tweets;

    struct tweet
    { 
       // uint tweetId;
        string name;
        string description;
        uint upvotes ;
        string[] comments;
        address twAddress;

    }

    function tokenURI(uint _tokenid) public view override returns(string memory)
    {
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name":', '"', tweets[_tokenid].name, '",'  '"description":' , '"',  tweets[_tokenid].description, '"', ',' ,
            
            '"attributes":', '[', '{', '"trait_type":', '"Upvotes",' , '"value":', Strings.toString(tweets[_tokenid].upvotes), '}', ']' , '}'
        );

        return string(abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )

        );
    } 

    function writeTweet(string memory _name, string memory _desc) public 
    {
      //  _safeMint(msg.sender, tokenid);
        tweets.push(tweet({

            name : _name,
            description : _desc,
            upvotes : 0,
            comments : new string[](0),
            twAddress : msg.sender

        })
        );

        tokenid++;
    }

    function upvote(uint _tweetId) public 
    {
        tweets[_tweetId].upvotes+=1;

    }

    function AddComment(uint _tweetId, string memory _comment) public 
    {
        tweets[_tweetId].comments.push(_comment);

    }

    function getAllTweets() public view returns(tweet[] memory)
    {
        return tweets;
    }

}
