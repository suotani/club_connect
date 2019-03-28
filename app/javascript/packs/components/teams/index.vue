<template>
  <div>
    <el-form :inline="true" :model="query" class="demo-form-inline ">
      <el-form-item label="学校名">
        <el-input v-model="query.school" placeholder="〇〇大学"></el-input>
      </el-form-item>
      <el-form-item label="部活・サークルの種類">
        <el-select v-model="query.category" placeholder="">
          <el-option v-for="c in categories" v-bind:label="c.name" v-bind:value="c.id" v-bind:key="c.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="部活・サークルの種類">
        <el-select v-model="query.category" placeholder="">
          <el-option v-for="c in categories" v-bind:label="c.name" v-bind:value="c.id" v-bind:key="c.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="部活・サークルの種類">
        <el-select v-model="query.category" placeholder="">
          <el-option v-for="c in categories" v-bind:label="c.name" v-bind:value="c.id" v-bind:key="c.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">検索</el-button>
      </el-form-item>
    </el-form>
    <p class="my-2">{{teams.length}}件見つかりました</p>
    <div v-loading="loading" class="mt-2 teams">
      <el-card class="box-card" v-for="t in teams" v-bind:key="t.id">
        <router-link :to= "{name: 'team', params: {id: t.id}}" slot="header" class="clearfix link-to-team">
          <p>{{t.school}} {{t.category}}</p>
        </router-link>
        <div class="text item">
         <p>{{t.leader}}</p>
        </div>
      </el-card>
    </div>
    <el-pagination
      background
      @current-change="handleCurrentChange"
      layout="prev, pager, next"
      :total="teams.length">
    </el-pagination>
  </div>
</template>

<script>
  export default{
    data(){
      return {
        query: {
          school: "",
          category: ""
        },
        categories: [
          {id: 1, name: "テニス"},
          {id: 2, name: "剣道"},
          {id: 3, name: "柔道"},
          {id: 4, name: "バレーボール"},
        ],
        teams: [
          {id: 1,school: "奈良教育大学", category: "バレーボール", leader: "魚谷　知司"},
          {id: 2,school: "奈良教育大学", category: "バレーボール", leader: "魚谷　知司"},
          {id: 3,school: "奈良教育大学", category: "バレーボール", leader: "魚谷　知司"},
          {id: 4,school: "奈良教育大学", category: "バレーボール", leader: "魚谷　知司"},
          {id: 5,school: "奈良教育大学", category: "バレーボール", leader: "魚谷　知司"},
        ],
        loading: true
      }
    },
    created: function(){
      //get categories
      // this.categories = []
      this.loading = false
    },
    methods: {
      onSubmit: function(){
         this.loading = true
        console.log(this.query);
      },
      handleCurrentChange: function(val) {
        console.log(`current page: ${val}`);
      }
    }
  }
</script>

<style scoped>
  form{
    text-align: center;
    border: solid 3px #ddd;
    padding: 1rem 5rem 0;
  }
  .link-to-team {
    color: rgba(0,0,0,0.5);
  }
  
  .link-to-team:hover {
    color: rgba(0,0,0,0.8);
  }
  
 .text {
    font-size: 14px;
  }

  .item {
    margin-bottom: 18px;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  .clearfix:after {
    clear: both
  }

  .box-card {
    width: 48%;
    margin: auto !important;
    margin-bottom: 1rem !important;
  }
  
  .el-pagination{
    margin: 1rem 0;
    text-align: center;
  }
  .teams{
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
  }
</style>