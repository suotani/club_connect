import Vue from 'vue'
import NewTeam from './new_team.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI)

new Vue({
  el: '#app',
  render: h => h(NewTeam)
})
