// SPDX-License-Identifier: MIT
// AgentHalo Pass — free commemorative ERC-721 for Binance Agent ID holders.
// Hackathon entry: Binance Agent ID Hackathon 2026 (submission period Nov 18 - Dec 9, 2026).
// Design goals: zero owner power, zero fees, one pass per Agent ID holder, gas-only claims.
pragma solidity ^0.8.24;

interface IAgentIDRegistry {
    function balanceOf(address owner) external view returns (uint256);
    function handleOf(address owner) external view returns (string memory);
}

contract AgentHaloPass {
    string public constant NAME = "AgentHalo Pass";
    string public constant SYMBOL = "AHP";

    IAgentIDRegistry public constant REGISTRY = IAgentIDRegistry(0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F);

    uint256 public totalMinted;
    uint256 public constant MAX_SUPPLY = 100_000;

    mapping(address => bool) public claimed;
    mapping(uint256 => address) public ownerOf;
    mapping(uint256 => string) public agentHandle;

    event Claimed(address indexed claimer, uint256 indexed tokenId, string handle);

    error AlreadyClaimed();
    error NotAgentIDHolder();
    error SoldOut();

    /// @notice Claim your one free AgentHalo Pass. Gas only; value must be zero.
    function claim() external payable returns (uint256 tokenId) {
        if (msg.value != 0) revert("AgentHaloPass: send no value");
        if (REGISTRY.balanceOf(msg.sender) == 0) revert NotAgentIDHolder();
        if (claimed[msg.sender]) revert AlreadyClaimed();
        if (totalMinted >= MAX_SUPPLY) revert SoldOut();

        totalMinted += 1;
        tokenId = totalMinted;
        claimed[msg.sender] = true;
        ownerOf[tokenId] = msg.sender;
        agentHandle[tokenId] = REGISTRY.handleOf(msg.sender);
        emit Claimed(msg.sender, tokenId, agentHandle[tokenId]);
    }

    function balanceOf(address owner) external view returns (uint256) {
        return claimed[owner] ? 1 : 0;
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(ownerOf[tokenId] != address(0), "AgentHaloPass: token does not exist");
        // fully on-chain SVG badge with the holder's own .ai handle
        string memory handle = agentHandle[tokenId];
        string memory svg = string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400">',
            '<rect width="400" height="400" fill="#0b0e14"/>',
            '<circle cx="200" cy="160" r="90" fill="none" stroke="#F0B90B" stroke-width="6"/>',
            '<text x="200" y="175" text-anchor="middle" font-family="monospace" font-size="40" fill="#F0B90B">A</text>',
            '<text x="200" y="320" text-anchor="middle" font-family="monospace" font-size="22" fill="#ffffff">',
            handle, '.ai</text>',
            '<text x="200" y="360" text-anchor="middle" font-family="monospace" font-size="14" fill="#888">#',
            _itoa(tokenId), ' AgentHalo Pass</text></svg>'
        ));
        return string(abi.encodePacked(
            "data:application/json;base64,",
            _b64(abi.encodePacked(
                '{"name":"AgentHalo Pass #', _itoa(tokenId),
                '","description":"Commemorative pass for Binance Agent ID holders. One per holder, free, gas-only.","image_data":"',
                svg, '"}'
            ))
        ));
    }

    // --- internal helpers: minimal itoa + base64 (no external deps) ---
    function _itoa(uint256 v) internal pure returns (string memory) {
        if (v == 0) return "0";
        uint256 t = v; uint256 len = 0;
        while (t > 0) { len++; t /= 10; }
        bytes memory b = new bytes(len);
        while (v > 0) { b[--len] = bytes1(uint8(48 + v % 10)); v /= 10; }
        return string(b);
    }

    string internal constant B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    function _b64(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        uint256 outLen = 4 * ((len + 2) / 3);
        bytes memory out = new bytes(outLen);
        uint256 j = 0;
        for (uint256 i = 0; i < len; i += 3) {
            uint256 n = uint256(uint8(data[i])) << 16;
            if (i + 1 < len) n |= uint256(uint8(data[i+1])) << 8;
            if (i + 2 < len) n |= uint256(uint8(data[i+2]));
            out[j++] = bytes(B64)[(n >> 18) & 63];
            out[j++] = bytes(B64)[(n >> 12) & 63];
            out[j++] = (i + 1 < len) ? bytes(B64)[(n >> 6) & 63] : bytes1("=");
            out[j++] = (i + 2 < len) ? bytes(B64)[n & 63] : bytes1("=");
        }
        return string(out);
    }
}
