export const switchToMoonbeam = async () => {
  try {
    let ethereum = window.ethereum;
    const data = [
      {
        chainId: "0x507",
        chainName: "Moonbase Alpha",
        nativeCurrency: {
          name: "DEV",
          symbol: "DEV",
          decimals: 18,
        },
        rpcUrls: ["https://rpc.testnet.moonbeam.network"],
        blockExplorerUrls: null,
      },
    ];
    /* eslint-disable */
    const tx = await ethereum
      .request({ method: "wallet_addEthereumChain", params: data })
      .catch();
    if (tx) {
      console.log(tx);
    }
  } catch (err) {
    console.log("error is ", err);
  }
};
