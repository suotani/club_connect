<template>
  <div v-loading="loading">
    <h2 class="title">{{title}}</h2>
    <ul>
      <li v-for="(message, index) in messages" v-on:click="toggleRow(index)">
        <div class="message-head">
          <span class="message-from">{{message.from}}</span>
          <span class="message-post-at">{{message.post_at}}</span>
        </div>
        <div v-if="message.short">short{{message.short_text}}</div>
        <div v-else>long{{message.text}}</div>
      </li>
    </ul>
    <div v-if="showReply" class="wrap-reply">
      <el-input
        type="textarea"
        :rows="2"
        placeholder="Please input"
        v-model="reply">
      </el-input>
      <el-row>
        <el-button type="primary">送信</el-button>
        <el-button v-on:click="cancelReply">キャンセル</el-button>
      </el-row>
    </div>
    <div v-if="!showReply" class="wrap-reply">
      <el-row>
        <el-button v-on:click="showReply=true">返信</el-button>
      </el-row>
    </div>
  </div>
</template>

<script>
  export default{
    data(){
      return {
        title: "",
        reply: "",
        messages: [],
        showReply: false,
        loading: true
      }
    },
    created: function(){
      this.title = "title"
      this.messages = [
        {from: "fromA", post_at: "2019/01/01 10:00", short_text: "aaa", text: "bbbbbb", short: true},
        {from: "fromB", post_at: "2019/01/01 10:00", short_text: "aaa", text: "bbbbbb", short: true},
        {from: "fromA", post_at: "2019/01/01 10:00", short_text: "aaa", text: "bbbbbb", short: false}
      ],
      this.loading = false
    },
    methods: {
      toggleRow: function(index){
        var message = this.messages[index]
        message.short = !message.short
        this.messages.splice(index, 1, message)
      },
      cancelReply: function(){
        this.reply = ""
        this.showReply = false
      }
    }
  }
</script>

<style scoped>
  h2{
    margin-bottom: 20px;
  }
  
  ul{
    padding: 0;
  }
  
  li{
    cursor: pointer;
    border-bottom: solid 1px rgba(0,0,0,0.2);
    padding: 8px;
    padding-bottom: 14px;
  }
  li:hover{
    background-color: rgba(0,0,0,0.05);
  }
  .message-head{
    display: flex;
    justify-content: space-between;
  }
  
  .message-from{
    font-weight: 800;
  }
  
  .message-post-at{
    font-size: 12px;
    color: rgba(0,0,0,0.8);
  }

  .wrap-reply{
    margin: 46px 0 10px;
  }
</style>
