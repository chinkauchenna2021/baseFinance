<template>
   <MainLayout>
       <div class="container mt-4 h-fit flex-col justify-center items-center w-full lg:w-full border-b border-b-slate-50">
       <div class="w-full flex flex-row justify-center items-center h-[180px]">
         <div class="w-fit h-fit lg:mx-5">
             <img src="@/assets/Beam.png" class="w-40 h-28 object-cover rounded-lg bg-slate-300/80 ring ring-offset-gray-50 ring-orange-100" />
         </div>
         <div class="w-full">
           <div class='w-full h-fit text-xs text-center lg:text-left lg:text-3xl font-extrabold py-4 capitalize' id="title">
               The best asset borrowing finance platform for users who are in need of assets to
               perform blockchain transaction in ethereum ecosystem. 
           </div>
         </div>
       </div>
       <div class="w-full">
       <div class="w-full flex justify-center">
          <Panel_Holder senderTokenImage="USDC.png" baseTokenImage="ETH.png" title="USDC/ETH" description="The USDC/ETH is for users"/>  
       </div>
       
       </div>   
       </div>
   </MainLayout>
</template>

<script>
import MainLayout from '../layouts/MainLayout.vue'
import Panel_Holder from '../../modules/panel/Panel_Holder.vue'
export default {
    name:"Home",
  components:{
     MainLayout,
     Panel_Holder
  },
  data(){
    return{
       
    }
  }


}
</script>

<style scope>
#title{
    line-height:38px;
    font-family:"Roboto",sans-serif;
    font-weight:400;

}

</style>