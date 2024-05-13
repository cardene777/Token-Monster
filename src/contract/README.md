# Central Data Hub (CDH)

## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

## Quickstart

```bash
cd contract
yarn install
forge install
```

2. Compile

```bash
yarn compile
```

```bash
cd packages/hardhat
forge build
```

3. Test

```bash
forge test -vvvv
```

4. Chain

```bash
yarn chain
```

5. Deploy

- FlowSender

```bash
yarn deploy --tags FlowSender --network base
```

- TokenMonster

```bash
yarn deploy --tags TokenMonster --network baseSepolia
```

1. Start App

```
yarn start
```

## Contract

|  Contract Name   |               Contract Address               |      Chain       |                                       Explorer                                        |
| :--------------: | :------------------------------------------: | :--------------: | :-----------------------------------------------------------------------------------: |
|  **Super ETH**   | `0x46fd5cfB4c12D87acD3a13e92BAa53240C661D93` |       Base       | https://testnet.crossvaluescan.com/address/0x46fd5cfB4c12D87acD3a13e92BAa53240C661D93 |
| **Super Degen**  | `0xDCED4bda380b411080206F914aFdFa0dECecBD57` |       Base       | https://testnet.crossvaluescan.com/address/0xDCED4bda380b411080206F914aFdFa0dECecBD57 |
|  **FlowSender**  | `0x40AcB0E5E5BA146fDb7D124fd00cF55C8A9EE9d6` |       Base       | https://testnet.crossvaluescan.com/address/0x40AcB0E5E5BA146fDb7D124fd00cF55C8A9EE9d6 |
| **TokenMonster** | `0x025FF29456A54b2a712AFA55c98763Fe51118e3a` |       Base       | https://testnet.crossvaluescan.com/address/0x025FF29456A54b2a712AFA55c98763Fe51118e3a |
| **TokenMonster** | `0xb065BD29ba56c834e0E1d9c97ECB33e1b136c9a6` |   BaseSepolia    | https://testnet.crossvaluescan.com/address/0xb065BD29ba56c834e0E1d9c97ECB33e1b136c9a6 |
|  **Super ETH**   | `0x30a6933ca9230361972e413a15dc8114c952414e` | Ethereum Sepolia | https://sepolia.etherscan.io/address/0x30a6933ca9230361972e413a15dc8114c952414e |
|  **Super USDC**  | `0xC9c297554c4d81E8970432155aa9178e54f132cb` | Ethereum Sepolia | https://testnet.crossvaluescan.com/address/0xDCED4bda380b411080206F914aFdFa0dECecBD57 |
|  **FlowSender**  | `0x40AcB0E5E5BA146fDb7D124fd00cF55C8A9EE9d6` | Ethereum Sepolia | https://testnet.crossvaluescan.com/address/0x40AcB0E5E5BA146fDb7D124fd00cF55C8A9EE9d6 |
| **TokenMonster** | `0x3A387873306f907D34E879eb8b0c7C0033374523` | Ethereum Sepolia | https://testnet.crossvaluescan.com/address/0x025FF29456A54b2a712AFA55c98763Fe51118e3a |
