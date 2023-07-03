<template>
  <div class="border flex flex-row border-slate-200 h-20 mt-10 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex">
        <img :src="senderTokenImage" class="w-10 h-10 object-cover" />
         <img :src="baseTokenImage" class="w-10 h-10 object-cover" />
         <img src='../../' />
      </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage" , "baseTokenImage"],
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>