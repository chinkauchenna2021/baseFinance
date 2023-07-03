<template>
  <div class="border items-center  flex flex-row border-slate-200 h-20 mt-10 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex">
       <img :src="senderImage" class="w-12 h-12 object-coverb" />
        <img :src="baseImage" class="w-12 h-12 object-cover" />
    
      </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage" , "baseTokenImage"],
   data(){
    return{
        senderImage:require('../../../../assets/' +this.senderTokenImage),
        baseImage:require('../../../../assets/' +this.baseTokenImage)

    }
   },
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>