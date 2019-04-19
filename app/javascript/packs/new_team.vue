<template>
  <div class="new_team" v-cloak v-loading="loading">
    <h2>招待コードを入力して部活動・サークルに参加します</h2>
    <div class="team-info px-4 py-4">
      <el-form ref="form" label-width="120px">
        <el-form-item label="招待コード">
          <el-input v-model="inviteCode"></el-input>
        </el-form-item>
        <el-form-item class="tx-right">
          <el-button type="primary" @click="onSearch">検索</el-button>
        </el-form-item>
      </el-form>
    </div>
    <h2>新しく部活動・サークルを登録します</h2>
    <p>より詳しい設定は、部活動・サークル登録後ホーム画面のチーム設定から行えます。</p>
    <div class="team-info px-4 py-4">
      <el-form ref="form" :model="team" label-width="120px">
        <div class="error_messages" v-if="error_messages.length > 0">
          <ul>
            <li v-for="error in error_messages">
              <i class="fab fa-studiovinari"></i>{{error}}
            </li>
          </ul>
        </div>

        <el-form-item label="学校種別">
          <el-select v-model="team.school_type" placeholder="Select">
            <el-option
              v-for="s in school_types"
              :key="s.id"
              :label="s.name"
              :value="s.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="学校名">
          <el-input v-model="team.school"></el-input>
        </el-form-item>
      
        <el-form-item label="カテゴリー">
          <el-select v-model="team.category_id" placeholder="Select" v-on:change="handleChangeCategory">
            <el-option
              v-for="c in categories"
              :key="c.id"
              :label="c.name"
              :value="c.id">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="チーム名">
          <el-input v-model="team.name"></el-input>
        </el-form-item>

        <el-form-item class="tx-right">
          <el-button type="primary" @click="onSubmit">作成</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="modal-wrapper" v-show="modalOpen">
      <div class="modal" v-loading="modalLoading">
        <el-form ref="form" :model="inquiry" label-position="top" label-width="120px">
          <p>以下の部活動・サークルに招待されました。</p>
          <p>内容にお間違いが無ければ「参加」ボタンを押してください。</p>
          <el-form-item label="学校名">
            {{inviteTeam.school}}
          </el-form-item>
          <el-form-item label="名前">
            {{inviteTeam.name}}
          </el-form-item>
          <el-form-item label="代表者名">
            {{inviteTeam.leader_name}}
          </el-form-item>

          <el-form-item>
            <el-button type="primary" @click="onJoin">参加</el-button>
            <el-button @click="modalOpen = false">キャンセル</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default{
  data(){
    return{
      team: {school: ""},
      error_messages: [],
      categories: [],
      school_types: [],
      loading: true,
      inviteCode: "",
      inviteTeam: {},
      modalOpen: false,
      modalLoading: false
    }
  },
  created: function(){
    // get team
    axios.get('/show')
    .then(res => {
      this.categories = res.data.categories
      this.school_types = res.data.school_types
      this.loading = false
    })
    .catch(er => {
      this.loading = false
    })
  },
  methods: {
    onSubmit: function(){
      this.loading = true
      axios.post('/create', {
        team: this.team
      })
      .then(res => {
        if(res.data.result === "success"){
          window.location="/home"
        }else{
          this.$message('更新に失敗しました');
          this.error_messages = res.data.errors
        }
        this.loading = false
      })
    },
    onSearch: function(){
      this.loading = true
      axios.get('/search', {
        params: {invite_code: this.inviteCode}
      })
      .then(res => {
        this.inviteTeam = res.data.team
        this.modalOpen = true
        this.loading = false
      })
      .catch(er => {
        this.$message("見つかりませんでした。")
        this.loading = false
      })
    },
    onJoin: function(){
      this.modalLoading = true
      axios.post('/update', {
        invite_code: this.inviteCode,
        id: this.inviteTeam.id
      })
      .then(res =>{
        window.location = "/home"
        this.modalLoading = false
        this.modalOpen = false
      })
      .catch(er => {
        this.$message("処理に失敗しました")
        this.modalLoading = false
        this.modalOpen = false
      })
    },
    handleChangeCategory(){
      var category_id = this.team.category_id
      var category = this.categories.find(function(e) {return e.id === category_id})
      this.team.name = category.name + "部"
    }
  }
}
</script>

<style lang="scss">
.new_team{
  width: 80%;
  margin: auto;
  form{
    width: 600px;
    margin: auto;
  }
  .tx-right{
    text-align: right;
  }
  .error_messages{
    border-left: solid 3px red;
    padding-left: 6px;
  }
}
</style>