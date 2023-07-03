<template>
  <div class="w-full flex justify-center items-center">
    <div class="w-11/12 lg:w-8/12">
       <Header />
        <div >
            <slot></slot>
        </div>
       <Footer />
    </div>
  </div>
  
</template>

<script>
import Header from './Header.vue';
import Footer from './Footer.vue';
export default {
    name:"MainLayout",
    components:{
        Header,
        Footer,
    },
    data(){
        return{

        }
    }
}
</script>

<style>

</style>