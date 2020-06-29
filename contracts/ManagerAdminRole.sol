pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
/**
 * @title ManagerAdminRole
 * @dev ManagerAdmins are responsible for assigning and removing Whitelisted accounts.
 */
contract ManagerAdminRole is Context {
    using Roles for Roles.Role;

    event ManagerAdminAdded(address indexed account);
    event ManagerAdminRemoved(address indexed account);

    Roles.Role private _ManagerAdmins;

    constructor () internal {
        _addManagerAdmin(_msgSender());
    }

    modifier onlyManagerAdmin() {
        require(isManagerAdmin(_msgSender()), "ManagerAdminRole: caller does not have the ManagerAdmin role");
        _;
    }

    function isManagerAdmin(address account) public view returns (bool) {
        return _ManagerAdmins.has(account);
    }

    function addManagerAdmin(address account) public onlyManagerAdmin {
        _addManagerAdmin(account);
    }

    function renounceManagerAdmin() public {
        _removeManagerAdmin(_msgSender());
    }

    function _addManagerAdmin(address account) internal {
        _ManagerAdmins.add(account);
        emit ManagerAdminAdded(account);
    }

    function _removeManagerAdmin(address account) internal {
        _ManagerAdmins.remove(account);
        emit ManagerAdminRemoved(account);
    }
}
