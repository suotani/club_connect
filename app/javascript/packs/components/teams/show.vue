<template>
  <div class="team-content-wrapper" v-loading="loading">
    <div class="team-info px-4 py-4">
      <h2>{{team.school}} {{team.category}}</h2>
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
            <th>日にち</th>
            <th>予定</th>
            <th>合同練習・練習試合等</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="schedule in schedules">
            <td class="tx-center">{{schedule.day}}</td>
            <td>
              <ul>
                <li v-for="event in schedule.events">{{event}}</li>
              </ul>
            </td>
            <td class="tx-center">
              <p v-if="schedule.request" class="request-open" v-on:click="modalOpen(schedule.id)">募集してます</p>
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
        request: {}
      }
    },
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
        this.loading = false,
        this.request = {id: 0, text: ""}
      });
    },
    methods: {
      changeMonth: function(){
        this.changeMonthTo(this.currentDate)
      },
      changeMonthTo: function(m){
        this.calenderLoading = true
        axios.get('/api/teams/' + this.team.id + "/change_calender", { params: {date: m} })
        .then(res => {
          this.schedules = res.data.schedules
          this.currentDate = res.data.currentDate
          this.prevMonth = res.data.prevMonth
          this.nextMonth = res.data.nextMonth
          this.calenderLoading = false
        });
      },
      onSubmit: function(){
        
      },
      modalOpen: function(id){
        this.modalShow = true
        this.request.id = id
      },
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
  .modal-wrapper{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.2);
  }
  
  .modal{
    width: 600px;
    padding: 1rem;
    margin: auto;
    margin-top: 100px;
    background-color: white;
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