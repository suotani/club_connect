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
            <td class="tx-center">{{s.day}}</td>
            <td>
              <ul>
                <li v-show="s.events.length !== 0" v-for="event in s.events">{{event}}</li>
                <button v-on:click="openScheduleModal(s.id, s.day)">予定を追加</button>
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
              <el-input v-model="schedule.text"></el-input>
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
import axios from 'axios'
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
      schedule: {text: "", id: "", day: 0}
    }
  },
  created: function(){
    axios.get('/api/calender')
    .then(res => {
        this.schedules = res.data.schedules
        this.currentDate = res.data.currentDate
        this.prevMonth = res.data.prevMonth
        this.nextMonth = res.data.nextMonth
        this.loading = false
    })
  },
  computed: {

  },
  methods: {
    changeMonthTo: function(m){
      this.loading = true
      axios.get('/api/calender/', { params: {date: m} })
      .then(res => {
          this.schedules = res.data.schedules
          this.currentDate = res.data.currentDate
          this.prevMonth = res.data.prevMonth
          this.nextMonth = res.data.nextMonth
          this.loading = false
      })
    },
    changeMonth: function(){
      this.changeMonthTo(this.currentDate)
    },
    openScheduleModal: function(id, day){
      this.schedule = {id: id, day: day, date: this.currentDate}
      this.modalOpen = true
    },
    onSubmit: function(){
      this.modalLoading = true
      self = this
      axios.post("/api/calender_add_event",{
        schedule: this.schedule
      })
      .then(res => {
        var index = self.schedules.findIndex(function(e){ return e.day === self.schedule.day})
        self.schedules[index].events.splice(self.schedules[index].events.length, 1, self.schedule.text)
        self.schedules[index].id = res.data.schedule_id
        self.modalLoading = false
        this.modalOpen = false
      })
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