<template>
  <div v-loading="loading" class="messages">
    <el-tabs v-model="activeName">
      <el-tab-pane label="合同練習等の申し込み" name="first">
        <ul>
          <router-link tag="li" :to= "{name: 'contact', params: {id: request.id}}" class="row" v-for="request in requests" v-bind:key="request.id">
            <ul class="message" v-bind:class="request.tag">
              <li class="message-tag">{{request.tag}}</li>
              <li class="message-destination">{{request.destination}}</li>
              <li class="message-text">
                <span class="message-title">{{request.title}}</span> |
                <span class="message-short-text">{{request.short_text}}</span>
              </li>
            </ul>
          </router-link>
        </ul>
        
        <div class="block">
          <el-pagination
            @current-change="handleRequestsChange"
            layout="prev, pager, next"
            :total="requests_total_count">
          </el-pagination>
        </div>
      </el-tab-pane>
      <el-tab-pane label="メッセージ" name="second">
        <ul>
          <router-link tag="li" :to= "{name: 'contact', params: {id: contact.id}}" class="row" v-for="contact in contacts" v-bind:key="contact.id">
            <ul class="message" v-bind:class="contact.tag">
              <li class="message-tag">{{contact.tag}}</li>
              <li class="message-destination">{{contact.destination}}</li>
              <li class="message-text">
                <span class="message-title">{{contact.title}}</span> |
                <span class="message-short-text">{{contact.short_text}}</span>
              </li>
            </ul>
          </router-link>
        </ul>
        <div class="block">
          <el-pagination
            @current-change="handleContactsChange"
            layout="prev, pager, next"
            :total="contacts_total_count">
          </el-pagination>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import axios from 'axios'
  export default {
    data() {
      return {
        activeName: 'first',
        requests: [],
        contacts: [],
        requests_total_count: 0,
        contacts_total_count: 0,
        loading: true
      };
    },
    props: ["error_exist"],
    created: function(){
      axios.get("/api/contacts", {
        params: {contact_type: "both"}
      })
      .then(res =>{
        this.requests = res.data.request_contacts
        this.contacts_total_count = res.data.contacts_total_count
        this.requests_total_count = res.data.requests_total_count
        this.contacts = res.data.normal_contacts
        this.loading = false
        this.$message("")
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.loading = false
      })
    },
    methods: {
      handleRequestsChange: function(val){
        this.loading = true
        axios.get("/api/contacts", {
          params: {contact_type: "request", page: val}
        })
        .then(res =>{
          this.requests = res.data.request_contacts
          this.loading = false
        })
        .catch(er => {
          this.$emit('appyl_error_message', er.response.data.message)
          this.loading = false
        })
      },
      handleContactsChange: function(val){
        this.loading = true
        axios.get("/api/contacts", {
          params: {contact_type: "normal", page: val}
        })
        .then(res =>{
          this.contacts = res.data.normal_contacts
          this.loading = false
        })
        .catch(er => {
          this.$emit('appyl_error_message', er.response.data.message)
          this.loading = false
        })
      }
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
    flex-wrap: wrap;
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
  .message-destination{
    width: 30%;
  }
  .message-text{
    width: 60%;
    overflow-x: hidden;
  }
  
  .message-short-text{
    color: rgba(0,0,0,0.5);
  }

  .el-pagination{
    margin: 1rem 0;
    text-align: center;
  }
</style>

<style lang='scss'>
@media screen and (max-width:768px){
  .messages{
    .message-destination{
      width: 90%;
    }
    .message-text{
      width: 100%;
    }
  }
}
</style>