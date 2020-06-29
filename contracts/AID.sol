pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "./BlackListRole.sol";
import "./DelegatableRole.sol";
import "./LockableToken.sol";

contract AID is LockableToken,ERC20Detailed,Ownable,ERC20Mintable,ERC20Burnable,ERC20Pausable,BlacklistedRole{

    using SafeMath for uint256;

    constructor(string memory name, string memory symbol, uint8 decimals, uint256 totalSupply)
    ERC20Detailed(name, symbol, decimals)
    public {
        _mint(owner(), totalSupply * 10**uint(decimals));
    }

    function transfer(address to, uint256 value) public whenNotPaused whenNotBlacklisted returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public whenNotPaused whenNotBlacklisted returns (bool) {
        return super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value) public whenNotPaused whenNotBlacklisted returns (bool) {
        return super.approve(spender, value);
    }

    function increaseAllowance(address spender, uint256 addedValue) public whenNotPaused whenNotBlacklisted returns (bool) {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public whenNotPaused whenNotBlacklisted returns (bool) {
        return super.decreaseAllowance(spender, subtractedValue);
    }
}