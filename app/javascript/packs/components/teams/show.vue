<template>
  <div class="team">
    <div class="team-content-wrapper" v-loading="loading" v-if="!error_exist">
      <router-link :to= "{name: 'teams'}"><i class="fas fa-arrow-left"></i>戻る</router-link>
      <div class="team-info px-4 py-4">
        <div class="team-head">
          <h2>{{team.school}} {{team.category}}</h2>
          <el-button type="success" round v-on:click="messageModalShow = true">メッセージを送る</el-button>
        </div>
        <el-carousel :interval="4000" type="card" height="200px">
          <el-carousel-item v-for="item in photos" :key="item.id">
            <img v-bind:src="item.url"></img>
          </el-carousel-item>
        </el-carousel>
        <h3>
          <i class="fas fa-angle-double-left"></i>紹介<i class="fas fa-angle-double-right"></i>
        </h3>
        <p class="content-text">{{team.introduction}}</p>
        <h3>
          <i class="fas fa-angle-double-left"></i>メンバの構成<i class="fas fa-angle-double-right"></i>
        </h3>
        <p class="content-text">{{team.members}}</p>
        <h3>
          <i class="fas fa-angle-double-left"></i>代表連絡先<i class="fas fa-angle-double-right"></i>
        </h3>
        <div class="leader-info content-text">
          <h4>代表</h4>
          <p class="content-text">
            {{team.leader_name}}({{team.leader_role}})<br />
            {{team.leader_email}}
          </p>
          <h4>副代表</h4></h4>
          <p class="content-text">
            {{team.sub_leader_name}}({{team.sub_leader_role}})<br />
            {{team.sub_leader_email}}
          </p>
        </div>
      </div>
      <div class="calender-wrapper">
        <h2>予定表</h2>
        <div class="block month-select">
          <p class="move-month" v-on:click="changeMonthTo(prevMonth)"><< 前の月</p>
          <el-date-picker
            v-on:change="changeMonth"
            v-model="currentDate"
            type="month"
            value-format="yyyy/M"
            placeholder="Pick a month">
          </el-date-picker>
          <p class="move-month" v-on:click="changeMonthTo(nextMonth)">後ろの月 >></p>
        </div>
        <table class="calender" v-loading="calenderLoading">
          <thead>
            <tr>
              <th class="schedule-day">日にち</th>
              <th class="schedule-status">合同練習</th>
              <th clas="schedule-events">予定</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="schedule in schedules">
              <td class="tx-center schedule-day">{{schedule.day}}</td>
              <td class="schedule-status tx-center">
                <p v-if="schedule.request" class="request-open" v-on:click="modalOpen(schedule.id)">募集してます</p>
              </td>
              <td class="schedule-events">
                <ul>
                  <li v-for="event in schedule.events">
                    {{event.text}}
                    <router-link :to= "{name: 'team', params: {id: event.team_id}}" v-if="event.team_id !== null">
                      ({{event.team_name}})
                    </router-link>
                  </li>
                </ul>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
  
      <div class="modal-wrapper" v-show="modalShow">
        <div class="modal" v-loading="modalLoading">
          <el-form ref="form" :model="request" label-width="120px">
            <h3>合同練習・練習試合等の申請を行います。</h3>
            <el-form-item label="メッセージ">
              <el-input type="textarea" v-model="request.text" placeholder=""></el-input>
            </el-form-item>
  
            <el-form-item>
              <el-button type="primary" @click="onSubmit">申請する</el-button>
              <el-button @click="modalShow=false">キャンセル</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
  
      <div class="modal-wrapper" v-show="messageModalShow">
        <div class="modal" v-loading="modalLoading">
          <el-form ref="form" :model="message" label-width="120px">
            <h3>メッセージを送信します。</h3>
            <el-form-item label="title">
              <el-input type="text" v-model="message.title" placeholder=""></el-input>
            </el-form-item>
            <el-form-item label="メッセージ">
              <el-input type="textarea" v-model="message.text" placeholder=""></el-input>
            </el-form-item>
  
            <el-form-item>
              <el-button type="primary" @click="onMessageSubmit">送信する</el-button>
              <el-button @click="messageModalShow=false">キャンセル</el-button>
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
      return{
        team: {},
        photos: [],
        schedules: [],
        loading: true,
        modalLoading: false,
        calenderLoading: false,
        currentDate: "",
        prevMonth: "",
        nextMonth: "",
        modalShow: false,
        request: {},
        messageModalShow: false,
        message: {},
      }
    },
    props: ["error_exist"],
    created: function(){
      // get team
      axios.get('/api/teams/' + this.$route.params.id)
      .then(res => {
        this.team = res.data.team
        this.photos = res.data.images
        this.schedules = res.data.schedules
        this.currentDate = res.data.currentDate
        this.prevMonth = res.data.prevMonth
        this.nextMonth = res.data.nextMonth
        this.loading = false
        this.request = {id: 0, text: ""}
        this.$emit('appyl_error_message', "")
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.loading = false
      })
    },
    methods: {
      changeMonth: function(){
        this.changeMonthTo(this.currentDate)
      },
      changeMonthTo: function(m){
        this.calenderLoading = true
        axios.get('/api/calenders/' + this.team.id, { params: {date: m} })
        .then(res => {
          this.schedules = res.data.schedules
          this.currentDate = res.data.currentDate
          this.prevMonth = res.data.prevMonth
          this.nextMonth = res.data.nextMonth
          this.calenderLoading = false
        })
        .catch(er => {
          this.$message("エラーが発生しました。")
          this.calenderLoading = false
        })
      },
      onSubmit: function(){
        this.modalLoading = true
        axios.post("/api/requests", {
          request: {
            schedule_id: this.request.id,
            to_team_id: this.team.id
          },
          text: this.request.text
        })
        .then(res =>{
          this.$message("リクエストを送信しました")
          this.modalLoading = false
          this.modalShow = false
        })
        .catch(er => {
          this.$message("エラーが発生しました。")
          this.modalLoading = false
          this.modalShow = false
        })
      },
      modalOpen: function(id){
        this.modalShow = true
        this.request.id = id
      },
      onMessageSubmit:function(){
        this.modalLoading = true
        axios.post("/api/contacts",{
          id: this.team.id,
          title: this.message.title,
          text: this.message.text
        })
        .then(res =>{
          this.message.title = ""
          this.message.text = ""
          this.messageModalShow = false
          this.$message("メッセージを送信しました。返信はメールボックスから確認できます")
          this.modalLoading = false
        })
        .catch(er => {
          this.message.title = ""
          this.message.text = ""
          this.$message("エラーが発生しました。")
          this.messageModalShow = false
          this.modalLoading = false
        })
      }
    }
  }
