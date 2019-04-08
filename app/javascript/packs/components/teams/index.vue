<template>
  <div v-loading="loading">
    <el-form :inline="true" :model="query" class="demo-form-inline " v-if="!error_exist">
      <el-form-item label="学校名">
        <el-input v-model="query.school" placeholder="〇〇大学"></el-input>
      </el-form-item>
      <el-form-item label="部活・サークルの種類">
        <el-select v-model="query.category_id" placeholder="">
          <el-option v-for="c in categories" v-bind:label="c.name" v-bind:value="c.id" v-bind:key="c.id" :clearable="true"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="学校種別">
        <el-select v-model="query.school_type" placeholder="">
          <el-option v-for="s in school_types" v-bind:label="s.name" v-bind:value="s.id" v-bind:key="s.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">検索</el-button>
      </el-form-item>
    </el-form>
    <div>
      <p class="my-2">{{total_team_count}}件見つかりました</p>
      <div class="mt-2 teams">
        <el-card class="box-card" v-for="t in teams" v-bind:key="t.id">
          <router-link :to= "{name: 'team', params: {id: t.id}}" slot="header" class="clearfix link-to-team">
            <p>{{t.school}} {{t.category}}</p>
          </router-link>
          <div class="text item">
           <p>{{t.leader_name}}</p>
          </div>
        </el-card>
      </div>
      <el-pagination
        background
        @current-change="handleCurrentChange"
        :current-page="$store.getters.team_query.page"
        layout="prev, pager, next"
        :total="total_team_count">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return {
        categories: [],
        teams: [],
        school_types: [],
        total_team_count: 0,
        loading: true
      }
    },
    props: ["error_exist"],
    computed: {
      query: {
        get() {return this.$store.getters.team_query},
        set(value){this.$store.dispatch('updateTeamQuery', value)}
      },
    },
    created: function(){
      axios.get('/api/teams',{
          params: this.$store.getters.team_query
        })
      .then(res => {
          this.categories = [""].concat(res.data.categories)
          this.teams = res.data.teams
          this.school_types = [""].concat(res.data.school_types)
          this.total_team_count = res.data.total_team_count
          this.loading = false
          this.$emit('appyl_error_message', "")
      })
      .catch(error => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.loading = false
      })
    },
    methods: {
      onSubmit: function(){
        this.handleCurrentChange(1);
      },

      handleCurrentChange: function(val) {
        this.$store.dispatch('updateTeamQueryPage', val)
        this.loading = true
        axios.get('/api/teams',{
          params:this.$store.getters.team_query
        })
        .then(res => {
           this.teams = res.data.teams
           this.total_team_count = res.data.total_team_count
           this.loading = false
        });
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