# Blockchain/Chainlink : Satellite Broadband Service Chain

<p align="center">
 <img width="1000" src="https://github.com/EdwinLiavaa/satellite-broadband-service-chain/blob/main/pic.png">
</p>

## Inspiration - Vision

  * Providing connectivity to the underserved remote communities with satellite broadband using cryptographic truth.

## What it does

I believe the future of signing up and serving the underserved communities with telco broadband service will be in the form of dynamic NFTs.

It is a futuristic approach proof-of-concept for automating manual processes in the Satellite Broadband Service by replacing paper contracts with hybrid smart contracts across synergies from suppliers/vendors, finance, sales, logistics with assets tracking to both partners and end users.

It demonstrates the journey of solutions in both equipment and bandwidth as dynamic NFTs on blockchain augmented by the use of the Chainlink oracle to connect off-chain data feeds and can also tigger off-chain events.

The Satellite Broadband Service Chain is the sequence of activities and processes involved in shipping equipment from suppliers/vendors to the broadband satellite operator. The satellite operator then package them together with broadband solutions to serve telecommunications operators, internet service providers, governments, other service providers and end users.

Moreover, this project in itself is a DeFi payment gateway for remote underserved communities. It also bridge the gap that is not provided by the existing banking infrastructure.

In summary, this project is the world's first direct to consumer marketplace for satellite broadand solutions and for asset-backed dynamic NFTs. It will benefit all stakeholders with the empowerment of cryptographic truth to ensure definitive truth in providing connectivity to the underserved communities by bridging the geographical boundaries thus aliviating the digital divide and leaving no one behind.

## Components
- [Smart Contracts - Hardhat](https://github.com/EdwinLiavaa/satellite-broadband-service-chain)
- [Front-end - Moralis](https://github.com/EdwinLiavaa/satellite-broadband-service-chain-ui)
- [External Adapter - Google Cloud](https://github.com/EdwinLiavaa/marine-traffic-external-adapter)
- [Chainlink Node - Google Cloud](https://github.com/EdwinLiavaa/marine-traffic-chainlink-node)

#### Problems in Existing System
---
- Shipment visibility
- Weather visibility
- Slow process and error prone paper contracts
- Delays in coordination
- Overdue invoices and payment issues
- Lack of payment gateways for underserved communities

#### What Blockchain and Chainlink are providing
---
- Accurate information across the entire chain at any point and at any location
- Instant access to real-time updates and alerts if issues are detected
- Instant access to real-time off-chain data feeds on price, weather and marine traffic
- Visibility of all handovers in the Service chain
- Traceability from source to destination of solutions i.e. both equipment and bandwidth.
- Seamless collaboration between all parties
- Reduce paper work and speed up processes with automation
- Avoid overdue invoices and payment issues
- Provision of a payment gateway

#### Roles
---
1. **Admin** - new users registrations, assign access rights according to their roles.
2. **Supplier** - Service equipment, create new batch for purchase order details from Operator.  
3. **Transporter** - responsible for shipping Service batches from Supplier to Operator, from Operator to Partner and from Partner to EndUser.
4. **Operator** - responsible for ordering equipment batches from Supplier, process requests for both equipment hand bandwidth from Partner, update equipment details, quantity, validate quality and invoicing Partner.
5. **Partner** - reponsible for both equipment and bandwidth distribution, installations, activations and revenue collection from EndUser. 
6. **EndUser** - reponsible for equipment safety, varification of equipment condition, validation of bandwidth quality and bandwidth subscription to Partner. 

#### Application Workflow Diagram
---
![](https://github.com/EdwinLiavaa/satellite-broadband-service-chain/blob/main/workflow/Workflow.png)

#### Tools and Technologies
---
- Alchemy
- Chainlink
- Ethereum
- Google Cloud
- Hardhat
- Kovan Test Network
- Rinkeby Test Network 
- Metamask
- Infura
- Moralis 
- Openzeppelin
- Solidity 
- Web3JS
- IPFS
- Opensea
- ERC721
- ERC721URIStorage
- node.js
- npm
- yarn
- python3

#### Deployment
- npx hardhat deploy
