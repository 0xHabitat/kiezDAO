
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

const ToolsToken = artifacts.require('ToolsToken');
const CUSD = artifacts.require('cUSD');
const Manager = artifacts.require('Manager.sol');

contract('KiezDAO Manager', (accounts) => {
  let tools;
  let cUSD;
  let renting;

  beforeEach(async () => {
  	tools = await ToolsToken.new();
  	cUSD = await CUSD.new();
    renting = await Manager.new(tools, cUSD);
  });

  it('should allow to set owner', async () => {
    await renting.setOwner();

    rsp = await renting.owner();
    assert.equal(rsp, accounts[0]);
  });

});