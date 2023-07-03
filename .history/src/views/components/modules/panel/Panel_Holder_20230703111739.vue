<template>
  <div class="border flex flex-row border-slate-200 h-20 mt-10 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex">
      <img src="../" />
        <img :src="img" class="w-10 h-10 object-cover" />
    
      </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage"],
   data(){
    return{
        img:require(this.senderTokenImage)
    }
   },
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>