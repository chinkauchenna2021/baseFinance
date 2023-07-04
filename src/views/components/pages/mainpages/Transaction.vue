<template>
    <MainLayout>
      <div class="w-full mt-10 space-y-4 lg:space-y-0">
        <div class="w-full flex h-12 justify-start items-center">
            <div @click="back" class="flex justify-center items-center h-6 text-sm cursor-pointer w-20 border border-slate-400">Back</div>
        </div>
        <div class="w-full space-y-5 flex flex-row justify-center items-center space-x-4 ">
           <img :src="senderImage"  class="w-32 h-32 rounded-full"/>
              <div class="w-fit h-fit text-4xl font-bold">=</div>
           <img :src="baseImage"  class="w-32 h-32 rounded-full"/>
        </div>
        <div class="flex  space-x-2 lg:space-x-3 flex-row justify-between items-center py-5  border-b border-b-slate-200 ">
           <div class="w-fit text-sm lg:text-lg font-bold text-black/60">Pair:</div>
           <div class="w-fit text-xs lg:text-sm">{{pair}}</div>
        </div>
        <div class="flex  space-x-2 lg:space-x-3 flex-row justify-between items-center py-5  border-b border-b-slate-200 ">
            <div class="w-fit text-sm lg:text-lg font-bold text-black/60">ETH price:</div>
            <div class="w-fit text-xs lg:text-sm font-bold text-red-400">${{eth}}</div>
         </div>
         <div class="flex  space-x-2 lg:space-x-3 flex-row justify-between items-center py-5  border-b border-b-slate-200 ">
            <div class="w-fit text-sm lg:text-lg font-bold text-black/60">Sender currency price:</div>
            <div class="w-fit text-xs lg:text-sm font-bold text-red-400">${{usdc}}</div>
         </div>
        <div class="flex  space-x-2 lg:space-x-3 flex-row justify-between items-center py-5  border-b border-b-slate-200 ">
            <div class="w-fit text-sm lg:text-lg font-bold text-black/60">Description:</div>
            <div class="w-fit text-xs lg:text-sm">{{description}}</div>
         </div>
         <div class="flex  space-x-2 lg:space-x-3 flex-row justify-between items-center py-5  border-b border-b-slate-200 ">
           <input type="number" v-model="amount" :placeholder=singleToken class="outline-none border border-slate-200 h-10 pl-2 w-6/12 " />
          <button @click="borrowToken" class="rounded-lg capitalize w-5/12 h-10 outline-none border border-slate-300" type="">borrow eth</button>
           <!-- <button class="rounded-lg capitalize w-5/12 h-10 outline-none border border-slate-300" type="">Refund eth</button> -->
         </div>



      </div>
    </MainLayout>
 
</template>

<script>
import MainLayout from '../layouts/MainLayout.vue'
const BORROWTOKENCOTRACT="0xd5C1CBcD3d0442005535Bb9cf3C4Fa387dF39104"
export default {
    data(){
      return{
        senderImage:"",
        baseImage:"",
        description:"",
        pair:"",
        eth:"",
        usdc:"",
        amount:0,
        singletoken:""

      }
    },
    mounted(){
     
     let transaction = window.localStorage.getItem("transaction");
     let transaction_json = JSON.parse(transaction);
     console.log(transaction_json)
      this.description = transaction_json.description;
      this.pair = transaction_json.pair;
      this.eth = transaction_json.eth;
      this.usdc = transaction_json.usdc;
      this.senderImage = require('../../../../assets/'+transaction_json.senderImage);
      this.baseImage = require('../../../../assets/'+transaction_json.baseImage);
      let splitPair = transaction_json.pair.split("-");
     this.singleToken = splitPair[0];
    },
    methods:{
      back(){
        this.$router.go(-1);
      },
      borrowToken(){
        console.log(this.amount);
      }
    },
  components:{
    MainLayout
  }
}
</script>

<style>

</style>