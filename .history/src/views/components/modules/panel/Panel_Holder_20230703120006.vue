<template>
  <div class="border items-center  px-4 flex flex-row border-slate-200 h-20 mt-10 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex relative hover:space-x-[3px] transition-all cursor-pointer">
       <img :src="senderImage" class="w-12 h-12 object-cover bg-blend-color-burn rounded-full " />
        <img :src="baseImage" class="w-12 h-12 object-cover bg-blend-color-burn rounded-full z-10 -ml-4"  />
      </div>
      <div class="ml-5 font-bold text-lg text-black/70">
          {{titles}}
      </div>
      <div class="h-full w-4/12">
      <span class=""></span>
      <div class="h-full text-xs mx-2">
       {{description}}
      </div>
      </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage" , "baseTokenImage" , "title" , "description"],
   data(){
    return{
        senderImage:require('../../../../assets/' +this.senderTokenImage),
        baseImage:require('../../../../assets/' +this.baseTokenImage),
        titles:this.title,
        description:this.description,

    }
   },
   mounted(){
    console.log(this.senderTokenImage)
   }
}
</script>

<style>

</style>