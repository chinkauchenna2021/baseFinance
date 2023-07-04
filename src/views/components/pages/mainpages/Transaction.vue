<template>
    <MainLayout>
      <div class="w-full mt-10">
        <div class="w-full flex flex-row justify-center items-center space-x-4">
           <img src="../../../../assets/USDC.png"  class="w-32 h-32 rounded-full"/>
              <div class="w-fit h-fit text-4xl font-bold">=</div>
           <img src="../../../../assets/ETH.png"  class="w-32 h-32 rounded-full"/>
        </div>




      </div>
    </MainLayout>
 
</template>

<script>
import MainLayout from '../layouts/MainLayout.vue'
export default {
    data(){
      return{
        senderImage:"",
        baseImage:""
      }
    },
    mounted(){
     let transaction = window.localStorage.getItem("transaction");
     let transaction_json = JSON.parse(transaction);
   
    },
  components:{
    MainLayout
  }
}
</script>

<style>

</style>