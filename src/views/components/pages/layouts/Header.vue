<template>
      <div class="w-full flex justify-between items-center h-14 border-b border-b-slate-100 " >
         <div class="w-fit h-fit">
            <div class="text-md font-bold text-blue-700/50">Beam Finance</div>
         </div>
         <div class="w-fit flex justify-between items-center lg:w-fit space-x-5">
            <div class=" text-xs lg:text-[14px] w-fit cursor-pointer">Bet Page</div>
            <div class="text-xs lg:text-[14px] w-fit cursor-pointer">Users Borrowing Stat</div>
            <div class="">
               <button class="w-fit h-fit px-4 py-1 border border-blue-200 rounded-md " ref="btn" type="button" @click="connectwallet" >Wallet connect</button>
            </div>
         </div>
    </div>
</template>

<script>
import {ethers} from 'ethers';
import {switchToMoonbeam} from '../../hooks/Connection'

export default {
  name:"Header",
  data(){
     return{
     
     }
  },
  mounted(){
   switchToMoonbeam();
   let accountOnMount =  window.localStorage.getItem('account')
   let account_json  = JSON.parse(accountOnMount);
   let first = account_json.slice(0,5);
   let last = account_json.slice(-4)
   this.$refs.btn.innerHTML = first+"..."+last;
  },
  methods:{
  async connectwallet(){
   try{
      if(typeof window.ethereum != undefined){
     window.ethereum.request({ method: "eth_requestAccounts" }).then(acc=>{
        let sliceFromBack = -4;
        let account = acc[0];
        window.localStorage.setItem("account", JSON.stringify(account));
        let firstconversion = account.slice(0,5);
        let lastconversion = account.slice(sliceFromBack)
        this.$refs.btn.innerHTML = firstconversion +"..."+ lastconversion;
      
     },)
      }
   }catch(err){
      console.log("error connecting", err)
   }
   },
  }


}
</script>

<style>

</style>