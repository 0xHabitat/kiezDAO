
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
  	await cUSD.mint(borrower, 120);
  	tools = await ToolsToken.new();
    manager = await Manager.new(cUSD.address, tools.address);
  });

  it('should allow to request and cancel', async () => {
  	// mint a token to lender
  	const toolId = 1;
  	await tools.mint(lender, toolId);

  	// ## publish:
  	// owner sets details (item has description and price)
  	await tools.setValue(toolId, 100, {from: lender});
  	// owner approves token to manager (tool can be rented)
  	await tools.approve(manager.address, toolId, {from: lender});

  	// ## request:
  	// borrower approves cUSD to manager
  	await cUSD.approve(manager.address, 120, {from: borrower});
  	// borrower creates request
  	  // - cUSD(fee + contribution + stake) are pulled into manager
  	  // - event is emited for borrower to see
  	const receipt = await manager.request(toolId, {from: borrower});
  	// todo: check receipt

  	// ## cancelRequest:
  	  // borrower cancels a request that hasn't been confirmed yet
  	  // - cUSD returned to borrower
  	await manager.cancelRequest(toolId, {from: borrower});
    
  });

  it('should allow to borrow and return', async () => {
  	// mint a token to lender
  	const toolId = 1;
  	await tools.mint(lender, toolId);

  	// ## publish:
  	// owner sets details (item has description and price)
  	await tools.setValue(toolId, 100, {from: lender});
  	// owner approves token to manager (tool can be rented)
  	await tools.approve(manager.address, toolId, {from: lender});

  	// ## request:
  	// borrower approves cUSD to manager
  	await cUSD.approve(manager.address, 120, {from: borrower});
  	// borrower creates request
  	  // - cUSD(fee + contribution + stake) are pulled into manager
  	  // - event is emited for borrower to see
  	const receipt = await manager.request(toolId, {from: borrower});
  	// todo: check receipt

  	// ## confirm:
  	// lender sends confirmation(issueId) + signature of borrower for receival
  	  // - borrower is entered as appropriator
  	  // - an event is emitted with IssueId
  	// await manager.confirm(toolId, borrower, lenderSig);

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