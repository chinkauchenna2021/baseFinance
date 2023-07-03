<template>
      <div class="w-full flex justify-between items-center h-14 border-b border-b-slate-100 " >
         <div class="w-fit h-fit">
            <div class="text-sm font-bold text-blue-700/50">MoonBeam Finance</div>
         </div>
         <div class="w-fit flex justify-between items-center lg:w-4/12">
            <div class="text-[14px] w-fit cursor-pointer">Bet Page</div>
            <div class="text-[14px] w-fit cursor-pointer">Users Borrowing Stat</div>
            <div class="">
            <w3m-core-button></w3m-core-button>
               <!-- <button ref="btn" type="button" @click="connectwallet" >Wallet connect</button> -->
            </div>
         </div>
    </div>
</template>

<script>
  import {
    EthereumClient,
    w3mConnectors,
    w3mProvider,
    WagmiCore,
    WagmiCoreChains,
    WagmiCoreConnectors
  } from 'https://unpkg.com/@web3modal/ethereum'

  import { Web3Modal } from 'https://unpkg.com/@web3modal/html'

  // Equivalent to importing from @wagmi/core
  const { configureChains, createConfig } = WagmiCore

  // Equivalent to importing from @wagmi/core/chains
  const { mainnet, polygon, avalanche, arbitrum } = WagmiCoreChains

  // Equivalent to importing from @wagmi/core/providers
  const { CoinbaseWalletConnector } = WagmiCoreConnectors




export default {
  name:"Header",
  data(){
   walletconnect:Web3Modal
  },
  methods:{
    connectwallet(){
       this.walletconnect.openModal(),
    }
  }


}
</script>

<style>

</style>