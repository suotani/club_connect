<template>
  <div id="app">
    <app-header />
    <header-nav />
    <router-view />
  </div>
</template>

<script>
import AppHeader from './components/app_header.vue'
import HeaderNav from './components/header_nav.vue'

export default {
  name: "App",
  components: {
    AppHeader,
    HeaderNav
  }
};
</script>

<style scoped>
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
</style>