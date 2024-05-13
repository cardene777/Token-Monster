import {
  createPublicClient,
  fallback,
  http,
  createWalletClient,
  custom,
} from "viem";
import { sepolia } from "viem/chains";

declare global {
  interface Window {
    ethereum?: any;
  }
}

const contractABI = [
    "function upgradeTo(address to, uint256 amount, bytes calldata userData) external"
];

const client = createPublicClient({
  chain: sepolia,
  transport: fallback([
    http("https://eth-sepolia.g.alchemy.com/v2/demo"),
    http(),
  ]),
});

export const walletClient = createWalletClient({
  chain: sepolia,
  transport: custom(window.ethereum),
});

// tokenAddress: string, flowRate: number, receiver: string
export const sendToken = async () => {
    const account = (await walletClient.getAddresses()) as unknown as `0x${string}`;
  if (account.length > 3) {
    await walletClient.writeContract({
      account,
      address: "0x96B82B65ACF7072eFEb00502F45757F254c2a0D4",
        abi: contractABI,
      args: ["10000000000000000"],
      functionName: "upgrade",
    });
  }
};
