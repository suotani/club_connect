<template>
  <ul v-bind:class="{toggled: isToggled}">
    <a href="#" class="sidebar-bland">
      <div class="sidebar-bland-text">Club Connect</div>
    </a>
    <hr class="sidebar-divider" />
    <li class="nav-item">
      <router-link :to= "{name: 'home'}" class="active">
        <i class="fas fa-tachometer-alt"></i>
        Dashboard
      </router-link>
    </li>
    <hr class="sidebar-divider" />
    <div class="sidebar-heading">MAIN</div>
    <li class="nav-item">
      <router-link :to= "{name: 'teams'}">
        <i class="fas fa-search"></i>
        部活動・サークルを検索
      </router-link>
    </li>
    <li class="nav-item">
      <router-link :to= "{name: 'messages'}">
        <i class="fas fa-envelope"></i>
        メッセージ一覧
      </router-link>
    </li>
    <hr class="sidebar-divider" />
    <div class="sidebar-heading">SETTINGS</div>
    <li class="nav-item">
      <router-link :to= "{name: 'setting'}">
        <i class="fas fa-sliders-h" v-bind:class="{w100: isToggled}"></i>
        各種設定
      </router-link>
    </li>
    <li class="nav-item">
      <router-link :to= "{name: 'calender'}">
        <i class="far fa-calendar-alt" v-bind:class="{w100: isToggled}"></i>
        カレンダー
      </router-link>
    </li>
    <li class="nav-item">
      <a href="/teams/sign_out" method="delete">
        <i class="fas fa-sign-out-alt" v-bind:class="{w100: isToggled}"></i>
        ログアウト
      </a>
    </li>
    <hr class="sidebar-divider" />
    <div class="text-center">
      <button type="button" id="sidebar-toggle" v-on:click="toggleSidebar">
        <i class="fas" v-bind:class="{'fa-chevron-left': !isToggled, 'fa-chevron-right': isToggled}"></i>
      </button>
    </div>
  </ul>
</template>

<script>
  export default{
    data(){
      return{
        isToggled: false
      }
    },
    methods: {
      toggleSidebar: function(){
        this.isToggled = !this.isToggled
      }
    }
  }
</script>

<style scoped>
  ul{
    min-height: 100vh;
    background-color: #4e73df;
    width: 15rem;
    list-style: none;
    padding: 0;
    box-sizing: border-box;
  }
  
  li:hover{
    background-color: rgba(255,255,255,0.2);
  }
  
  .toggled{
    width: 6.5rem
  }
  .text-center{
    text-align: center;
  }
  a.sidebar-bland{
    height: 4.375rem;
    font-size: 20px;
    color: white;
    display: flex;
    text-decoration: none;
  }
  
  .sidebar-bland .sidebar-bland-text{
    display: inline;
    align-self: center;
    width: 100%;
    text-align: center;
  }
  
  .sidebar-heading{
    color: rgba(255,255,255,.4);
    padding: 0 1rem;
    margin-top: 1rem;
    font-size: .65rem;
    font-weight: 800;
    text-align: left;
  }
  
  .nav-item a{
    display: block;
    text-align: left;
    padding: 1rem;
    color: rgba(255,255,255,0.8);
    text-decoration: none;
    font-size: 0.85rem;
  }
  
  ul.toggled .nav-item a{
    text-align: center;
  }
  
  .nav-item a:hover, .nav-item a.active{
    color: white;
  }
  
  .sidebar-divider{
    height: 0;
    border: none;
    margin: 0 1rem;
    border-top: 1px solid rgba(255,255,255,.15);
  }
  
  #sidebar-toggle{
    background-color: rgba(255,255,255,.2);
    border: none;
    color: white;
    padding: 0.6rem 1rem;
    border-radius: 24px;
    font-size: 25px;
    margin-top: 0.3rem;
    cursor: pointer;
  }
  
  ul.toggled li a{
    font-size: 11px;
    padding: 0.5rem 0.25rem;
  }
  
  ul.toggled li i{
    width: 100%;
    font-size: 13px;
  }
</style>