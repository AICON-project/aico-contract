pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/access/Roles.sol";
/**
 * @title BlacklistAdminRole
 * @dev BlacklistAdmins are responsible for assigning and removing Whitelisted accounts.
 */
contract BlacklistAdminRole is Context {
    using Roles for Roles.Role;

    event BlacklistAdminAdded(address indexed account);
    event BlacklistAdminRemoved(address indexed account);

    Roles.Role private _BlacklistAdmins;

    constructor () internal {
        _addBlacklistAdmin(_msgSender());
    }

    modifier onlyBlacklistAdmin() {
        require(isBlacklistAdmin(_msgSender()), "BlacklistAdminRole: caller does not have the BlacklistAdmin role");
        _;
    }

    function isBlacklistAdmin(address account) public view returns (bool) {
        return _BlacklistAdmins.has(account);
    }

    function addBlacklistAdmin(address account) public onlyBlacklistAdmin {
        _addBlacklistAdmin(account);
    }

    function renounceBlacklistAdmin() public {
        _removeBlacklistAdmin(_msgSender());
    }

    function _addBlacklistAdmin(address account) internal {
        _BlacklistAdmins.add(account);
        emit BlacklistAdminAdded(account);
    }

    function _removeBlacklistAdmin(address account) internal {
        _BlacklistAdmins.remove(account);
        emit BlacklistAdminRemoved(account);
    }
}
