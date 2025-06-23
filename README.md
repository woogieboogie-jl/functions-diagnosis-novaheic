# Functions Diagnosis

## Setup

Make sure your `.env` file has a valid RPC URL for Avalanche Fuji:

```bash
source .env
```

## Running the Script

To run the script:

```bash
forge script script/ReadOnlyDiag.s.sol:ReadOnlyDiag --rpc-url $FUJI_RPC_URL -vvvv
```

