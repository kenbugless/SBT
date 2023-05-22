// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Erc2005 {
    string private _nickName;
    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;
    uint256 private _tokenIdCounter;
    uint256 private _age;
    uint256 private _storeId;

    constructor(string memory nickName_, uint256 age_, uint256 storeId_) {
        _nickName = nickName_;
        _age = age_;
        _storeId = storeId_;
    }

    function nickName() public view returns (string memory) {
        return _nickName;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "non-exist for tokenURI on token");
        return _tokenURIs[tokenId];
    }

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "non-exist for balance on address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "non-exist for the query on token");
        return owner;
    }

    function mint(address to, string memory tokenURI) public returns (uint256) {
        require(to != address(0), "non-exist address to mint");

        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter += 1;

        _owners[tokenId] = to;
        _balances[to] += 1;
        _tokenURIs[tokenId] = tokenURI;

        return tokenId;
    }

    function burn(uint256 tokenId) public {
        address owner = _owners[tokenId];
        require(owner != address(0), "non-exist token to burn");

        delete _owners[tokenId];
        _balances[owner] -= 1;
        delete _tokenURIs[tokenId];
    }

    function isStore() public view returns (bool) {
        return _storeId != 0;
    }

    function storeId() public view returns (uint256) {
     if (_storeId != 0) {
        return _storeId;
    }
    return 0;
}

    function setStoreId(uint256 storeId_) public {
        require(!isStore(), "Can only set  ID once");
        _storeId = storeId_;
    }
}