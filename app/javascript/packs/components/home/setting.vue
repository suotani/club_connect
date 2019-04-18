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
        </el-form-item>

        <el-form-item label="代表者役職">
          {{leader.role_in_team}}
        </el-form-item>

        <el-form-item label="代表者連絡先">
          {{leader.email}}
        </el-form-item>

        <el-form-item label="副代表者名">
          {{subleader.name}}
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
        error_messages: []
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
        var category_id = this.team.category_id
        var category = this.categories.find(function(e) {return e.id === category_id})
        this.team.name = category.name + "部"
      }
    }
  }

  function matchName(element, name) {
    return element.name === name;
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