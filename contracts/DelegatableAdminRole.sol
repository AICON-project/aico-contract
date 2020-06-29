pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
/**
 * @title DelegatableAdminRole
 * @dev DelegatableAdmins are responsible for assigning and removing Whitelisted accounts.
 */
contract DelegatableAdminRole is Context {
    using Roles for Roles.Role;

    event DelegatableAdminAdded(address indexed account);
    event DelegatableAdminRemoved(address indexed account);

    Roles.Role private _DelegatableAdmins;

    constructor () internal {
        _addDelegatableAdmin(_msgSender());
    }

    modifier onlyDelegatableAdmin() {
        require(isDelegatableAdmin(_msgSender()), "DelegatableAdminRole: caller does not have the DelegatableAdmin role");
        _;
    }

    function isDelegatableAdmin(address account) public view returns (bool) {
        return _DelegatableAdmins.has(account);
    }

    function addDelegatableAdmin(address account) public onlyDelegatableAdmin {
        _addDelegatableAdmin(account);
    }

    function renounceDelegatableAdmin() public {
        _removeDelegatableAdmin(_msgSender());
    }

    function _addDelegatableAdmin(address account) internal {
        _DelegatableAdmins.add(account);
        emit DelegatableAdminAdded(account);
    }

    function _removeDelegatableAdmin(address account) internal {
        _DelegatableAdmins.remove(account);
        emit DelegatableAdminRemoved(account);
    }
}
