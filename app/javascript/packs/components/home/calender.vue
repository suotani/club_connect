<template>
    <div class="calender-wrapper schedule">
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
      <table class="calender" v-loading="loading" v-if="!error_exist">
        <thead>
          <tr>
            <th class="schedule-day">日にち</th>
            <th class="schedule-status">合同練習</th>
            <th class="schedule-events">予定</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="s in schedules">
            <td class="tx-center schedule-day">{{s.day}}</td>
            <td class="tx-center schedule-status">
              <p v-if="s.request">募集中<el-button v-on:click="onRequestChange(s)" class="">変更する</el-button></p>
              <p v-else>募集していません<el-button v-on:click="onRequestChange(s)" class="change-button">変更する</el-button></p>
            </td>
            <td class="schedule-events">
              <ul>
                <li v-show="s.events.length !== 0" v-for="event in s.events">
                  {{event.text}}
                  <router-link :to= "{name: 'team', params: {id: event.team_id}}" v-if="event.team_name !=='' ">
                    ({{event.team_name}})
                  </router-link>
                </li>
                <el-button v-on:click="openScheduleModal(s.id, s.day)" size="small" type="primary" round>＋ 予定を追加</el-button>
              </ul>
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
              <el-button @click="modalOpen = false">キャンセル</el-button>
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
    axios.get('/api/calenders')
    .then(res => {
        this.schedules = res.data.schedules
        this.currentDate = res.data.currentDate
        this.prevMonth = res.data.prevMonth
        this.nextMonth = res.data.nextMonth
        this.loading = false
        this.$message("")
    })
    .catch(er => {
      this.$emit('appyl_error_message', er.response.data.message)
      this.loading = false
    })
  },
  props: ["error_exist"],
  computed: {

  },
  methods: {
    changeMonthTo: function(m){
      this.loading = true
      axios.get('/api/calenders', { params: {date: m} })
      .then(res => {
          this.schedules = res.data.schedules
          this.currentDate = res.data.currentDate
          this.prevMonth = res.data.prevMonth
          this.nextMonth = res.data.nextMonth
          this.loading = false
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
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
      axios.post("/api/calenders/update",{
        schedule: this.schedule
      })
      .then(res => {
        var index = self.schedules.findIndex(function(e){ return e.day === self.schedule.day})
        self.schedules[index].events.splice(self.schedules[index].events.length, 1, res.data.event)
        self.schedules[index].id = res.data.schedule_id
        self.modalLoading = false
        this.modalOpen = false
      })
      .catch(er => {
        this.$messager("登録に失敗しました")
        this.modalLoading = false
        this.modalOpen = false
      })
    },
    onRequestChange: function(schedule){
      this.loading = true
      axios.post("/api/schedules/update", {
        request: !schedule.request,
        date: this.currentDate,
        day: schedule.day,
        id: schedule.id
      })
      .then(res => {
        const index = this.schedules.findIndex(function(e) {return e === schedule})
        schedule.request = !schedule.request
        this.schedules.splice(index, 1, schedule)
        this.loading = false
      })
      .catch(er => {
        this.$message("登録に失敗しました")
        this.loading = false
      })
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
  .change-button{
    margin-left: 3px;
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

<style lang='scss'>
@media screen and (max-width:768px){
  .calender-wrapper{
    padding: 1rem 0.3rem;
  }
  .schedule{
    table.calender{
      width: 100%;
    }
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
          width: 5%;
          align-self: center;
          font-size: 20px;
          font-weight: 800;
        }
        .schedule-status{
          width: 95%;
          text-align: right;
        }
      }
    }
  }
}
</style>