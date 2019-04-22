<template>
  <div class="team-content-wrapper member-setting" v-loading="loading" v-cloak v-if="!error_exist">
    <div class="error_messages" v-if="error_messages.length > 0">
      <ul>
        <li v-for="error in error_messages">
          <i class="fab fa-studiovinari"></i>{{error}}
        </li>
      </ul>
    </div>
    <div class="team-info px-4 py-4">
      <el-form ref="form" :model="member" label-width="120px" enctype="multipart/form-data">
        <el-form-item label="名前">
          <el-input v-model="member.name"></el-input>
        </el-form-item>
        
        <el-form-item label="学年">
          <el-input v-model="member.grade" type="number"></el-input>
        </el-form-item>
        
        <el-form-item label="紹介文">
          <el-input type="textarea" v-model="member.profile" placeholder="自己紹介"></el-input>
        </el-form-item>

        <el-form-item class="tx-right">
          <el-button type="primary" @click="onSubmit">更新</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return{
        member: {},
        teams: [],
        loading: true,
        error_messages: []
      }
    },
    props: ["error_exist"],
    created: function(){
      // get team
      axios.get('/api/members/setting')
      .then(res => {
        this.member = res.data.member
        this.teams = res.data.teams
        this.loading = false
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.loading = false
      })
    },
    methods: {
      onSubmit: function(){
        this.loading = true
        axios.post('/api/members/setting', {
          member: this.member
        })
        .then(res => {
          if(res.data.result === "success"){
            this.$message('更新しました');
            this.loading = false
          }else{
            this.$message('更新に失敗しました');
            this.error_messages = res.data.errors
            this.loading = false
          }
        })
      },
    }
  }

</script>

<style scoped>

  h2{
    text-align: left;
    margin: 0;
    margin-top: 1rem;
    font-size: 20px;
  }
  h3{
    text-align: center;
  }
  
  textarea{
    min-height: 120px !important;
  }
  .team-content-wrapper{
    width: 93%;
    margin:auto;
    margin-bottom: 2rem;
  }
  
  .team-info{
    box-shadow: 0.25rem 0.15rem 1rem 0.25rem rgba(58,59,69,.15);
  }
  
  .content-text{
    width: 70%;
    margin: auto;
  }
  
  .tx-center{
    text-align:center;
  }
  
   .tx-right{
     text-align: right;
   }
   
  .error_messages{
    border: solid 4px rgba(255,0,0,0.3);
    margin: 5px 13px;
    color: rgba(255,0,0,0.8);
  }
</style>

<style lang="scss">
@media screen and (max-width:768px){
  .setting{
    .el-form-item{
      display: flex;
      flex-direction: column;
      label{
        width: 100% !important;
        text-align: left;
      }
      .el-form-item__content{
        width: 100%;
        margin: 0 !important;
      }
    }
  }
}
</style>