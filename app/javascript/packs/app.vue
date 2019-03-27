<template>
  <div id="app">
    <div class="wrapper">
      <side-menu />
      <div class="content-wrapper">
        <header-nav />
        <div class="main-content px-4">
          <router-view />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderNav from './components/header_nav.vue'
import SideMenu from './components/side_menu.vue'

export default {
  name: "App",
  components: {
    HeaderNav,
    SideMenu
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