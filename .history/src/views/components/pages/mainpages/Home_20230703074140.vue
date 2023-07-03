<template>
   <MainLayout>
       <div class="h-fit flex-col justify-center items-center w-11/12 lg:w-5/12">
       <div class="w-full flex flex-row justify-center items-center h-[180px]">
         <div class="w-fit h-fit">
             <div class="w-24 h-24 rounded-full bg-slate-300/80 ring ring-offset-gray-50 ring-orange-100"></div>
         </div>
         <div class="">
           <div class=''>
               The best asset borrowing finance platform for users who are in need of assets to
               perform  
           </div>
         </div>
       </div>
       <div class="w-full">
          <Panel_Holder />  
       
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
  }


}
</script>

<style>

</style>