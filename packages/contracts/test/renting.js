const Renting = artifacts.require('./renting.sol');

contract('Renting', (accounts) => {
  let renting;

  beforeEach(async () => {
    renting = await Renting.new();
  });

  it('should allow to set owner', async () => {
    await renting.setOwner();

    rsp = await renting.owner();
    assert.equal(rsp, accounts[0]);
  });

});