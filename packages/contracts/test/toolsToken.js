
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

const ToolsToken = artifacts.require('ToolsToken');

contract('ToolsToken', (accounts) => {

  describe('Test', () => {
    let token;

    beforeEach(async () => {
      token = await ToolsToken.new();
    });

    it('can mint token with holder', async () => {
      const tokenCount = 1;
      const receipt = await token.mint(accounts[1], tokenCount);
      const { tokenId } = receipt.logs[0].args; // eslint-disable-line no-underscore-dangle
      assert.equal(tokenCount, tokenId);
      const owner = await token.ownerOf(tokenId);
      assert.equal(owner, accounts[1]);
      const proprietor = await token.proprietorOf(tokenId);
      assert.equal(proprietor, accounts[1]);
    });
  });
});