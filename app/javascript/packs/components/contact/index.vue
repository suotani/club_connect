<template>
  <div v-loading="loading">
    <el-tabs v-model="activeName">
      <el-tab-pane label="合同練習等の申し込み" name="first">
        <ul>
          <router-link tag="li" :to= "{name: 'contact', params: {id: request.id}}" class="row" v-for="request in requests" v-bind:key="request.id">
            <ul class="message" v-bind:class="request.tag">
              <li class="message-tag">{{request.tag}}</li>
              <li class="message-from">{{request.from}}</li>
              <li class="message-text">
                <span class="message-title">{{request.title}}</span> |
                <span class="message-short-text">{{request.short_text}}</span>
              </li>
            </ul>
          </router-link>
        </ul>
      </el-tab-pane>
      <el-tab-pane label="メッセージ" name="second">
        <ul>
          <router-link tag="li" :to= "{name: 'contact', params: {id: contact.id}}" class="row" v-for="contact in contacts" v-bind:key="contact.id">
            <ul class="message" v-bind:class="contact.tag">
              <li class="message-tag">{{contact.tag}}</li>
              <li class="message-from">{{contact.from}}</li>
              <li class="message-text">
                <span class="message-title">{{contact.title}}</span> |
                <span class="message-short-text">{{contact.short_text}}</span>
              </li>
            </ul>
          </router-link>
        </ul>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        activeName: 'first',
        requests: [],
        contacts: [],
        loading: true
      };
    },
    created: function(){
      this.requests = [
        {tag: "new", from: "奈良教育大学剣道部", title: "2/18合同練習の申し込み", short_text: "はじめまして。..."},
        {tag: "replyed", from: "奈良教育大学剣道部", title: "2/18合同練習の申し込み", short_text: "はじめまして。..."},
        {tag: "new", from: "奈良教育大学剣道部", title: "2/18合同練習の申し込み", short_text: "はじめまして。..."},
        {tag: "", from: "奈良教育大学剣道部", title: "2/18合同練習の申し込み", short_text: "はじめまして。..."},
        {tag: "new", from: "奈良教育大学剣道部", title: "2/18合同練習の申し込み", short_text: "はじめまして。..."}, 
      ],
      this.loading = false
    },
    methods: {

    }
  };
</script>

<style scoped>
  ul{
    padding: 0;
  }
  .row{
    padding: 12px 17px;
    border-bottom: solid 1px rgba(169, 169, 169, 0.2);
    background-color: rgba(0, 0, 0, 0.05);
    color: rgba(0,0,0,0.8);
    cursor: pointer;
  }
  .row:hover{
    border: solid 1px rgba(0,0,0,0.2);
    border-bottom: solid 2px rgba(0,0,0,0.3);
  }
  .message{
    display: flex;
  }
  
  ul.message.new{
    
  }  
  ul.message.read{
    
  }  
  ul.message.new .message-title{
    font-weight: 800;
  }

  ul.message.new .message-tag{
    color: rgba(255,0,0,0.7);
    font-weight: 800;
  }
  
  ul.message.replyed{
    color: rgba(0,0,255,0.7);
  }
  
  .message-tag{
    width: 10%;
  }
  .message-from{
    width: 30%;
  }
  .message-text{
    width: 60%;
    overflow-x: hidden;
  }
  
  .message-short-text{
    color: rgba(0,0,0,0.5);
  }
</style>