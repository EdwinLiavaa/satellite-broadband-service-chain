# Blockchain/Chainlink : Satellite Broadband Supply Chain

## Inspiration

This project was inspired by the vision:

* Enabling Satellite Broadband Opertors in providing connectivity to people in remote underserved communities.

## What it does

It is an attempt to automate all manual processes in the Satellite Broadband Supply Chain by replacing paper contracts with hybrid smart contracts across synergies from suppliers/vendors, finance, sales, logistics with assets tracking to both partners and end users.

Moreover, this project will enable a DeFi payment gateway for the remote Pacific Islands communities and also bridge the gap in the digital divide that is not provided by the existing banking infrastructure.

It demonstrates the journey of both equipment and bandwidth on blockchain augmented by the use of the Chainlink oracle to connect to off-chain data feeds.

The Satellite Broadband Supply Chain is the sequence of activities and processes involved in shipping equipment from suppliers/vendors to the broadband satellite operator. The satellite operator then package them together with broadband solutions to serve telecommunications operators, internet service providers, governments, other service providers and end users.

In summary, this project will benefit all stakeholders with empowerment of cryptographic truth to ensure definitive truth in providing connectivity to the underserved communities.

#### Problems in Existing System
---
- Shipment visibility
- Weather visibility
- Slow process and error prone paper contracts
- Delays in coordination
- Overdue invoices and payment issues
- Lack of payment gateways

#### What Blockchain and Chainlink are providing
---
- Accurate information across the entire chain at any point and at any location
- Instant access to real-time updates and alerts if issues are detected
- Instant access to real-time off-chain data feeds on price, weather and marine traffic
- Visibility of all handovers in the supply chain
- Traceability from source to destination of equipment
- Traceability from source to destination of bandwidth
- Seamless collaboration between all parties
- Reduce paper work and speed up processes with automation
- Avoid overdue invoices and payment issues
- Provision of a payment gateway

#### Roles
---
1. **Admin** - new users registrations, assign access rights according to their roles.
2. **Supplier** - supply equipment, create new batch for purchase order details from Operator.  
3. **Shipper** - responsible for shipping supply batches from Supplier to Operator, from Operator to Partner and from Partner to EndUser.
4. **Operator** - responsible for odering equipment batches from Supplier, process requests for both equipment hand bandwidth from Partner, update equipment details, quantity, validate quality and invoicing Partner.
5. **Partner** - reponsible for both equipment and bandwidth distribution, installations, activations and revenue collection from EndUser. 
6. **EndUser** - reponsible for equipment safety, varification of equipment condition, validation of bandwidth quality and pay bandwidth subscription to Partner. 

#### Application Workflow Diagram
---
![](https://github.com/FidelChe/satellite-broadband-supply-chain/blob/master/workflow/Satellite%20Broadband%20Supply-Chain%20Class%20Workflow.png)

#### Tools and Technologies
---
- Solidity  
- Chainlink
- Hardhat
- Metamask 
- Kovan test network 
- Web3JS

#### Prerequisites
---
- Nodejs v14.17.6
- Npm v7.24.0
- Yarn v1.22.5
- npx 7.24.0
- Solidity 0.7.3 or above
- Metamask

#### Dependencies
---
- hardhat-ethers ^2.0.2
- hardhat-waffle ^2.0.1
- chai ^4.3.4
- dotenv ^10.0.0
- ethereum-waffle ^3.4.0
- ethers 5.4.7
- hardhat 2.6.4

#### Contract Deployment Steps:
---
**Setting up Ethereum Smart Contract:**

**Setting up Hedera Smart Contract:**

**Setting up Solana Smart Contract:**
