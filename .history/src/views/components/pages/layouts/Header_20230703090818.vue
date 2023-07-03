<template>
      <div class="w-full flex justify-between items-center h-14 border-b border-b-slate-100 " >
         <div class="w-fit h-fit">
            <div class="text-md font-bold text-blue-700/50">Beam Finance</div>
         </div>
         <div class="w-fit flex justify-between items-center lg:w-fit space-x-5">
            <div class="lg:text-[14px] w-fit cursor-pointer">Bet Page</div>
            <div class="text-sm  lg:text-[14px] w-fit cursor-pointer">Users Borrowing Stat</div>
            <div class="">
               <button ref="btn" type="button" @click="connectwallet" >Wallet connect</button>
            </div>
         </div>
    </div>
</template>

<script>


export default {
  name:"Header",
  data(){

  },
  methods:{
    connectwallet(){
      console.log(this.$refs.btn);
    }
  }


}
</script>

<style>

</style>