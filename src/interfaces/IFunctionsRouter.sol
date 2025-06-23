// src/interfaces/IFunctionsRouter.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// A minimal interface for the Chainlink Functions Router
interface IFunctionsRouter {
    // We need to define the Subscription struct that getSubscription returns
    struct Subscription {
        uint96 balance;
        address owner;
        uint96 blockedBalance;
        address proposedOwner;
        address[] consumers;
        bytes32 flags;
    }

    // Function to get subscription details
    function getSubscription(uint64 subscriptionId) external view returns (Subscription memory);

    // Function to create a new subscription
    function createSubscription() external returns (uint64 subscriptionId);
}
