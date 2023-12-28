// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from 'forge-std/Script.sol';
import {Greeter} from 'contracts/Greeter.sol';
import {ZoomerMigrator} from 'contracts/ZoomerMigrator.sol';
import {IERC20} from 'isolmate/interfaces/tokens/IERC20.sol';

abstract contract Deploy is Script {
  function _deploy(address _old, address _new) internal {
    vm.startBroadcast();
    new ZoomerMigrator(_old, _new);
    vm.stopBroadcast();
  }
}

contract DeployMainnet is Deploy {
  function run() external {}
}

contract DeployGoerli is Deploy {
  function run() external {}
}

contract DeployPolygon is Deploy {
  function run() external {
    _deploy(0xb2588731d8f6F854037936d6ffac4c13d0b6bd62, 0xB962150760F9A3bB00e3E9Cf48297EE20AdA4A33);
  }
}
