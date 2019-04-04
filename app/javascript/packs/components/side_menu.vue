<template>
  <div>
    <ul v-bind:class="{toggled: isToggled}">
      <a href="#" class="sidebar-bland">
        <div class="sidebar-bland-text">
          <i class="far fa-dot-circle"></i>Torus
        </div>
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
        <router-link :to= "{name: 'contacts'}">
          <i class="far fa-envelope"></i>
          メールボックス
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
          予定表
        </router-link>
      </li>
  
      <hr class="sidebar-divider" />
      <div class="sidebar-heading">OTHER</div>
      <li class="nav-item">
        <span v-on:click="modalOpen=true">
          <i class="far fa-question-circle" v-bind:class="{w100: isToggled}"></i>
          お問い合わせ
        </span>
      </li>    
      <li class="nav-item">
        <a href="/teams/sign_out" data-method="delete">
          <i class="fas fa-sign-out-alt" v-bind:class="{w100: isToggled}"></i>
          ログアウト
        </a>
      </li>
      <hr class="sidebar-divider" />
      <div class="text-center">
        <button type="button" id="sidebar-toggle" v-on:click="isToggled = !isToggled">
          <i class="fas" v-bind:class="{'fa-chevron-left': !isToggled, 'fa-chevron-right': isToggled}"></i>
        </button>
      </div>
    </ul>
    <div class="modal-wrapper" v-show="modalOpen">
      <div class="modal" v-loading="modalLoading">
        <el-form ref="form" :model="inquiry" label-position="top" label-width="120px">
          <el-form-item label="返信用メールアドレス">
            <el-input v-model="inquiry.email"></el-input>
          </el-form-item>
          <el-form-item label="お問い合わせ内容">
            <el-input v-model="inquiry.text" type="textarea" ></el-input>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" @click="onSubmit">送信</el-button>
            <el-button @click="modalOpen = false">キャンセル</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return{
        isToggled: false,
        modalOpen: false,
        modalLoading: false,
        inquiry: {text: "", email: ""}
      }
    },
    methods: {
      onSubmit: function(){
        this.modalLoading = true
        axios.post("/api/inquiry",{
          inquiry: this.inquiry
        })
        .then(res => {
          this.$message("お問い合わせを送信しました。")
          this.modalLoading = false
          this.modalOpen = false
        })
      }
    }
  }
</script>

<style scoped>
  ul{
    min-height: 100vh;
    height: 100%;
    background-color: #4e73df;
    width: 15rem;
    list-style: none;
    padding: 0;
    box-sizing: border-box;
  }
  
  i{
    text-align: center;
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
  
  .sidebar-bland .sidebar-bland-text i{
    margin-right: 5px;
  }
  
  .sidebar-heading{
    color: rgba(255,255,255,.4);
    padding: 0 1rem;
    margin-top: 1rem;
    font-size: .65rem;
    font-weight: 800;
    text-align: left;
  }
  
  .nav-item a, span{
    display: block;
    text-align: left;
    padding: 1rem;
    color: rgba(255,255,255,0.8);
    text-decoration: none;
    font-size: 0.85rem;
    cursor: pointer;
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
  
  ul.toggled li a, ul.toggled li span{
    font-size: 11px;
    padding: 0.5rem 0.25rem;
    text-align: center;
  }
  
  ul.toggled li i{
    width: 100%;
    font-size: 13px;
  }
</style>