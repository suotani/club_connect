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
    <p class="my-2">{{totalTeamCount}}件見つかりました</p>
    <div v-loading="loading" class="mt-2">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <p>奈良教育大学 剣道部</p>
        </div>
        <div class="text item">
         
        </div>
      </el-card>
    </div>
    <el-pagination
      background
      @current-change="handleCurrentChange"
      layout="prev, pager, next"
      :total="totalTeamCount">
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
        teams: [],
        totalTeamCount: 80,
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
    width: 480px;
  }
  
  .el-pagination{
    margin: 1rem 0;
    text-align: center;
  }

</style>