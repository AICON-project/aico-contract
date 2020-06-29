pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./DelegatableAdminRole.sol";

/**
 * @title DelegatableRole
 * @dev Delegatable accounts have been approved by a WhitelistAdmin to perform certain actions (e.g. participate in a
 * crowdsale). This role is special in that the only accounts that can add it are WhitelistAdmins (who can also remove
 * it), and not Delegatables themselves.
 */
contract DelegatableRole is Context, DelegatableAdminRole {
    using Roles for Roles.Role;

    event DelegatableAdded(address indexed account);
    event DelegatableRemoved(address indexed account);

    Roles.Role private _Delegatables;

    modifier whenDelegatable() {
        require(isDelegatable(_msgSender()), "DelegatableRole: caller does not have the Delegatable role");
        _;
    }

    function isDelegatable(address account) public view returns (bool) {
        return _Delegatables.has(account);
    }

    function addDelegatable(address account) public onlyDelegatableAdmin {
        _addDelegatable(account);
    }

    function removeDelegatable(address account) public onlyDelegatableAdmin {
        _removeDelegatable(account);
    }

    function _addDelegatable(address account) internal {
        _Delegatables.add(account);
        emit DelegatableAdded(account);
    }

    function _removeDelegatable(address account) internal {
        _Delegatables.remove(account);
        emit DelegatableRemoved(account);
    }
}
