# AgentHalo Pass

Free commemorative ERC-721 pass for **Binance Agent ID** holders on BNB Smart Chain.

- **Contract:** `0x717f802bdbffbb8a054b23dafd5fa63017294eb2` (BSC mainnet)
- **Agent ID Registry (SPACE ID):** `0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F`
- **Claim:** free, gas-only, value must be 0. One pass per Agent ID holder.
- **No owner / no admin / no fees** — the contract has no privileged functions.
- Fully on-chain SVG badge showing your `.ai` handle.

## How to claim
Send a transaction calling `claim()` with 0 value from any wallet that holds a Binance Agent ID (ERC-8004 identity registered via Binance Agent ID on BSC).

## Rules compliance (Binance Agent ID Hackathon 2026)
- No QR code login; users only check their own Agent ID.
- No automatic transfers without user confirmation; claim is user-initiated.
- Contract source is open-source in this repo (MIT).
- No profit promise; the pass has no monetary function.
- No "Binance" or "BNB" naming in the project (AgentHalo Pass).

## Deploy
Bytecode in `abi/bytecode.txt` (solc 0.8.39, optimizer 200 runs, 5060 bytes).
