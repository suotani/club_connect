<template>
  <div v-loading="loading" class="teams">
    <el-form :inline="true" :model="query" class="demo-form-inline " v-if="!error_exist">
      <el-form-item label="学校名">
        <el-input v-model="query.school" placeholder="〇〇大学"></el-input>
      </el-form-item>
      <el-form-item label="学校種別">
        <el-select v-model="query.school_type" placeholder="">
          <el-option v-for="s in school_types" v-bind:label="s.name" v-bind:value="s.id" v-bind:key="s.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="都道府県">
        <el-input v-model="query.prefecture" placeholder="奈良県"></el-input>
      </el-form-item>
      <el-form-item label="市区町村">
        <el-input v-model="query.city" placeholder="奈良市"></el-input>
      </el-form-item>
      <el-form-item class="button-wrap">
        <el-button type="primary" @click="onSubmit">検索</el-button>
      </el-form-item>
    </el-form>
    <div>
      <p class="my-2">{{total_team_count}}件見つかりました</p>
      <div class="mt-2 teams">
        <el-card class="box-card" v-for="t in teams" v-bind:key="t.id">
          <router-link :to= "{name: 'team', params: {id: t.id}}" slot="header" class="clearfix link-to-team">
            <p>{{t.school}} {{t.name}}</p>
          </router-link>
          <div class="text item">
           <p>{{t.address}}</p>
           <p>{{t.introduction}}</p>
           <p>(代表){{t.leader_name}}</p>
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

<style lang='scss'>
.teams{
  form{
    text-align: center;
    border: solid 3px #ddd;
    padding: 1rem 1rem 0;
    box-sizing: border-box;
    width: 100%;
  }
  .el-input{
    width: 140px !important;
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

  @media screen and (max-width:768px){
    .el-form--inline .el-form-item label{
      width: 35%;
      line-height: 20px;
    }
    .el-form--inline .el-form-item__content{
      width: 65%;
    }
    .el-form--inline .button-wrap .el-form-item__content{
      width: 100%;
      text-align: right;
    }
    form{
      padding: 0.5rem 0.3rem;
    }
    .el-form--inline .el-form-item{
      display: flex;
      margin-bottom: 10px;
    }
    .el-form--inline .el-form-item label{
      width: 50%;
      line-height: 20px;
    }
    .button-wrap{
      justify-content: flex-end;
    }
    .link-to-team{
      font-size: 12px;
    }
    .el-card__header{
      height: 75px;
      padding: 1rem 0.3rem;
    }
  }
}
</style>