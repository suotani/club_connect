<template>
  <div id="todo">
    <h1>Todo</h1>
    <nav>
      <router-link to="/">一覧</router-link>
    </nav>
    <router-view />
  </div>
</template>

<script>

export default {
  name: "Todo"
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