pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./ManagerAdminRole.sol";

/**
 * @title ManagerRole
 * @dev Manager accounts have been approved by a WhitelistAdmin to perform certain actions (e.g. participate in a
 * crowdsale). This role is special in that the only accounts that can add it are WhitelistAdmins (who can also remove
 * it), and not Managers themselves.
 */
contract ManagerRole is Context, ManagerAdminRole {
    using Roles for Roles.Role;

    event ManagerAdded(address indexed account);
    event ManagerRemoved(address indexed account);

    Roles.Role private _Managers;

    modifier whenManager() {
        require(isManager(_msgSender()), "ManagerRole: caller does not have the Manager role");
        _;
    }

    function isManager(address account) public view returns (bool) {
        return _Managers.has(account);
    }

    function addManager(address account) public onlyManagerAdmin {
        _addManager(account);
    }

    function removeManager(address account) public onlyManagerAdmin {
        _removeManager(account);
    }

    function _addManager(address account) internal {
        _Managers.add(account);
        emit ManagerAdded(account);
    }

    function _removeManager(address account) internal {
        _Managers.remove(account);
        emit ManagerRemoved(account);
    }
}
