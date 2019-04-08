<template>
  <el-alert
    :title="message"
    type="error">
  </el-alert>
</template>


<script>
  export default{
    name: "Error",
    props: ['message']
  }
</script>