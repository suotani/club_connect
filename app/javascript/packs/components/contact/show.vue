<template>
  <div v-loading="loading">
    <router-link :to= "{name: 'contacts'}">
      <i class="fas fa-arrow-left"></i>
      戻る
    </router-link>
    <div v-if="!error_exist">
      <h2 class="title">{{contact.title}}</h2>
      <ul>
        <li v-for="(message, index) in messages" v-on:click="toggleRow(index)" v-bind:key="message.id">
          <div class="message-head">
            <span class="message-from">{{message.from_team}}</span>
            <span class="message-post-at">{{message.created_at}}</span>
          </div>
          <div v-if="message.short">{{message.short_text}}</div>
          <div v-else>{{message.text}}</div>
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
          <el-button type="primary" v-on:click="onSubmit">送信</el-button>
          <el-button v-on:click="cancelReply">キャンセル</el-button>
        </el-row>
      </div>
      <div v-if="!showReply" class="wrap-reply">
        <el-row>
          <el-button v-on:click="showReply=true">返信</el-button>
          <el-button v-on:click="showAddScheduleModal=true" type="primary" v-if="contact.requesting">スケジュールへ追加</el-button>
          <el-button v-on:click="showRejectModal=true" type="danger" v-if="contact.requesting" >申し込みを断る</el-button>
        </el-row>
      </div>

      <div class="modal-wrapper" v-show="showAddScheduleModal">
        <div class="modal" v-loading="modalLoading">
          <el-form ref="form" :model="contact" label-width="120px">
            <p>以下の内容でスケジュールを登録します。<br />異なる場合は、お手数ですが予定表から入力をお願いいたします。</p>
            <el-form-item label="パートナー">
              <p>{{contact.schedule.team_name}}</p>
            </el-form-item>
            <el-form-item label="日付">
              <p>{{contact.schedule.date}}</p>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="onSubmitSchedule">送信する</el-button>
              <el-button @click="showAddScheduleModal=false">キャンセル</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>

      <div class="modal-wrapper" v-show="showRejectModal">
        <div class="modal" v-loading="modalLoading">
          <el-form ref="form" :model="contact" label-width="120px">
            <p>以下の申し込みを断ります。<br />この操作では相手に通知やメッセージは送らせません。</p>
            <el-form-item label="パートナー">
              <p>{{contact.schedule.team_name}}</p>
            </el-form-item>
            <el-form-item label="日付">
              <p>{{contact.schedule.date}}</p>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="onSubmitReject">決定</el-button>
              <el-button @click="showRejectModal=false">キャンセル</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return {
        title: "",
        reply: "",
        contact: {schedule: {}},
        messages: [],
        showReply: false,
        loading: true,
        showAddScheduleModal: false,
        showRejectModal: false,
        modalLoading: false
      }
    },
    props: ["error_exist"],
    created: function(){
      axios.get("/api/contacts/" + this.$route.params.id)
      .then(res => {
        this.messages = res.data.messages
        this.contact = res.data.contact
        this.loading = false
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.modalLoading = false
        this.modalOpen = false
      })
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
      },
      onSubmit: function(){
        this.loading = true
        axios.patch("/api/contacts/"+this.$route.params.id,{
          text: this.reply
        })
        .then(res => {
          var message = res.data.message
          this.messages.splice(this.messages.length, 1, message)
          this.$message("送信しました")
          this.reply = ""
          this.showReply = false
          this.loading = false
        })
        .catch(er => {
          this.$message("送信に失敗しました")
          this.loading = false
        })
      },
      onSubmitSchedule: function(){
        this.modalLoading = true
        axios.patch("/api/requests/" + this.contact.id, {
          schedule: {
            date: this.contact.schedule.date,
            team_id: this.contact.schedule.target_team_id,
          }
        })
        .then(res => {
          this.$message("スケジュールに登録しました。ご確認ください。")
          this.modalLoading = false
          this.showAddScheduleModal = false
        })
        .catch(er => {
          this.$message("登録に失敗しました")
          this.modalLoading = false
          this.showAddScheduleModal = false
        })
      },
      onSubmitReject: function(){
        this.modalLoading = true
        axios.delete("/api/requests/" + this.contact.id, {})
        .then(res => {
          this.$message("処理が完了しました。")
          this.modalLoading = false
          this.showRejectModal = false
        })
        .catch(er => {
          this.$message("登録に失敗しました")
          this.modalLoading = false
          this.showRejectModal = false
        })
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
