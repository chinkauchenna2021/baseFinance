<template>
  <div >
    <div>
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
    name
    components:{
        Header,
    },
    data(){
        return{

        }
    }
}
</script>

<style>

</style>