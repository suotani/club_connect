<template>
  <div class="members">
    <el-form :inline="true" :model="query" class="demo-form-inline " v-if="!error_exist">
      <el-form-item label="名前">
        <el-input v-model="query.name"></el-input>
      </el-form-item>
      
      <el-form-item label="学年・年数">
        <el-input v-model="query.grade"></el-input>
      </el-form-item>
      
      <el-form-item class="button-wrap">
        <el-button type="primary" @click="onSubmit">検索</el-button>
      </el-form-item>
    </el-form>
    
    <div class="list">
      <ul class="row">
        <li v-for="member in members">
          <div class="avatar">
            <img :src="member.avater_url"></img>
          </div>
          <div class="info">
            <div class="name">
              [{{member.role_in_team}}|{{member.grade}}]
              {{member.name}}
              ({{member.email}})
            </div>
            <div class="profile">
              {{member.profile}}
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>


<script>
import axios from 'axios'
export default {
  data() {
    return {
      members: [],
      query: {}
    };
  },
  props: ["error_exist"],
  created: function(){
    axios.get("/api/members",{
      params: {}
    })
    .then(res => {
      this.members = res.data.members
    })
  },
  methods: {
    onSubmit: function(){
      this.loading = true
      axios.get("/api/members",{
        params: this.query
      })
      .then(res => {
        this.members = res.data.members
        this.loading = false
      })
    }
  }
};
</script>