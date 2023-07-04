<template>
  <div @click="transactionPage"  class="border grid grid-cols-5 lg:gap-4 space-x-16 lg:space-x-0  place-items-center  cursor-pointer px-4  border-slate-200 h-20 mt-5 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex relative hover:space-x-[3px] transition-all cursor-pointer">
       <img :src="senderImage" class="w-9 h-9 object-cover bg-blend-color-burn rounded-full " />
        <img :src="baseImage" class="w-9 h-9 object-cover bg-blend-color-burn rounded-full z-10 -ml-4"  />
      </div>
      <div class="w-fit font-bold text-sm text-blue-400">
          {{titles}}
      </div>
      <div class="h-full  lg:flex flex-row items-center text-left hidden">
      <div class=" text-[13px] ">
       {{description}}
      </div>
      </div>
      <div class="h-full w-fit flex flex-row items-center ">
        <div class=" text-[13px] font-semibold text-red-300">
         {{usdc}}
        </div>
        </div>
        <div class="h-full w-fit flex flex-row items-center ">
          <div class=" text-[13px] font-semibold text-red-300">
           {{eth}}
          </div>
          </div>
        </div>
        <!-- <router-view></router-view> -->
</template>

<script>
export default {
   props:["senderTokenImage" , "baseTokenImage" , "title" , "description" , "usdc" , "eth" , "routeParam"],
   data(){
    return{
        senderImage:require('../../../../assets/' +this.senderTokenImage),
        baseImage:require('../../../../assets/' +this.baseTokenImage),
        titles:this.title,
        description:this.description,
        pair:this.routeParam,
        sendImage:this.senderTokenImage,
        baseRedirectImage:this.baseTokenImage,


    }
   },
   methods:{
    transactionPage(){
      let transactionData = JSON.stringify({pair:this.pair , description: this.description,
      title:this.title , senderImage:this.sendImage , baseImage:this.baseRedirectImage , eth:this.eth,
      usdc:this.usdc
      })
      window.localStorage.setItem("transaction",transactionData)
      this.$router.push({name:'transaction',params:{pair:this.pair}});
    }
   },
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>