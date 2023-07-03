<template>
   <MainLayout>
       <div class="h-fit flex-col justify-center items-center w-11/12 lg:w-5/12">
       <div class="w-full flex flex-row justify-center items-center">
         <div class="">
             <div class="w-20 h-2 rounded-full bg-slate-300/80 ring ring-offset-gray-50 ring-orange-100"></div>
         </div>
         <div class=""></div>
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