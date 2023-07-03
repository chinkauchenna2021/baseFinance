// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@api3/contracts/v0.8/interfaces/IProxy.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BorrowToken is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    address private proxyAddress;
    IERC20 private _ierc20;
    enum BorrowStatus {
        UNBORROWED,
        BORROWED_PART,
        BORROWED_COMPLETE,
        PAID_BACK,
        NOT_PAID_BACK,
        OVERDUE
    }

    struct UserBorrowInfo {
        address _usersAddress;
        address _tokenReceiveFromUser;
        string  _tokenReceiveNameUser;
        string _tokenPaymentNameContract ;
        address _tokenPaymentFromContract;
        uint256 _amountPaidByUser;
        uint256 _amountToReceiveFromContract;
        uint224 _priceOfToken;
        uint _borrowTime;
        uint _paybackTime;
        BorrowStatus _paymentStatus;
    }

     mapping(address => UserBorrowInfo) public usersBorrowData;
     UserBorrowInfo[] public usersInfo;
    constructor() ERC721("Holder Token", "HTN") {}
    //    function safeMint(address to) public onlyOwner {
    //     uint256 tokenId = _tokenIdCounter.current();
    //     _tokenIdCounter.increment();
    //     _safeMint(to, tokenId);
    // }

    //   function readDataFeed()
    //     external
    //     view
    //     returns (int224 value, uint256 timestamp)
    // {
    // Use the IProxy interface to read a dAPI via its
    // proxy contract .
    // (value, timestamp) = IProxy(proxyAddress).read();
    // If you have any assumptions about `value` and `timestamp`,
    // make sure to validate them after reading from the proxy.
    // }
}
