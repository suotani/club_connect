<template>
  <div id="app">
    <div class="wrapper">
      <side-menu />
      <div class="content-wrapper">
        <header-nav />
        <div class="main-content px-4">
          <el-alert
            :title="error_message"
            type="error"
            v-if="error_message !== ''">
          </el-alert>
          <router-view :error_exist="error_exist" v-on:appyl_error_message="appyl_error_message"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderNav from './components/header_nav.vue'
import SideMenu from './components/side_menu.vue'
import Error from './components/error.vue'

export default {
  name: "App",
  data(){
    return{
      error_message: ""
    }
  },
  components: {
    HeaderNav,
    SideMenu,
    Error
  },
  conputed: {
    error_exist: function(){
      return this.error_message !== ''
    }
  },
  methods: {
    appyl_error_message: function(e){
      this.error_message = e
    }
  }
};
</script>

<style scoped>
  body{
    margin: 0;
  }
  ul{
    margin: 0;
    list-style: none;
  }
  
  .wrapper{
    display: flex;
  }
  
  .content-wrapper{
    width: 100%;
  }
  
  .main-content{
  }
</style>