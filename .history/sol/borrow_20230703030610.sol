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
        BORROWED,
        PAID_BACK,
        OVERDUE
    }

    struct UserBorrowInfo {
        address _usersAddress;
        address _tokenReceiveFromUser;
        string _tokenReceiveNameUser;
        address _tokenPaymentFromContract;
        uint256 _amountPaidByUser;
        uint256 _amountToReceiveFromContract;
        int224 _priceOfToken;
        uint256 _borrowTime;
        uint256 _paybackTime;
        uint256 _tokenMinted;
        BorrowStatus _paymentStatus;
    }

    event SetProxy(address token, address proxy);
    event SetBaseContract(address newContract);
    event SetDeadline(uint256 newDeadine);
    event SetBorrowPercent(uint256 _newPercentage);
    event BorrowAmount(
        uint256 _amountPaidByContract,
        uint256 _amountPaidByUser
    );
    event RepayBorrow(
        uint256 _amountPaidByContract,
        uint256 _amountPaidByUsers
    );

    uint256 max_borrowPercentage = 70;
    uint256 totalPercentage = 100;
    uint256 max_deadlineDate = 1 days;
    address baseContractProxy = 0x26690F9f17FdC26D419371315bc17950a0FC90eD;
    address baseContractAddress = 0x75A61E17f0A354180817A6B45D4470B61F3FDfD6;
    uint256 immutable PRICE_DECIMAL = 1E18;
    uint256 public serviceCharge = 23 * 1E4;
    uint256 public immutable ONE_ETH_VALUE = 1E18;
    mapping(address => UserBorrowInfo) public usersBorrowData;
    UserBorrowInfo[] public usersInfo;
    mapping(address => address) public _tokenContractandProxyStore;

    constructor() ERC721("Holder Token", "HTN") {}

    function setTokenContractAndProxy(
        address _tokenContract,
        address _proxyContract
    ) public {
        _tokenContractandProxyStore[_tokenContract] = _proxyContract;
        emit SetProxy(_tokenContract, _proxyContract);
    }

    function setBaseContractAddress(address _newBaseContractAddress) external {
        baseContractAddress = _newBaseContractAddress;
        emit SetBaseContract(_newBaseContractAddress);
    }

    function setDeadline(uint256 _newDays)
        external
        returns (uint256 newDeadline)
    {
        max_deadlineDate = _newDays;
        newDeadline = max_deadlineDate;
        emit SetDeadline(_newDays);
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

    function setBorrowPercentage(uint256 _newPercentage)
        external
        returns (uint256 newPercentage)
    {
        max_borrowPercentage = _newPercentage;
        newPercentage = max_borrowPercentage;
        emit SetBorrowPercent(_newPercentage);
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
        require(
            _tokenContractandProxyStore[tokenContractAddress] ==
                _tokenAddressProxy,
            "Token address does not match"
        );
        require(_userAmount > 0, "amount can not be zero");
        (int224 basePrice, ) = getBaseContractProxyPrice();
        uint256 _basePrice = SafeCast.toUint256(basePrice);
        uint256 _baseAmount = getBaseContractBalance();
        (int224 tokenPrice, ) = getAllTokenPriceProxy(_tokenAddressProxy);
        uint256 _tokenPrice = SafeCast.toUint256(tokenPrice);
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
        uint256 convertBasePrice = (_basePrice / PRICE_DECIMAL);
        uint256 convertTokenPrice = (_tokenPrice / PRICE_DECIMAL);
        uint256 priceDifference = (convertTokenPrice / convertBasePrice);
        uint256 baseAmount = ((ONE_ETH_VALUE * priceDifference) * _userAmount);
        uint256 paymentRatio = (max_borrowPercentage / totalPercentage);
        uint256 contractSendingAmount = baseAmount * paymentRatio;
        _paymentAmount = contractSendingAmount;
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

    function borrowToken(
        uint256 amount,
        address tokenAddress,
        address tokenProxy
    ) public {
        require(msg.sender != address(0), "address can not be null");
        require(
            usersBorrowData[msg.sender]._paymentStatus ==
                BorrowStatus.UNBORROWED,
            "current user is not allowed to again from this pair"
        );
        require(
            _tokenContractandProxyStore[tokenAddress] == tokenProxy,
            "token contract does not match"
        );
        require(amount > 0, " amount too low");
        uint256 _paymentAmount = getBalanceSendRatio(
            amount,
            tokenAddress,
            tokenProxy
        );
        ERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        ERC20(baseContractAddress).transfer(msg.sender, _paymentAmount);

        (int224 tokenPrice, ) = getAllTokenPriceProxy(tokenProxy);

        uint256 currentTokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, currentTokenId);
        string memory tokenName = ERC20(tokenAddress).symbol();

        usersBorrowData[msg.sender] = UserBorrowInfo(
            msg.sender,
            tokenAddress,
            tokenName,
            baseContractAddress,
            amount,
            _paymentAmount,
            tokenPrice,
            block.timestamp,
            (block.timestamp + max_deadlineDate),
            currentTokenId,
            BorrowStatus.BORROWED
        );

        usersInfo.push(
            UserBorrowInfo(
                msg.sender,
                tokenAddress,
                tokenName,
                baseContractAddress,
                amount,
                _paymentAmount,
                tokenPrice,
                block.timestamp,
                (block.timestamp + max_deadlineDate),
                currentTokenId,
                BorrowStatus.BORROWED
            )
        );
        emit BorrowAmount(_paymentAmount, amount);
    }

    function checkBorrowStatus(address _usersAddress)
        public
        returns (string memory)
    {
        require(
            ((usersBorrowData[_usersAddress]._usersAddress == _usersAddress) &&
                (usersBorrowData[_usersAddress]._paymentStatus ==
                    BorrowStatus.BORROWED)),
            "status not Borrowed"
        );
        if (usersBorrowData[_usersAddress]._paybackTime > block.timestamp) {
            return ("Still some time to pay amount borrowed");
        }
        UserBorrowInfo storage _usersBorrow = usersBorrowData[_usersAddress];
        _usersBorrow._paymentStatus = BorrowStatus.OVERDUE;
        return ("time has elapsed. Fund payback window is closed");
    }

    function repayBorrowedAmount(address _usersAddress) public {
        require(
            ((usersBorrowData[_usersAddress]._usersAddress == msg.sender) &&
                (usersBorrowData[_usersAddress]._paymentStatus ==
                    BorrowStatus.BORROWED)),
            "status not Borrowed"
        );
        require(
            usersBorrowData[_usersAddress]._paybackTime > block.timestamp,
            "payback time has elapsed. funds can not be sent"
        );
        UserBorrowInfo storage _usersBorrow = usersBorrowData[_usersAddress];

        uint256 usersPaidAmount = _usersBorrow._amountPaidByUser;
        address userTokenPaidWith = _usersBorrow._tokenReceiveFromUser;
        uint256 amountPaidByContract = (_usersBorrow
            ._amountToReceiveFromContract - serviceCharge);
        ERC20(baseContractAddress).transferFrom(
            msg.sender,
            address(this),
            amountPaidByContract
        );
        ERC20(userTokenPaidWith).transfer(msg.sender, usersPaidAmount);

        _usersBorrow._paymentStatus = BorrowStatus.PAID_BACK;

        //   usersInfo
        for (uint256 i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i]._usersAddress == _usersAddress) {
                usersInfo[i]._paymentStatus = BorrowStatus.PAID_BACK;
            }
        }
        emit RepayBorrow(amountPaidByContract, usersPaidAmount);
    }
}
