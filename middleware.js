const { ethers } = require("ethers");
const abi = require("./LogisticsContractABI.json");

// Connect to Ethereum
const provider = new ethers.providers.JsonRpcProvider(process.env.INFURA_SEPOLIA_URL);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

// LogisticsContract deployed address
const contractAddress = "0xYourContractAddress";
const logisticsContract = new ethers.Contract(contractAddress, abi, wallet);

async function updateStatus(orderId, newStatus) {
    try {
        // Call the smart contract function to update the status
        const tx = await logisticsContract.updateStatusFromFleetBase(newStatus);
        await tx.wait();
        console.log(`Status for order ${orderId} updated to ${newStatus} on the blockchain.`);
    } catch (error) {
        console.error("Error updating status:", error);
    }
}
