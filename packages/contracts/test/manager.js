
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

const ethUtil = require('ethereumjs-util');
const ToolsToken = artifacts.require('ToolsToken');
const CUSD = artifacts.require('cUSD');
const Manager = artifacts.require('Manager.sol');

contract('KiezDAO Manager', (accounts) => {
  let tools;
  let cUSD;
  let manager;
  const lender = accounts[1]; // the guy that has the tool and offers it
  const lenderPriv = '0x7fb1246f2518c7fcb6b4aa6daecab55b9f1af4e7c5d0f1960225535f13198447';
  const borrower = accounts[2]; // the dude that wants the tool to do something
  const borrowerPriv = '0x2163df75f16c456976d466750f0c65c08f32a6923999dd61adf3c7c5ce2ccd64';
  const community = accounts[3];

  beforeEach(async () => {
  	cUSD = await CUSD.new();
  	await cUSD.mint(borrower, 120);
  	tools = await ToolsToken.new();
    manager = await Manager.new(cUSD.address, tools.address, community);
  });

  it('should allow to request and cancel', async () => {
  	// mint a token to lender
  	const toolId = 1;
  	await tools.mint(lender, toolId);

  	// ## publish:
  	// owner approves token to manager (tool can be rented)
  	await tools.approve(manager.address, toolId, {from: lender});
  	// owner sets details (item has description and price)
  	await manager.publishTool(toolId, 100, {from: lender});

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
  	// owner approves token to manager (tool can be rented)
  	await tools.approve(manager.address, toolId, {from: lender});
  	// owner sets details (item has description and price)
  	await manager.publishTool(toolId, 100, {from: lender});

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
  	  // - an event is emitted with IssueId
  	let buf = Buffer.alloc(32, 0);
  	buf.writeUInt32BE(toolId, 28);
  	let sig = ethUtil.ecsign(buf, Buffer.from(borrowerPriv.replace('0x', '') , 'hex'));
  	await manager.issue(toolId, sig.v, sig.r, sig.s, {from: lender});

  	// return:
  	// borrower send return + signature of lender for receival
  	  // - lender is set as owner on token
  	  // - fee is paid to lender
  	  // - contribution is paid to community
  	  // - stake is returned to borrower
  	  // - an event is emitted with IssueId
  	buf = Buffer.alloc(32, 0);
  	buf.writeUInt32BE(toolId, 28);
  	sig = ethUtil.ecsign(buf, Buffer.from(lenderPriv.replace('0x', '') , 'hex'));
  	await manager.restitute(toolId, sig.v, sig.r, sig.s, {from: borrower});

  	// returnChallenge:
  	// a challenge is opened by lender or borrower

  	// returnResolve:
  	  // - token is either burner or returned
  	  // - fee is either paid or not
  	  // - stake is split in certain proportion

    
  });

});