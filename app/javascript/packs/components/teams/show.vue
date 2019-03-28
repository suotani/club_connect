<template>
  <div class="team-content-wrapper" v-loading="loading">
    <div class="team-info px-4 py-4">
      <h2>{{team.school}} {{team.category}}</h2>
      <el-carousel :interval="4000" type="card" height="200px">
        <el-carousel-item v-for="item in photos" :key="item">
          <h3>{{ item }}</h3>
        </el-carousel-item>
      </el-carousel>
      <h3>
        <i class="fas fa-angle-double-left"></i>紹介<i class="fas fa-angle-double-right"></i>
      </h3>
      <p class="content-text">{{team.introduction}}</p>
      <h3>
        <i class="fas fa-angle-double-left"></i>メンバの構成<i class="fas fa-angle-double-right"></i>
      </h3>
      <p class="content-text">{{team.member}}</p>
      <h3>
        <i class="fas fa-angle-double-left"></i>代表連絡先<i class="fas fa-angle-double-right"></i>
      </h3>
      <div class="leader-info content-text">
        <h4>代表</h4>
        <p class="content-text">
          {{team.leader}}<br />
          {{team.leaderEmail}}
        </p>
        <h4>副代表</h4></h4>
        <p class="content-text">
          {{team.subLeader}}<br />
          {{team.subLeaderEmail}}
        </p>
      </div>
    </div>
    <div class="calender-wrapper">
      <h2>予定表</h2>
      <div class="block">
        <el-date-picker
          v-on:change="changeMonth"
          v-model="currentDate"
          type="month"
          value-format="yyyy/M"
          placeholder="Pick a month">
        </el-date-picker>
      </div>
      <table class="calender">
        <thead>
          <tr>
            <th>日にち</th>
            <th>予定</th>
            <th>募集</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="date in dayCount">
            <td class="tx-center">{{date}}</td>
            <td>
              <ul>
                <li v-for="plan in findSchedule(date).plans">{{plan}}</li>
              </ul>
            </td>
            <td class="tx-center">
              <p v-if="findSchedule(date).request">募集してます</p>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default{
    data(){
      return{
        team: {},
        photos: [],
        currentDate: "2019/4",
        dayCount: 0,
        schedules: [
          {day: 1, plans: ["練習試合", "練習"], request: true},
          {day: 9, plans: ["練習試合", "練習"], request: false},
          {day: 20, plans: ["練習試合", "練習"], request: true},
        ],
        loading: true
      }
    },
    created: function(){
      // get team
      this.team = {
        school: "奈良教育大学",
        category: "バレーボール部",
        level: "地区大会優勝程度",
        member: "1年生一人、2年生3人",
        leader: "魚谷　知司",
        introduction: "こういう人たちです。",
        leaderEmail: "s.uotani@kobe.un.com",
        subLeader: "魚谷　知司",
        subLeaderEmail: "s.uotani@kobe.un.com",
      },
      this.photos = [1,2,3,4,5],
      this.dayCount = 31,
      this.loading = false
    },
    methods: {
      findSchedule: function(day){
        let schedule = this.schedules.find(function(element) {
          return element.day === day;
        });
        if(schedule === undefined){
          schedule = {plans: [], request: false}
        }
        return schedule
      },
      changeMonth: function(){
        console.log(this.currentDate)
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
  .tx-center{
    text-align:center;
  }
  .el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }

  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }

  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
</style>