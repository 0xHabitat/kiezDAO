# KiezDAO Contracts

The Manager Contract connects [cUSD](https://integration-blockscout.celo-testnet.org/tokens/0x095531c4a946623aac5b3a98e4f01701ab25a8e6) and KDT, a ERC721 token contract. KDT tracks tools through of livecycle of (P)ublication, (R)equests, (I)ssuances, (C)alls and (W)ithdrawal.

![KiezDAO - Final State Machine](fsm.png)

## Usage

## publishTool(uint256 toolId, uint256 value)

A lender publishes a tool that can now be borrowed - A tool token is approved to manager contract.
```solidity
function publishTool(uint256 toolId, uint256 value) public {}
```

### Example in JS:
```javascript
await tools.approve(manager.address, toolId, {from: lender});
  	// owner sets details (item has description and price)
  	await manager.publishTool(toolId, 100, {from: lender});

```

## withdrawTool(uint256 toolId)

```solidity
function withdrawTool(uint256 toolId) public {
```

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
