<template>
  <div class="border grid grid-cols-5 gap-4 place-items-center  cursor-pointer px-4  border-slate-200 h-20 mt-5 w-full lg:w-11/12  rounded-full">
      <div class="w-fit h-fit flex relative hover:space-x-[3px] transition-all cursor-pointer">
       <img :src="senderImage" class="w-9 h-9 object-cover bg-blend-color-burn rounded-full " />
        <img :src="baseImage" class="w-9 h-9 object-cover bg-blend-color-burn rounded-full z-10 -ml-4"  />
      </div>
      <div class="w-fit font-bold text-sm text-blue-400">
          {{titles}}
      </div>
      <div class="h-full  flex flex-row items-center text-left">
      <div class=" text-[13px] ">
       {{description}}
      </div>
      </div>
      <div class="h-full w-fit flex flex-row items-center ">
        <div class=" text-[13px] font-semibold text-red-600">
         {{usdc}}
        </div>
        </div>
        <div class="h-full w-fit flex flex-row items-center">
          <div class=" text-[13px] font-semibold text-red-300">
           {{eth}}
          </div>
          </div>
  </div>
</template>

<script>
export default {
   props:["senderTokenImage" , "baseTokenImage" , "title" , "description" , "usdc" , "eth"],
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