</script>

<style>

  h2{
    text-align: left;
    margin: 0;
  }
  h3{
    text-align: center;
  }

  .team-content-wrapper{
    width: 97%;
    margin:auto;
    margin-bottom: 2rem;
  }
  .team-head{
    display: flex;
    justify-content:space-between;
    flex-wrap: wrap;
    margin-bottom: 10px;
  }
  .team-info{
    box-shadow: 0.25rem 0.15rem 1rem 0.25rem rgba(58,59,69,.15);
  }
  
  .content-text{
    width: 70%;
    margin: auto;
  }
  
  .calender-wrapper{
    box-shadow: 0.25rem 0.15rem 1rem 0.25rem rgba(58,59,69,.15);
    margin-top: 2rem;
    padding: 1rem;
  }
  
  table.calender{
    width: 80%;
    margin: auto;
    margin-top: 1rem;
    border-collapse: collapse;
  }
  
  table.calender tbody tr{
    border-bottom: solid 1px rgba(0,0,0,0.3);
    margin-bottom: 0.5rem;
  }
  
  table.calender tbody td.day{
    text-align: center;
  }
  
  table.calender thead tr{
    border-bottom: solid 2px rgba(0,0,0,0.3);
  }
  
  table.calender thead th{
    padding-bottom: 5px;
  }
  
  table.calender td{
    padding-bottom: 5px;
    padding-top: 5px;
  }
  
  .tx-center{
    text-align:center;
  }
  .month-select{
    display: flex;
    justify-content: space-around;
    align-items: center;
  }
  .month-select .move-month{
    cursor: pointer;
    color: rgba(0,0,255,0.8);
    font-weight: 800;
  }
  
  .request-open{
    cursor: pointer;
    color: rgba(0,0,255,0.8);
  }

  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }

  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
  
  .el-carousel__item{
    text-align: center;
  }
  
  .el-carousel__item img{
    height: 100%;
  }
</style>

<style lang='scss'>
@media screen and (max-width:768px){
  .team{
    .main-content{
      padding: 0.2rem !important;
    }
    .content-text{
      width: 95%;
      word-wrap: break-word;
    }
    h2{
      font-size: 18px;
    }
    .month-select .move-month{
      font-size: 12px;
    }
    .el-date-editor.el-input, .el-date-editor.el-input__inner{
      width: 100px;
    }
    .el-input--prefix .el-input__inner{
      padding-right: 10px;
    }
    .calender{
      width: 100%;
      tr{
        display: flex;
        flex-wrap: wrap;
      }
      .schedule-day{
        width: 30%;
        box-sizing: border-box;
        text-align: left;
      }
      .schedule-status{
        width: 70%;
        box-sizing: border-box;
      }
      .schedule-events{
        width: 100%;
      }
      thead .schedule-events{
        text-align: center;
      }
      tbody{
        .schedule-day{
          font-size: 20px;
          font-weight: 800;
        }
      }
    }
  }
}
</style>