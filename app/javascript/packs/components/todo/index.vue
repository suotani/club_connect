<template>
  <div>
    <table>
      <tr>
        <th>内容</th><th>期限</th><th>作成日</th><th>ステータス</th>
      </tr>
      <tr v-for="item in list">
        <td>{{item.text}}</td>
        <td>{{item.limit_at}}</td>
        <td>{{item.created_at}}</td>
        <td>{{item.status}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return{
        list: []
      }
    },
    created: function(){
      if (this.list.length === 0){
        axios.get('/api/todos')
        .then(res => {
          this.list = res.data
        });
      }
    }
  }
</script>