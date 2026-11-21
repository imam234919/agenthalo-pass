# AgentHalo Pass — Hackathon Submission Pack
Prepared: 22 Nov 2026. Submission window closes 2026-12-09 08:00 UTC (15:00 WIB).

## Project fields (copy-paste ready)
- **Project name:** AgentHalo Pass
- **Website:** https://imam234919.github.io/agenthalo-pass/
- **Contract (BNB Chain mainnet, chain 56):** 0x717f802bdbffbb8a054b23dafd5fa63017294eb2
- **Verified source:** https://bscscan.com/address/0x717f802bdbffbb8a054b23dafd5fa63017294eb2#code
- **Open-source repo:** https://github.com/imam234919/agenthalo-pass
- **Agent ID Registry used:** 0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F (Binance Agent ID, ERC-8004)
- **Agent ID usage description:** AgentHalo Pass reads the holder's Agent ID from the Binance Agent ID registry (ERC-8004 IdentityRegistry) at claim time; each holder may claim exactly one free pass, and the pass stores the holder's Agent ID handle on-chain in a fully on-chain SVG badge. Agent ID serves as the access-control identity: wallets without an Agent ID cannot claim.
- **Reward receiving address (BNB Chain):** 0x2E557C2bBb188a4b64b6d9A5804B13E32d882eD3
- **Team:** solo builder (individuals allowed per rules)

## Rules compliance
- No QR-code login; users check only their own Agent ID (balanceOf gate).
- No automatic transfers; claim() is user-initiated with 0 value.
- No sensitive credential collection; contract is immutable, no owner/admin functions.
- No profit promise; no "passive income" wording; not a trading product.
- No "Binance"/"BNB" naming in project, token, or domain.
- No "look up other wallets by name" feature.

## Metrics to update before final submission
- Holders (target >= 30 distinct Agent ID addresses during 18 Nov - 9 Dec): see holder count via contract totalMinted().
- Live holder list is readable on-chain via ownerOf()/agentHandle().

## Submission channel (TBD)
The official announcement (18 Nov) describes submission but has not published a
project form URL. Re-check before deadline:
- Announcement: https://www.binance.com/en/support/announcement/detail/95f5dbe0ea674a48a739b59e046648bf
- Square post: https://www.binance.com/en/square/post/389517345917641
- @BinanceWallet on X
- Binance Wallet Agentic Wallet ecosystem page
Do NOT guess a form URL. Fallback: publish project on X with
#BinanceWalletHackathon #AgenticWallet and submit the X link via the official
Community Promotion survey: https://app.binance.com/uni-qr/user-survey/ff6832f8d2984af289068c9450a3c98c
