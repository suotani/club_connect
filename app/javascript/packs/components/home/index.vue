<template>
  <div v-loading="loading" v-if="!error_exist">
    <el-row :gutter="24" class="summary">
      <el-col :span="6">
        <el-card shadow="always" class="no-read-contact-count">
          <div class="inner-summary">
            <div class="summary-left">
              <h3>未読</h3>
              <p>{{no_read_contact_count}}件</p>
            </div>
            <div class="summary-right">
              <i class="fas fa-envelope"></i>
            </div>
          </div>
        </el-card>
      </el-col>
    
      <el-col :span="6">
        <el-card shadow="always" class="request-count">
          <div class="inner-summary">
            <div class="summary-left">
              <h3>申し込み</h3>
              <p>{{request_count}}件</p>
            </div>
            <div class="summary-right">
              <i class="fas fa-bell"></i>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="24" class="mt-4 main-wrapper">
      <el-col :span="15" class="schedules">
        <el-card class="block schedule">
          <div slot="header" class="clearfix">
            Schedule
          </div>
          <el-timeline>
            <el-timeline-item v-for="schedule in schedules" v-bind:timestamp="schedule.date" placement="top" v-bind:key="schedule.id">
              <el-card>
                <p v-for="event in schedule.events" class="event">
                  {{event.text}}
                  <span v-if="event.team !== ''">
                    (
                    <router-link :to= "{name: 'team', params: {id: event.team_id}}">
                      {{event.team}}
                    </router-link>
                    )
                  </span>
                </p>
              </el-card>
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
      
      <el-col :span="9" class="recentries">
        <el-card class="block teams">
          <div slot="header" class="clearfix">
            Recently Join
          </div>
          <div class="teams-body">
          <el-card v-for="team in teams" v-bind:key="team.id" class="joined-team">
            <div slot="header" class="clearfix">
              <router-link :to= "{name: 'team', params: {id: team.id}}">
                {{team.name}}
              </router-link>
            </div>
            <p>{{team.introduction}}</p>
          </el-card>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import axios from 'axios'
  export default{
    data(){
      return{
        request_count: 0,
        no_read_contact_count: 0,
        schedules: [],
        teams: [],
        loading: true
      }
    },
    props: ["error_exist"],
    created: function(){
      axios.get("/api/dashboard", {
        params: {}
      })
      .then(res => {
        this.request_count = res.data.request_count
        this.no_read_contact_count = res.data.no_read_contact_count
        this.schedules = res.data.schedules
        this.teams = res.data.teams
        this.loading = false
      })
      .catch(er => {
        this.$emit('appyl_error_message', er.response.data.message)
        this.loading = false
      })
    }
  }
</script>

<style scoped>
  .request-count{
    border-left: solid 7px rgba(0,255,0,0.8);
  }
  .request-count h3{
    color: rgba(0,255,0,0.8);
  }
  .no-read-contact-count{
    border-left: solid 7px #f6c23e;
  }
  .no-read-contact-count h3{
    color: #f6c23e;
  }
  
  .no-reply-contact-count{
    border-left: solid 7px #4e73df;
  }
  .no-reply-contact-count h3{
    color: #4e73df;
  }
  .block-head{
    background-color: #f8f9fc;
    border-bottom: 1px solid #e3e6f0;
  }
  
  .el-row.summary{
    display: flex;
    justify-content: flex-start;
  }
  
  .el-card__header{
    background-color: #f8f9fc;
    border-bottom: 1px solid #e3e6f0;
  }
  
  .el-card__body h3{
    margin: 11px 0 0;
    text-align: left;
    font-size: 15px;
  }
  
  .el-card__body p{
    font-size: 20px;
    text-align: left;
    margin-top: 5px;
    font-weight: 800;
  }
  
  .schedule .el-card__body p{
    font-size: 16px;
  }

  .teams .el-card__body p{
    font-size: 12px;
  }
  
  .inner-summary{
    display: flex;
    justify-content: space-between;
  }
  
  .summary-left{
    width: 50%;
  }
  .summary-right{
    width: 50%;
    font-size: 40px;
    align-self: center;
    color: rgba(0,0,0,0.3);
    text-align:center;
  }
  @media screen and (max-width:768px){
    .main-wrapper{
      display: flex;
      flex-wrap: wrap;
    }
    .schedules{
      width: 100%;
      margin: auto;
    }
    .recentries{
      width: 100%;
      margin: auto;
    }
    .teams-body{
      display: flex;
      flex-wrap: wrap;
    }
    .joined-team{
      width: 100%;
      box-sizing: border-box;
      padding: 3px;
    }
  }
</style>