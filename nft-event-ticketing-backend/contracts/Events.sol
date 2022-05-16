// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Event is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint private n_tickets; 
    address admin;
    address payable eventCreator;
    string[] private URIs;
    uint unit_price;

    constructor(uint256 _n_tickets, address payable _eventCreator, string[] memory _URIs, uint _unit_price) ERC721("Event", "MTK") {
        n_tickets = _n_tickets;
        eventCreator = _eventCreator;
        admin = msg.sender;
        URIs = _URIs;
        unit_price = _unit_price;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }
    
    function safeMint(address to, string memory uri) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    // Functions that I implemented
    function buyTicket() public payable {
        require(msg.value == unit_price, "You need to pay up!");
        require(_tokenIdCounter.current() <= n_tickets, "No more tickets available!");
        safeMint(msg.sender, URIs[_tokenIdCounter.current()]);
        payable(admin).transfer(uint(msg.value / 10));
        eventCreator.transfer(uint(msg.value * 9 / 10));
    }

    function ticketsLeft() public view returns (uint256) {
        return n_tickets - _tokenIdCounter.current();
    }

}

// ["QmPRhHP4AxxMVPUdM2ZwDrhpooPQ5BYKDMNLSUXurYus6A", 
// "QmQbmPt2ikAvxZaT39cVgCHJ1jyf6M7Bh7eJ7dSuJbzF1c",
// "QmVgs1J36hFWZnopRvo6CiUUPz43XfHFwDxyRMwwyfp9Wv",
// "QmaFUmDkJA8GxGBHaTeQeonXrafjJXqX5Cc2crtCsN6YFt",
// "QmYtsgtmT8RjVmvMB5PD65MeaPYaYSzaDJwEDY5e5wzw1W"]

