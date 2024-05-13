/** @jsxImportSource frog/jsx */

import { Button, Frog } from "frog";
import { devtools } from "frog/dev";
import { neynar } from "frog/middlewares";
import { neynar as neynarHub } from "frog/hubs";
import { handle } from "frog/next";
import { serveStatic } from "frog/serve-static";
import { getTokenId } from "../getOwnedToken";
import { sendToken } from "../sendToken";

const app = new Frog({
  assetsPath: "/",
  basePath: "/api",
  hub: neynarHub({ apiKey: "NEYNAR_FROG_FM" }),
  verify: process.env.NODE_ENV === "development" ? "silent" : true,
  headers: {
    "Cache-Control": "max-age=0",
  },
});

app
  .use(
    neynar({
      apiKey: "NEYNAR_FROG_FM",
      features: ["interactor"],
    })
  )
  .frame("/", async (c) => {
    return c.res({
      action: "/check",
      image: "/assets/images/check.png",
      intents: [<Button>Check Own Token Monster</Button>],
    });
  });

app
  .use(
    neynar({
      apiKey: "NEYNAR_FROG_FM",
      features: ["interactor"],
    })
  )
  .frame("/check", async (c) => {
    const { frameData } = c;
    console.log(`frameData: ${JSON.stringify(frameData)}`);
    let tokenId = 9;
    if (frameData && "address" in frameData) {
      const { address } = frameData;
      if (address) {
        tokenId = await getTokenId(
          "0x4fc7b40cd8757bd279a848293501dc0695321399"
        );
        console.log(`tokenId: ${tokenId}`);
      } else {
        console.log("アドレスが未定義です。");
      }
    } else {
      console.log("frameDataが正しくありません。");
    }

    return c.res({
      action: `/resize`,
      image: `/assets/images/${tokenId}.png`,
      intents: [
        <Button.Transaction target="token">Send Sepolia</Button.Transaction>,
      ],
    });
  });

app.transaction("/token", async (c) => {
    await sendToken();
  return c.res();
  });

devtools(app, { appFid: 227285, serveStatic });

export const GET = handle(app);
export const POST = handle(app);
