<template>
<div class="container new_team">
  <el-form ref="form" :model="team" label-width="120px">
    <el-form-item label="Activity name">
      <el-input v-model="team.school"></el-input>
    </el-form-item>
  </el-form>
</div>
</template>

<script>
import axios from 'axios'
export default{
  data(){
    return{
      team: {}
    }
  }
}
</script>

<style lang="scss">
.new_team{
  .container{
    width: 1000px;
    margin: auto;
  }
}
</style>