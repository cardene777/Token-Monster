// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract TokenMonster is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {

    // =============================================================
    //                           STORAGE
    // =============================================================

    uint256 private _nextTokenId;
    uint256 private _category;
    string private _baseUri;
    uint256 public freeMintEndTime;

    mapping(address => uint256) private _ownedToken;

    // =============================================================
    //                           ERRORS
    // =============================================================

    error CannotMintDuringFreeMintPeriod();
    error EthSentDuringFreeMint();
    error InsufficientEthForSaleMint(uint256 required);
    error AlreadyMinted();
    error NoTokenOwned();

    // =============================================================
    //                           MODIFIERS
    // =============================================================

    modifier notTokenOwnerDuringFreeMint() {
        if (block.timestamp <= freeMintEndTime && balanceOf(msg.sender) > 0) {
            revert CannotMintDuringFreeMintPeriod();
        }
        _;
    }

    // =============================================================
    //                          CONSTRUCTOR
    // =============================================================

    constructor(string memory baseUri, uint256 category, uint256 freeMintDuration)
        ERC721("TokenMonster", "TKM")
        Ownable()
    {
        _baseUri = baseUri;
        _category = category;
        freeMintEndTime = block.timestamp + freeMintDuration;
    }

    // =============================================================
    //                         EXTERNAL WRITE
    // =============================================================

    /// @notice Mint a new token
    /// @dev Mint a new token and set the tokenURI to the baseUri
    /// @dev The tokenURI is a base64 encoded string of the JSON metadata
    /// @dev The JSON metadata is a string of the following format:
    /// @dev "{'name': 'Profile Meme NFT #', 'description': 'Profile Meme NFT', 'image': ''}"
    /// @dev The image is the baseUri followed by the farmonCategory
    /// @dev The farmonCategory is the tokenId modulo the category
    /// @dev The tokenId is incremented for each new token
    function safeMint() public payable notTokenOwnerDuringFreeMint {
        if (_ownedToken[msg.sender] != 0) {
            revert AlreadyMinted();
        }
        if (block.timestamp <= freeMintEndTime) {
            if (msg.value > 0) {
                revert EthSentDuringFreeMint();
            }
        } else {
            uint256 mintPrice = 0.01 ether; // Set the price for minting during the sale period
            if (msg.value < mintPrice) {
                revert InsufficientEthForSaleMint(mintPrice);
            }
        }
        uint256 tokenId = _nextTokenId++;
        uint256 farmonCategory = tokenId % _category;

        string memory metaData = string(
            abi.encodePacked(
                'data:application/json;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "Farmon #',
                            Strings.toString(tokenId),
                            '", "description": "Farmon NFT", "image": "',
                            _baseUri,
                            Strings.toString(farmonCategory),
                            '_farmon.png"}'
                        )
                    )
                )
            )
        );

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, metaData);
        _ownedToken[msg.sender] = tokenId;
    }

    /// @notice Set the base URI for the token
    /// @dev The base URI is the URI for the token image
    /// @dev This is used to set the base URI for the token image
    /// @dev This is used to set the base URI for the token image
    /// @param baseUri The base URI for the token image
    function setBaseUri(string memory baseUri) public onlyOwner {
        _baseUri = baseUri;
    }

    // =============================================================
    //                         INTERNAL VIEW
    // =============================================================

    /// @notice Burn a token
    /// @dev This is used to burn a token
    /// @param tokenId The tokenId of the token to burn
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
        ERC721URIStorage._burn(tokenId);
    }

    // =============================================================
    //                         EXTERNAL VIEW
    // =============================================================

    /// @notice Get the token URI for the token
    /// @dev This is used to get the token URI for the token
    /// @param tokenId The tokenId of the token
    /// @return The token URI for the token
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /// @notice Get the total supply
    function totalSupply() external view returns (uint256) {
        return _nextTokenId;
    }

    /// @notice Get the tokenId of the token owned by the owner
    /// @param owner The owner of the token
    /// @return The tokenId of the token owned by the owner
    function getOwnedToken(address owner) public view returns (uint256) {
        if (balanceOf(owner) == 0) {
            revert NoTokenOwned();
        }
        return _ownedToken[owner];
    }

    /// @notice Supports the interface
    /// @dev This is used to check if the contract supports the interface
    /// @param interfaceId The interfaceId to check
    /// @return True if the contract supports the interface, False otherwise
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
