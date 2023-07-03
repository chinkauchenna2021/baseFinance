<template>
   <MainLayout>
       <div class="h-fit flex-col justify-center items-center w-11/12 lg:w-5/12">
       <div class="w-full">
         <div class=""></div><
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