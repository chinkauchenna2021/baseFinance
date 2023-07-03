<template>
  <div class="w-full ">
    <div class="">
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