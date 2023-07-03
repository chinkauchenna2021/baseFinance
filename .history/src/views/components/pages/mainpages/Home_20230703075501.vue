<template>
   <MainLayout>
       <div class="mt-4 h-fit flex-col justify-center items-center w-11/12 lg:w-12/12 border-b border-b-slate-200">
       <div class="w-full flex flex-row justify-center items-center h-[180px]">
         <div class="w-fit h-fit mx-3">
             <div class="w-24 h-24 rounded-full bg-slate-300/80 ring ring-offset-gray-50 ring-orange-100"></div>
         </div>
         <div class="w-full">
           <div class='w-full h-fit text-xs lg:text-3xl font-bold py-4 capitalize' id="title">
               The best asset borrowing finance platform for users who are in need of assets to
               perform blockchain transaction in the ethereum ecosystem. 
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

<style scope>
#title{
    line-height:40px;
    font-family:"Roboto",sans-serif;
    font-weight:400;

}
@media  {
    
}

</style>