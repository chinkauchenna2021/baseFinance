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
        string _tokenReceiveNameUser;
        address _tokenPaymentFromContract;
        uint256 _amountPaidByUser;
        uint256 _amountToReceiveFromContract;
        uint224 _priceOfToken;
        uint256 _borrowTime;
        uint256 _paybackTime;
        BorrowStatus _paymentStatus;
    }
    uint256 max_borrowPercentage = 70;
    uint max_deadlineDate = 1 days;
    mapping(address => uint) public _baseEthPrice;
    mapping(address => UserBorrowInfo) public usersBorrowData;
    UserBorrowInfo[] public usersInfo;
    mapping(address => address) public _approvedProxy;

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

    function setDeadline(uint _newDays) external returns(uint newDeadline){
       max_deadlineDate = _newDays;
       newDeadline = max_deadlineDate;
    }

function setBorrowPercentage(uint _newPercentage) external returns(uint newPercentage){
   max_borrowPercentage = _newPercentage;
   newPercentage = max_borrowPercentage;
}


function baseETHPrice(address _baseEthProxyContract) public returns(uint224 EthPrice ,uint EthTime){
   


}

    function setToken(address _token, address _proxy)
        public
        onlyOwner
        returns (bool)
    {
        _approvedProxy[_token] = _proxy;

        if (_approvedProxy[_token] == _proxy) {
            return true;
        }
        return false;
    }


function borrowToken(address _token)public {
    require(msg.sender != address(0) , "address can not be null");
    require(_approvedProxy[_token] != address(0) , "this token is not available for borrowing");
   address _getProxy = _approvedProxy[_token];
   string memory token_name = IERC20(_token).name(); 
    //   usersBorrowData[msg.sender] =  UserBorrowInfo(msg.sender , _token , token_name
    //   , 
      
    //   );


  





}
   







}
