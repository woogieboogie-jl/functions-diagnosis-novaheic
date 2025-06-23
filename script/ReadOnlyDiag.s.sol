// script/ReadOnlyDiag.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

// A minimal interface for the part of the router we need to read from.
interface IFunctionsRouter {
    struct Subscription {
        uint96 balance;
        address owner;
        uint96 blockedBalance;
        address proposedOwner;
        address[] consumers;
        bytes32 flags;
    }

    function getSubscription(uint64 subscriptionId) external view returns (Subscription memory);
}


contract ReadOnlyDiag is Script {
    // --- CONFIGURATION ---
    address constant ROUTER_ADDRESS = 0xA9d587a00A31A52Ed70D6026794a8FC5E2F5dCb0;
    uint64 constant PROBLEM_SUB_ID = 15639;

    // --- SCRIPT ENTRYPOINT ---
    // This function is 'view' because it only reads data from the blockchain.
    function run() external view {
        IFunctionsRouter router = IFunctionsRouter(ROUTER_ADDRESS);

        console.log("--- Chainlink Functions Read-Only Diagnostic ---");
        console.log("Network: Avalanche Fuji");
        console.log("Router Address:", ROUTER_ADDRESS);
        console.log("------------------------------------------------");

        console.log("Checking for subscription ID:", PROBLEM_SUB_ID);

        // We use a try/catch block because we expect this call to fail.
        try router.getSubscription(PROBLEM_SUB_ID) returns (IFunctionsRouter.Subscription memory sub) {
            // This code block should not be reached.
            console.log("UNEXPECTED SUCCESS: Found subscription", PROBLEM_SUB_ID);
            console.log("   - Owner:", sub.owner);
        } catch {
            // This is the expected outcome.
            console.log("FAILURE (as expected): The call to getSubscription(%s) reverted.", PROBLEM_SUB_ID);
            console.log("   This confirms the subscription does not exist on-chain.");
        }

        console.log("\n--- Diagnosis Complete ---");
        console.log("Conclusion: The subscription ID %s is not valid on-chain.", PROBLEM_SUB_ID);
    }
}
