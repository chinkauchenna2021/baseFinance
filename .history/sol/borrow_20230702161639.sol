// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@api3/contracts/v0.8/interfaces/IProxy.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract BorrowToken is ERC721, ERC721Burnable, Ownable {
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

    enum BorrowStat{
       BORROWED,
       NOT_PAIDBACK,
       PAIDBACK
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
  struct UsersBorrowedStatistics{
      address user;
      uint usersAmount;
      uint usersMintedToken;
      address tokenContract;
      uint baseContractPayBack;
      BorrowStat _usersPaymentStatus;

  }


    uint max_borrowPercentage = 70;
    uint totalPercentage = 100;
    uint256 max_deadlineDate = 1 days;
    address baseContractProxy = 0x26690F9f17FdC26D419371315bc17950a0FC90eD;
    address baseContractAddress =0x5fB4456e1820587A0707e72B48e3eA2b793CC7B9;
    uint immutable PRICE_DECIMAL   = 1E18;
    uint public immutable ONE_ETH_VALUE = 1E18 ;
    mapping(address => uint256) public _baseEthPrice;
    mapping(address => UserBorrowInfo) public usersBorrowData;
    UserBorrowInfo[] public usersInfo;
    mapping(address => address) public _tokenContractandProxyStore;
    UsersBorrowedStatistics[] public _usersReceivetokenStat;

    constructor() ERC721("Holder Token", "HTN") {}

function setTokenContractAndProxy(address _tokenContract , address _proxyContract) public {
     _tokenContractandProxyStore[_tokenContract] = _proxyContract ;
}



    function setBaseContractAddress(address _newBaseContractAddress) external {
        baseContractAddress = _newBaseContractAddress;
    }

    function setDeadline(uint256 _newDays)
        external
        returns (uint256 newDeadline)
    {
        max_deadlineDate = _newDays;
        newDeadline = max_deadlineDate;
    }

    function getBaseContractProxyPrice()
        public
        view
        returns (int224 basePrice, uint256 baseTimeStamp)
    {
        (basePrice, baseTimeStamp) = IProxy(baseContractProxy).read();
    }

    function getBaseContractBalance()
        public
        view
        returns (uint256 _baseAmount)
    {
        _baseAmount = ERC20(baseContractAddress).balanceOf(address(this));
    }

    function getBaseContractBalancesforallTokens(address _tokenAddress)
        external
        view
        returns (uint256 _tokenAmount)
    {
        _tokenAmount = ERC20(_tokenAddress).balanceOf(address(this));
    }

    function setBorrowPercentage(uint _newPercentage)
        external
        returns (uint newPercentage)
    {
        max_borrowPercentage = _newPercentage;
        newPercentage = max_borrowPercentage;
    }

    function getAllTokenPriceProxy(address _spacificTokenProxyAddress)
        public
        view
        returns (int224 tokenPrice, uint256 tokenTimeStamp)
    {
        (tokenPrice, tokenTimeStamp) = IProxy(_spacificTokenProxyAddress)
            .read();
    }

    function getBalanceSendRatio(
        uint256 _userAmount,
        address tokenContractAddress,
        address _tokenAddressProxy
    ) public view returns (uint256 _paymentAmount) {
        require(_tokenContractandProxyStore[tokenContractAddress] == _tokenAddressProxy , "Token address does not match");
        require(_userAmount > 0, "amount can not be zero");
        (int224 basePrice, ) = getBaseContractProxyPrice();
        uint _basePrice = SafeCast.toUint256(basePrice);
        uint256 _baseAmount = getBaseContractBalance();
        (int224 tokenPrice, ) = getAllTokenPriceProxy(_tokenAddressProxy);
        uint _tokenPrice = SafeCast.toUint256(tokenPrice);
        require(_baseAmount > uint256(0), "contract balance is low");
        uint256 _usersAccountBalance = ERC20(tokenContractAddress).balanceOf(
        msg.sender
        );
        require(_usersAccountBalance > 0, "users has zero balance");
        require(
            _usersAccountBalance > _userAmount,
            "Amount Entered is greater balance"
        );


        //calculate the price differece of tokens;
        // int224 basePriceConversion = ( (tokenPrice )/basePrice) * ;
       uint convertBasePrice = (_basePrice /  PRICE_DECIMAL);
       uint  convertTokenPrice = (_tokenPrice /  PRICE_DECIMAL);
       uint priceDifference = (convertTokenPrice / convertBasePrice);
       uint baseAmount = ((ONE_ETH_VALUE * priceDifference) * _userAmount);
       uint paymentRatio = (max_borrowPercentage / totalPercentage);
       uint contractSendingAmount = baseAmount * paymentRatio;
       _paymentAmount = contractSendingAmount ;
    }

    function baseETHPrice(address _baseEthProxyContract)
        external
        view
        returns (int224 EthPrice, uint256 EthTime)
    {
        // Use the IProxy interface to read a dAPI via its
        // proxy contract .
        (EthPrice, EthTime) = IProxy(_baseEthProxyContract).read();
    }


    function borrowToken(uint amount , address tokenAddress , address tokenProxy) public  {
        require(msg.sender != address(0), "address can not be null");
        require(_tokenContractandProxyStore[tokenAddress] == tokenProxy , "token contract does not match");
        require(amount > 0 , " amount too low");
       (uint _paymentAmount) =  getBalanceSendRatio(amount , tokenAddress , tokenProxy);
      ERC20(tokenAddress).transferFrom(msg.sender , address(this) , amount );


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
