<template>
  <div class="border flex flex-row border-slate-200 h-20 mt-10 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex">
       <img :src="senderImage" class="w-10 h-10 object-cover" />
        <img :src="img" class="w-10 h-10 object-cover" />
    
      </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage"],
   data(){
    return{
        senderImage:require('../../../../assets/' +this.senderTokenImage),
        baseImage:require

    }
   },
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>