<template>
  <div class="team-content-wrapper" v-loading="loading">
    <div class="team-info px-4 py-4">
      <el-form ref="form" :model="team" label-width="120px">
        <el-form-item label="学校名">
          <el-input v-model="team.school"></el-input>
        </el-form-item>
      
        <el-form-item label="カテゴリー">
          <el-select v-model="team.category_id" placeholder="Select">
            <el-option
              v-for="c in categories"
              :key="c.id"
              :label="c.name"
              :value="c.id">
            </el-option>
          </el-select>
        </el-form-item>
        
        <el-form-item label="写真のアップロード">
          <el-upload
            class="upload-demo"
            action=""
            :auto-upload="false"
            :on-change="handleChange"
            :on-remove="handleRemove"
            :file-list="fileList"
            list-type="picture">
            <el-button size="small" type="primary">Click to upload</el-button>
            <div slot="tip" class="el-upload__tip">jpg/png files with a size less than 500kb</div>
          </el-upload>
        </el-form-item>
        
        <el-form-item label="紹介文">
          <el-input type="textarea" v-model="team.introduction" placeholder="活動内容や大会での記録、メンバーのレベル感など、紹介文を入力してください"></el-input>
        </el-form-item>
        
        <el-form-item label="メンバーの構成">
          <el-input type="textarea" v-model="team.member" placeholder="学年単位、男女単位で各何名在籍しているか入力してください"></el-input>
        </el-form-item>
    
        <hr class="my-4" />
        <h2>代表・副代表設定</h2>
        
        <el-form-item label="代表者名">
          <el-input placeholder="代表して部外とやり取りをされる方のお名前です" v-model="team.leader_name"></el-input>
        </el-form-item>

        <el-form-item label="代表者役職">
          <el-select v-model="team.leader_role_id" placeholder="Select">
            <el-option
              v-for="r in roles"
              :key="r.id"
              :label="r.name"
              :value="r.id">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="代表者連絡先">
          <el-input placeholder="" v-model="team.leader_email"></el-input>
        </el-form-item>

        <el-form-item label="副代表者名">
          <el-input placeholder="" v-model="team.sub_leader_name"></el-input>
        </el-form-item>

        <el-form-item label="副代表者役職">
          <el-select v-model="team.sub_leader_role_id" placeholder="Select">
            <el-option
              v-for="r in roles"
              :key="r.id"
              :label="r.name"
              :value="r.id">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="副代表者連絡先">
          <el-input placeholder="" v-model="team.sub_leader_email"></el-input>
        </el-form-item>

        <el-form-item class="tx-right">
          <el-button type="primary" @click="onSubmit">更新</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
  export default{
    data(){
      return{
        team: {},
        photos: [],
        dayCount: 0,
        categories: [],
        roles: [],
        loading: true,
        fileList: []
      }
    },
    created: function(){
      // get team
      this.team = {
        school: "奈良教育大学",
        category: "バレーボール部",
        level: "地区大会優勝程度",
        member: "1年生一人、2年生3人",
        introduction: "こういう人たちです。",
        leader_name: "魚谷　知司",
        leader_email: "s.uotani@kobe.un.com",
        leader_role_id: 1,
        sub_leader_name: "魚谷　知司",
        sub_leader_email: "s.uotani@kobe.un.com",
        sub_leader_role_id: 2
      },
      this.photos = [1,2,3,4,5],
      this.loading = false,
      this.categories = [],
      this.roles = []
    },
    methods: {
      onSubmit: function(){
        console.log(this.team)
      },
      handleRemove(file, fileList) {
        console.log(file.name)
        const fileName = file.name
        const index = this.fileList.findIndex(function(e){return e.name == fileName});
        console.log(index)
        this.fileList.splice(index, 1)
      },
      handleChange(file, fileList) {
        this.fileList.push(file);
      }
    }
  }

  function matchName(element, name) {
    return element.name === name;
  }
</script>

<style>

  h2{
    text-align: left;
    margin: 0;
    margin-top: 1rem;
    font-size: 20px;
  }
  h3{
    text-align: center;
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
</style>