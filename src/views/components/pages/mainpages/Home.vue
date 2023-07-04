<template>
   <MainLayout>
    <div class="w-full h-fit flex justify-end items-center mt-5 border-b border-b-slate-100 pb-2">
      <div v-if="mainAccount" class="w-fit h-fit flex flex-row my-6 lg:my-0">
      <span class="mx-3 font-medium text-black"> MoonBeam Account:</span> <span class="text-red-500 text-lg font-medium"> {{ mainAccount}} DEV</span>
        </div>


    </div>
       <div class="container mt-4 h-fit flex-col justify-center items-center w-full lg:w-full border-b border-b-slate-50">
       <div class="w-full flex lg:flex-row flex-col space-y-6 my-10 lg:my-0 lg:space-y-0 justify-center items-center h-[180px]">
         <div class="w-fit h-fit lg:mx-5 mt-20 lg:mt-0">
             <img src="@/assets/Beam.png" class="lg:w-40 lg:h-28 h-40 w-11/12 object-cover rounded-lg bg-slate-300/80 ring ring-offset-gray-50 ring-orange-100" />
         </div>
         <div class="w-full">
           <div class='w-full leading-snug lg:leading-normal h-fit text-lg text-center lg:text-left lg:text-3xl font-extrabold py-4 capitalize' id="title">
               The best asset borrowing finance platform for users who are in need of assets to
               perform blockchain transaction in ethereum ecosystem. 
           </div>
         </div>
       </div>
       <div class="w-full">
       <div class="w-full flex justify-center flex-col mt-20 lg:mt-0 ">
        <div class="  grid grid-cols-5 lg:gap-4 space-x-16 lg:space-x-0 place-items-center cursor-pointer px-4 text-center  mt-10 w-full lg:w-11/12  rounded-full">
          <div class="w-fit h-fit flex relative hover:space-x-[3px] transition-all cursor-pointer">
           <div class="w-fit">Image</div>
          </div>
          <div class=" font-bold text-lg text-blue-400">
            Pair
          </div>
          <div class=" h-full  lg:flex hidden flex-row justify-center items-center ">
          <div class="w-fit text-[13px] ">
            Description
          </div>
          </div>
          <div class="  h-full w-fit flex justify-center flex-row items-center ">
            <div class=" text-[13px] mx-2">
              USDC Price ($)
            </div>
            </div>
            <div class=" h-full w-fit flex flex-row items-center justify-center ">
              <div class=" text-[13px] mx-2">
                ETH Price ($)
              </div>
              </div>
      </div>
         
  
          <Panel_Holder senderTokenImage="USDC.png" baseTokenImage="ETH.png" title="USDC/ETH" description="Hedge USDC as a collateral with the platform for ETH" :usdc="usdcPrice"  :eth="ethPrice" routeParam="USDC-ETH"/>  
       </div>
       
       </div>   
       </div>
   </MainLayout>
</template>

<script>
import {ethers} from 'ethers';
import MainLayout from '../layouts/MainLayout.vue'
import Panel_Holder from '../../modules/panel/Panel_Holder.vue';
import {getTokenPrice , tokenProxy , baseTokenPrice} from '../../hooks/GetPrices.js';
const AVEE_PROXY_CONTRACT="0x13d1Ed8c24911d88e6155cE32A66908399C97924"
const ETH_PROXY_CONTRACT="0x26690F9f17FdC26D419371315bc17950a0FC90eD"
const USDC_PROXY_CONTRACT="0x8DF7d919Fe9e866259BB4D135922c5Bd96AF6A27"
export default {
    name:"Home",
  components:{
     MainLayout,
     Panel_Holder
  },
 async mounted(){
   const {borrow , mainAccountBalance } =  await getTokenPrice();
   const {tokenPrice , tokenTimeStamp}  =   await tokenProxy(USDC_PROXY_CONTRACT)
    const {basePrice , baseTimeStamp}  = await baseTokenPrice();
   this.mainAccount = mainAccountBalance;
   this.usdcPrice =  (tokenPrice/1E18).toFixed(2);
   this.ethPrice = (basePrice / 1E18).toFixed(2);
  },
  data(){
    return{
      mainAccount:"",
      usdcPrice:0,
      ethPrice:0,
    }
  }


}
</script>

<style scope>
#title{
    font-family:"Roboto",sans-serif;
    font-weight:400;
}

</style>