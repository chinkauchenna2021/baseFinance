// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@api3/contracts/v0.8/interfaces/IProxy.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

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
    int224 max_borrowPercentage = 70;
    int224 totalPercentage = 100;
    uint256 max_deadlineDate = 1 days;
    address baseContractProxy = 0x26690F9f17FdC26D419371315bc17950a0FC90eD;
    address baseContractAddress = address(0);
    int224 immutable PRICE_DECIMAL   = 1E18;
    int224 public immutable ONE_ETH_VALUE = 1E18 ;
    mapping(address => uint256) public _baseEthPrice;
    mapping(address => UserBorrowInfo) public usersBorrowData;
    UserBorrowInfo[] public usersInfo;
    mapping(address => address) public _approvedProxy;

    constructor() ERC721("Holder Token", "HTN") {}


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

    function setBorrowPercentage(int224 _newPercentage)
        external
        returns (int224 newPercentage)
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
    ) public view returns (int224 _paymentAmount) {
        require(_userAmount > uint256(0), "amount can not be zero");
        (int224 basePrice, ) = getBaseContractProxyPrice();
        uint256 _baseAmount = getBaseContractBalance();
        (int224 tokenPrice, ) = getAllTokenPriceProxy(_tokenAddressProxy);
        require(_baseAmount > uint256(0), "contract balance is low");
        uint256 _usersAccountBalance = ERC20(tokenContractAddress).balanceOf(
            msg.sender
        );
        require(_usersAccountBalance > uint256(0), "users has zero balance");
        require(
            _usersAccountBalance > _userAmount,
            "Amount Entered is greater balance"
        );
        
        //calculate the price differece of tokens;
        // int224 basePriceConversion = ( (tokenPrice )/basePrice) * ;
       int224 convertBasePrice = (basePrice /  PRICE_DECIMAL);
       int224 convertTokenPrice = (tokenPrice /  PRICE_DECIMAL);
       int224 priceDifference = (convertTokenPrice / convertBasePrice);
       int224 baseAmount = (ONE_ETH_VALUE * priceDifference);
       int224 paymentRatio = (max_borrowPercentage / totalPercentage);
       int224 contractSendingAmount = baseAmount * paymentRatio;
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

    function borrowToken(address _token) public view {
        require(msg.sender != address(0), "address can not be null");
        require(
            _approvedProxy[_token] != address(0),
            "this token is not available for borrowing"
        );
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
