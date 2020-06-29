let AID = artifacts.require("AID");

module.exports = function(deployer) {
  deployer.deploy(AID,"AICON","AICO",8,500000000);
};
