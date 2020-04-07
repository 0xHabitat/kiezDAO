/* eslint-disable import/no-extraneous-dependencies */
require('dotenv').config();

const HDWalletProvider = require('truffle-hdwallet-provider');

const { XDAI_MNEMONIC } = process.env;

module.exports = {
  // Configure your compilers
  compilers: {
    solc: {
      version: '0.5.16',
      settings: {
        optimizer: {
          enabled: true,
          runs: 100,
        },
      },
    },
  },
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*' // match any network
    },
    alfajores: {
      host: "127.0.0.1",
      port: 8545,
      network_id: 44786
    }
  }
}