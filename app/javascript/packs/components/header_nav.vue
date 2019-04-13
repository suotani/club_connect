<template>
  <div style="width: 100%">
    <nav class="topbar mb-4 px-3 py-2">
      <ul class="icons">
        <li>

        </li>
      </ul>
      <div class="topbar-devider mx-4"></div>
      <div class="team-name px-3">
        <p>{{team.school}}<br />{{team.name}}</p>
      </div>
    </nav>
  </div>
</template>

<script>
import axios from 'axios'
export default{
  data(){
    return{
      team: {}
    }
  },
  created: function(){
    axios.get('/api/dashboard-info')
    .then(res =>{
      this.team = res.data.team
    })
  }
  
}
</script>

<style scoped>
  .topbar{
    height: 4.375rem;
    box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,69,.15);
    background-color: #fff;
    display: flex;
    justify-content: flex-end;
    box-sizing: border-box;
  }
  
  .icons{
    list-style: none;
    display: flex;
  }
  
  .icons li{
    align-self: center;
  }
  
  .icons i, .team-name{
    color: #858796;
  }
  
  .icons i{
    position: relative;
  }
  
  .icons i .count-info{
    position: absolute;
    top: -10px;
    right: -8px;
    color: white;
    background-color: red;
    font-size: 11px;
    padding: 0.25rem;
    border-radius: 20px;
  }
  
  .team-name{
    min-width: 6rem;
    text-align: center;
    display: flex;
  }
  
  .team-name p{
     text-align: right;
     align-self: center;
  }
  
  .topbar-devider{
    border-left: 1px solid #e3e6f0;
  }
</style>