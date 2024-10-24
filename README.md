# Decentralized Logistics Smart Contract with EAS Integration

## Overview

This project implements a decentralized logistics system using smart contracts on the Ethereum blockchain, integrating with the Ethereum Attestation Service (EAS). The goal is to create a verifiable, trust-minimized logistics process where packages can be tracked through various stages, and critical actions are verified through on-chain attestations.

The contract allows a sender, courier, and receiver to interact in a secure, transparent manner, ensuring that packages are handled as specified. It uses EAS to validate key conditions through attestations, such as package condition, role verification, and payment confirmation.

## Features

- **Role-Based Workflow**: Different roles (sender, courier, receiver) interact with the contract at different stages.
- **EAS Integration**: Uses Ethereum Attestation Service to validate actions and conditions at key points in the logistics process.
- **Payment Handling**: Supports escrow-like functionality where payment is held until conditions are met.
- **State Management**: Manages the state of the logistics process through various stages (e.g., Created, Approved, Shipping).

## Prerequisites

- **Solidity** ^0.8.0
- **Remix IDE** for smart contract development and deployment
- **MetaMask** wallet configured with Sepolia Testnet
- **Sepolia ETH** from a faucet for test deployments

## Smart Contract Structure

### Contract: `LogisticsContract`
- **Role**: Manages the logistics process, allowing a sender to initiate a package shipment, a courier to handle the package, and a receiver to confirm delivery.
- **State Flow**:
  - `Created`: The initial state when the contract is deployed.
  - `TrustSetup`: After the sender sets up trust conditions.
  - `KeyShared`: After the sender shares verification keys.
  - `DepositMade`: After the sender deposits payment.
  - `PackageSent`: After the courier receives the package.
  - `Approved`: After the package is verified through EAS.
  - `Shipping`: After the courier begins the shipment process.
  - `Completed`: After the shipment is confirmed as complete.
  - `Cancelled`: If the contract is cancelled before completion.
- **EAS Integration**: Uses EAS for verifying attestations, such as verifying the courier's role or package conditions.

## Schema for EAS

The attestation schema used in this contract includes the following fields:

- `role` (string): The role of the attestor (e.g., "courier").
- `condition` (string): The condition of the package (e.g., "intact").
- `weight` (int256): Weight of the package.
- `length` (int256): Length of the package.
- `width` (int256): Width of the package.
- `height` (int256): Height of the package.
- `inspectionNotes` (string): Notes from the package inspection.
- `verifier` (address): Address of the entity verifying the package.
- `timestamp` (int256): The time the attestation was made.
- `trackingNumber` (string): Unique tracking number for the package.
- `status` (string): Current status of the package (e.g., "in transit").
- `paymentConfirmed` (bool): Indicates if payment has been confirmed.
- `paymentAmount` (int256): Amount paid for the logistics service.

## Setup and Deployment

```bash
git clone https://github.com/your-repository/logistics-contract.git
cd logistics-contract


## Citation


Balfaqih, M.; Balfagih, Z.; Lytras, M.D.; Alfawaz, K.M.; Alshdadi, A.A.; Alsolami, E. A Blockchain-Enabled IoT Logistics System for Efficient Tracking and Management of High-Price Shipments: A Resilient, Scalable and Sustainable Approach to Smart Cities. Sustainability 2023, 15, 13971. https://doi.org/10.3390/su151813971
