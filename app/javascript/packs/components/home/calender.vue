<template>
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
      <table class="calender" v-loading="loading">
        <thead>
          <tr>
            <th>日にち</th>
            <th>予定</th>
            <th>合同練習・練習試合等</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="s in schedules">
            <td class="tx-center">{{s.date}}</td>
            <td>
              <ul>
                <li v-show="s.events.length !== 0" v-for="event in s.events">{{event}}</li>
                <button v-on:click="openScheduleModal(s.id)">予定を追加</button>
              </ul>
            </td>
            <td class="tx-center">
              <p v-if="s.request">募集中</p>
              <p v-else>募集する</p>
            </td>
          </tr>
        </tbody>
      </table>
      <div class="modal-wrapper" v-show="modalOpen">
        <div class="modal" v-loading="modalLoading">
          <el-form ref="form" :model="schedule" label-width="120px">
            <el-form-item label="予定">
              <el-input v-model="schedule.title"></el-input>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="onSubmit">更新</el-button>
              <el-button @click="modalClose">キャンセル</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
</template>

<script>
export default{
  data(){
    return{
      schedules: [],
      currentDate: "2019/1",
      nextMonth: "",
      prevMonth: "",
      loading: true,
      modalOpen: false,
      modalLoading: false,
      schedule: {title: ""}
    }
  },
  created: function(){
      this.loading = false,
      this.schedules = [
        {date: 1,  events: ["試合", "練習"], request: false},
        {date: 2,  events: ["試合", "練習"], request: false},
        {date: 3,  events: [], request: true},
        {date: 4,  events: [], request: true},
        {date: 5,  events: [], request: false},
        {date: 6,  events: [], request: false},
        {date: 7,  events: [], request: false},
        {date: 8,  events: [], request: false},
        {date: 9,  events: ["試合", "練習"], request: false},
        {date: 10, events: ["試合", "練習"], request: true},
      ]
  },
  computed: {

  },
  methods: {
    changeMonthTo: function(m){
      //update schedules, currentDate, nextMonth, prevMonth
    },
    changeMonth: function(){
      //update schedules, currentDate, nextMonth, prevMonth
    },
    openScheduleModal: function(){
      this.modalOpen = true
    },
    onSubmit: function(){
      this.modalLoading = true
    },
    modalClose: function(){
      this.modalOpen = false
    }
  }
}

</script>

<style scoped>
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

</style>