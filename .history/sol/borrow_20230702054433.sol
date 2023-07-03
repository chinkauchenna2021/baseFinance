// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@api3/contracts/v0.8/interfaces/IProxy.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BorrowToken is ERC721, ERC721Burnable, Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    address private proxyAddress;
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
        uint256 _tokenMinted;
        BorrowStatus _paymentStatus;
    }
    uint256 max_borrowPercentage = 70;
    uint max_deadlineDate = 1 days;
    address baseContractProxy =0x26690F9f17FdC26D419371315bc17950a0FC90eD;
    address baseContractAddress = address(0);
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

function setBaseContractAddress(address _newBaseContractAddress)external {
    baseContractAddress = _newBaseContractAddress ;
}

    function setDeadline(uint _newDays) external returns(uint newDeadline){
       max_deadlineDate = _newDays;
       newDeadline = max_deadlineDate;
    }


   function getBaseContractProxyPrice()public view returns (int224 basePrice , uint baseTimeStamp){
         (basePrice , baseTimeStamp) = IProxy(baseContractProxy).read();
   }


 function getBaseContractBalance()public view returns(uint _baseAmount){
    _baseAmount = ERC20(baseContractAddress).balanceOf(address(this));
 }

 function getBaseContractBalancesforallTokens(address _tokenAddress)external view returns(uint _tokenAmount){
       _tokenAmount = ERC20(_tokenAddress).balanceOf(address(this));
 }


function setBorrowPercentage(uint _newPercentage) external returns(uint newPercentage){
   max_borrowPercentage = _newPercentage;
   newPercentage = max_borrowPercentage;
}


function baseETHPrice(address _baseEthProxyContract) external  view returns(int224 EthPrice ,uint EthTime){
    // Use the IProxy interface to read a dAPI via its
    // proxy contract .
    ( EthPrice, EthTime) = IProxy(_baseEthProxyContract).read();
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


function borrowToken(address _token)public view {
    require(msg.sender != address(0) , "address can not be null");
    require(_approvedProxy[_token] != address(0) , "this token is not available for borrowing");
//    address _getProxy = _approvedProxy[_token];
//     IERC20(_token); 
    //   usersBorrowData[msg.sender] =  UserBorrowInfo(msg.sender , _token , token_name
    //   , 
      
    //   );

    //     struct UserBorrowInfo {
    //     address _usersAddress;
    //     address _tokenReceiveFromUser;
    //     string _tokenReceiveNameUser;
    //     address _tokenPaymentFromContract;
    //     uint256 _amountPaidByUser;
    //     uint256 _amountToReceiveFromContract;
    //     uint224 _priceOfToken;
    //     uint256 _borrowTime;
    //     uint256 _paybackTime;
    //     uint256 _tokenMinted;
    //     BorrowStatus _paymentStatus;
    // }






}
   







}
