<template>
  <div id="app">
    <div class="wrapper">
      <side-menu />
      <div class="content-wrapper">
        <header-nav />
        <router-view />
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
  }
  nav{
    padding: 7px;
    background-color: black;
    margin-bottom: 10px;
  }
  nav a{
    color: #4f97e2;
    text-decoration: none;
    margin-right: 10px;
  }
  
  .wrapper{
    display: flex;
  }
  
  .content-wrapper{
    width: 100%;
  }
</style>