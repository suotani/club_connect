<template>
  <div class="members" v-loading="loading">
    <el-row class="invite-mail-button">
      <el-button type="primary" round v-on:click="inviteModalShow=true">メンバーを招待する</el-button>
    </el-row>  
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
      <p>{{total_member_count}}名見つかりました</p>
      <ul class="row">
        <li v-for="member in members" class="listItem" v-on:click="onShow(member)">
          <div class="avatar">
            <img :src="member.avatar_url" v-show="member.avatar_url !== undefined"></img>
            <i class="fas fa-user" v-show="member.avatar_url === undefined"></i>
          </div>
          <div class="info">
            <div class="name">
              <span class="grade">[{{member.role_in_team}}|{{member.grade}}]</span>
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
    <el-pagination
      :page-size="20"
      background
      @current-change="handleCurrentChange"
      :current-page="1"
      layout="prev, pager, next"
      :total="total_member_count">
    </el-pagination>
    <div class="modal-wrapper" v-show="modalShow">
      <div class="modal" v-loading="modalLoading">
        <div class="modal-inner">
          <div class="member-info">
            <div class="image">
              <img :src="member.avatar_url" class="avatar" v-show="member.avatar_url">
              <i class="fas fa-user" v-show="!member.avatar_url"></i>
            </div>
            <div class="basic-info">
              <p>[{{member.role_in_team}}]</p>
              <p>{{member.name}}({{member.grade}})</p>
              <p>{{ member.email }}</p>
            </div>
          </div>
          <p class="profile">{{member.longProfile}}</p>
          <div class="button-wrap">
            <el-button v-on:click="modalShow=false">閉じる</el-button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-wrapper invite-modal" v-show="inviteModalShow">
      <div class="modal" v-loading="inviteModalLoading">
        <div class="modal-inner">
          <p v-show="invite_count !== 0">{{invite_count}}名の方に招待メールを送信しました</p>
          <el-form>
            <el-input
             type="textarea"
             v-model="invite_mails"
             placeholder="カンマ(,)区切りでメールアドレスを入力してください。例)example@example.com,example2@example.com,example3@example.com">
            </el-input>
          </el-form>
          <div class="button-wrap">
            <el-button v-on:click="submitMails" type="primary">招待</el-button>
            <el-button v-on:click="inviteModalShow=false">閉じる</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import axios from 'axios'
export default {
  data() {
    return {
      members: [],
      query: {},
      modalShow: false,
      modalLoading: false,
      member: {},
      loading: true,
      total_member_count: 0,
      inviteModalShow: false,
      inviteModalLoading: false,
      invite_mails: "",
      invite_count: 0
    };
  },
  props: ["error_exist"],
  created: function(){
    axios.get("/api/members",{params: {}})
    .then(res => {
      this.members = res.data.members
      this.total_member_count = res.data.members_count
      this.loading = false
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
        this.total_member_count = res.data.members_count
        this.loading = false
      })
    },
    handleCurrentChange: function(val) {
      this.loading = true
      this.query.page = val
      axios.get('/api/members',{
        params: this.query
      })
      .then(res => {
        this.members = res.data.members
        this.loading = false
      });
    },
    onShow: function(member){
      this.modalShow = true
      this.member = member
    },
    submitMails: function(){
      if(this.invite_mails !== ""){
        this.inviteModalLoading = true
        axios.post("/api/members", {
          mails: this.invite_mails
        })
        .then(res =>{
          this.invite_mails = ""
          this.invite_count = res.data.invite_count
          this.inviteModalLoading = false
        })
      }
    }
  }
};
</script>

<style lang="scss">
.members{
  .listItem:hover{
    background-color: rgba(0,0,0,0.05);
  }
  form{
    border: solid 3px #ddd;
    padding: 1rem;
    margin-bottom: 1rem;
    .el-form-item{
      margin-bottom: 0;
    }
  }
  .listItem{
    display: flex;
    cursor: pointer;
    .avatar{
      width: 70px;
      height: 70px;
      display: flex;
      .fa-user{
        font-size: 63px;
        color: rgba(0,0,0,0.3);
        margin: auto;
      }
      img{
        width: 60px;
        margin: auto;
      }
    }
    .info{
      padding: 0.3rem;
      .grade{
        width: 100px;
        display: inline-block;
      }
      .profile{
        margin-top: 10px;
      }
    }
  }
  .modal{
    .member-info{
      display: flex;
      .image{
        width: 30%;
        text-align: center;
        font-size: 100px;
        .avatar{
          width: 100%;
        }
      }
      .basic-info{
        align-self: center;
        font-size: 18px;
        p{
          margin-bottom: 5px;
        }
      }
    }
    .profile{
      width: 80%;
      margin: auto;
      margin-top: 5px;
    }
    .button-wrap{
      text-align: right;
      margin-top: 10px;
    }
  }
  .el-pagination{
    text-align: center;
  }
  .invite-mail-button{
    text-align: right;
    margin-bottom: 5px;
  }
}
</style>