<template>
  <div class="team-content-wrapper setting" v-loading="loading" v-cloak v-if="!error_exist">
    <div class="error_messages" v-if="error_messages.length > 0">
      <ul>
        <li v-for="error in error_messages">
          <i class="fab fa-studiovinari"></i>{{error}}
        </li>
      </ul>
    </div>
    <div class="team-info px-4 py-4">
      <el-form ref="form" :model="team" label-width="120px" enctype="multipart/form-data">
        <el-form-item label="学校名">
          <el-input v-model="team.school"></el-input>
        </el-form-item>

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

        <el-form-item label="活動場所の都道府県">
          <el-input v-model="team.prefecture"></el-input>
        </el-form-item>

        <el-form-item label="活動場所の市区町村">
          <el-input v-model="team.city"></el-input>
        </el-form-item>

        <el-form-item label="市区町村以降の住所">
          <el-input v-model="team.address"></el-input>
        </el-form-item>
        
        <el-form-item label="写真のアップロード">
          <el-upload
            class="upload-demo"
            action="/api/files"
            :auto-upload="true"
            :on-remove="handleRemove"
            :on-success = "handleUploaded"
            :file-list="fileList"
            list-type="picture">
            <el-button size="small" type="primary">写真のアップロード</el-button>
            <div slot="tip" class="el-upload__tip">jpg/png files with a size less than 500kb</div>
          </el-upload>
        </el-form-item>
        
        <el-form-item label="紹介文">
          <el-input type="textarea" v-model="team.introduction" placeholder="活動内容や大会での記録、メンバーのレベル感など、紹介文を入力してください"></el-input>
        </el-form-item>
        
        <el-form-item label="メンバーの構成">
          <el-input type="textarea" v-model="team.members" placeholder="学年単位、男女単位で各何名在籍しているか入力してください"></el-input>
        </el-form-item>
    
        <hr class="my-4" />
        <h2>代表・副代表設定</h2>
        
        <el-form-item label="代表者名">
          {{leader.name}}
          <el-button v-on:click="changeLeader('leader', '代表')">変更</el-button>
        </el-form-item>

        <el-form-item label="代表者役職">
          {{leader.role_in_team}}
        </el-form-item>

        <el-form-item label="代表者連絡先">
          {{leader.email}}
        </el-form-item>

        <el-form-item label="副代表者名">
          {{subleader.name}}
          <el-button v-on:click="changeLeader('subleader', '副代表')">変更</el-button>
        </el-form-item>

        <el-form-item label="副代表者役職">
          {{subleader.role_in_team}}
        </el-form-item>

        <el-form-item label="副代表者連絡先">
          {{subleader.email}}
        </el-form-item>

        <el-form-item class="tx-right">
          <el-button type="primary" @click="onSubmit">更新</el-button>
        </el-form-item>
      </el-form>
    </div>

      <div class="modal-wrapper" v-show="modalOpen">
        <div class="modal" v-loading="modalLoading">
          <el-form :inline="true" ref="form" label-width="120px">
            <el-form-item>
              <el-input v-model="candidate_name" placeholder="名前"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="searchCandidates">検索</el-button>
            </el-form-item>
          </el-form>
            
          <ul>
            <li v-for="c in candidates" :key="c.id" @click="selected_new_leader = c">
              {{c.name}}
            </li>
          </ul>
          
          <el-row>
            <div>
              <el-button type="primary" @click="onSubmitLeader" v-if="selected_new_leader.name !== undefined">
                {{selected_new_leader.name}}で決定する
              </el-button>
              <el-button @click="modalOpen = false">キャンセル</el-button>
            </div>
          </el-row>
        </div>
      </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return{
        team: {},
        leader: {},
        subleader: {},
        categories: [],
        roles: [],
        loading: true,
        fileList: [],
        school_types: [],
        error_messages: [],
        modalOpen: false,
        modalLoading: false,
        candidates: [],
        candidate_name: "",
        selected_new_leader: {},
        modalType: ""
      }
    },
    props: ["error_exist"],
    created: function(){
      // get team
      axios.get('/api/teams/edit')
      .then(res => {
        this.team = res.data.team
        this.leader = res.data.leader
        this.subleader = res.data.subleader
        this.categories = res.data.categories
        this.roles = res.data.roles
        this.fileList = res.data.images //{name: name, url: url, id: id}
        this.school_types = res.data.school_types
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
        axios.post('/api/teams/update', {
          team: this.team
        })
        .then(res => {
          if(res.data.result === "success"){
            this.$message('更新しました');
          }else{
            this.$message('更新に失敗しました');
            this.error_messages = res.data.errors
          }
          this.loading = false
        })
      },
      
      handleRemove(file, fileList) {
        const id = file.id
        axios.delete('/api/files/' + file.id, {})
        .then(res => {
          this.fileList = fileList
          this.$message('画像を1枚削除しました');
        })
      },
      handleUploaded(response, file, fileList){
        var id = response.id
        const index = this.fileList.findIndex(function(e){return e == file});
        var input = file
        input.id = id
        this.fileList = fileList
        this.fileList.splice(index, 1, file)
        this.$message('画像をアップロードしました');
      },

      handleChangeCategory(){
        var category = this.categories.find(function(e) {return e.id === this.team.category_id})
        this.team.name = category.name + "部"
      },
      changeLeader(type, typeText){
        this.modalOpen = true
        this.modalType = type
        if(this.candidates.length === 0){
          this.modalLoading = true
          axios.get("/api/teams/candidates")
          .then(res => {this.candidates = res.data.members})
          this.modalLoading = false
        }
      },
      searchCandidates(){
        this.modalLoading = true
        axios.get("/api/teams/candidates",{params: {name: this.candidate_name}})
        .then(res => {this.candidates = res.data.members})
        this.modalLoading = false
      },
      onSubmitLeader(){
        this.modalLoading = true
        axios.post('/api/teams/update_leader', {
          leader_id: this.selected_new_leader.id,
          type: this.modalType
        })
        .then(res => {
          this.$message('更新しました');
          if(this.modalType === "leader"){
            this.leader = res.data.leader
          }else{
            this.subleader = res.data.subleader
          }
          this.modalLoading = false
          this.modalOpen = false
        })
        .catch(er => {
          this.$message('更新に失敗しました');
          this.error_messages = er.data.errors
          this.modalLoading = false
        })
      }
    }
  }
  function getCandidates(name){
    axios.get("/api/teams/candidates",{params: {name: name}})
    .then(res => {return  res.data.members})
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
  .modal {
    form{
      text-align: center;
    }
  }
</style>

<style lang="scss">
.setting{
  .modal {
    form{
      text-align: center;
    }
    .el-row{
      display :flex;
      justify-content: flex-end;
      .selected_new_leader{
        padding-right: 3rem;
      }
      
    }
    ul{
      height: 200px;
      overflow-y: scroll;
      li{
        cursor: pointer;
        padding: 0.5rem;
        box-sizing: border-box;
      }
      li:hover{
        background-color: rgba(0,0,0,0.02);
      }
    }
  }
}
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