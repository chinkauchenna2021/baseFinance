pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract USDCToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("USDC Token", "USDC") {
        _mint(msg.sender, 1000000000000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

   function decimals() public pure override returns (uint8){
    return 6;
   }
  
