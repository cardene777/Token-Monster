import {
  createPublicClient,
  fallback,
  http,
} from "viem";
import { baseSepolia } from "viem/chains";
import abi from "../utils/TokenMonster.json";

const client = createPublicClient({
  chain: baseSepolia,
  transport: fallback([
    http("https://sepolia.base.org"),
    http(),
  ]),
});


export const getTokenId = async (address: string): Promise<number> => {
    console.log(`address: ${address}`);
    if (address.length > 3) {
      const tokenId = (await client.readContract({
        address: "0xb065BD29ba56c834e0E1d9c97ECB33e1b136c9a6",
        functionName: "getOwnedToken",
        args: [address],
        abi: abi.abi,
      })) as number;
      return tokenId;
    }
    return 9;
}
