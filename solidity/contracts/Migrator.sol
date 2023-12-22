// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import {Auth,Authority} from 'isolmate/auth/Auth.sol';
import {IERC20} from 'isolmate/interfaces/tokens/IERC20.sol';

contract ZoomerMigrator is Auth {
  IERC20 public immutable OLD_ZOOMER;
  IERC20 public immutable NEW_ZOOMER;

  constructor(address _oldZoomer, address _newZoomer) Auth(msg.sender, Authority(address(0))) {
    OLD_ZOOMER = IERC20(_oldZoomer);
    NEW_ZOOMER = IERC20(_newZoomer);
  }

  function migrate() external {
    uint256 _amount = OLD_ZOOMER.balanceOf(msg.sender);
    OLD_ZOOMER.transferFrom(msg.sender, address(this), _amount);
    NEW_ZOOMER.transfer(msg.sender, _amount);
  }

  function migrate(uint256 _amount) external {
    require(_amount > 0, 'ZoomerMigrator: amount must be greater than 0');

    OLD_ZOOMER.transferFrom(msg.sender, address(this), _amount);
    NEW_ZOOMER.transfer(msg.sender, _amount);
  }
}
