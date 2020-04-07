
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
  let manager;
  const lender = accounts[1]; // the guy that has the tool and offers it
  const borrower = accounts[2]; // the guy that wants the tool to do something

  beforeEach(async () => {
  	cUSD = await CUSD.new();
  	tools = await ToolsToken.new();
    manager = await Manager.new(tools.address, cUSD.address);
  });

  it('should allow to borrow and return', async () => {
  	// mint a token to lender
  	const tokenId = 1;
  	await tools.mint(lender, tokenId);

  	// ## publish:
  	// owner sets details (item has description and price)
  	await tools.setValue(tokenId, 100, {from: lender});
  	// owner approves token to manager (token can be rented)
  	await tools.approve(manager.address, tokenId, {from: lender});

  	// ## request:
  	// borrower approves token to manager
  	// borrower creates request
  	  // - cUSD(fee + contribution + stake) are pulled into manager
  	  // - event is emited for borrower to see

  	// ## cancelRequest:
  	  // borrower cancels a request that hasn't been confirmed yet
  	  // - cUSD returned to borrower

  	// ## confirm:
  	// lender sends confirmation(issueId) + signature of borrower for receival
  	  // - borrower is entered as appropriator
  	  // - an event is emitted with IssueId

  	// return:
  	// borrower send return + signature of lender for receival
  	  // - owner is set as appropriator on token
  	  // - fee is paid to borrower
  	  // - contribution is paid to community
  	  // - stake is returned to borrower
  	  // - an event is emitted with IssueId

  	// returnChallenge:
  	// a challenge is opened by lender or borrower

  	// returnResolve:
  	  // - token is either burner or returned
  	  // - fee is either paid or not
  	  // - stake is split in certain proportion

    
  });

});