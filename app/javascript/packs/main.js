import Vue from 'vue'
import router from './router.js'
import App from './app.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import axios from 'axios'

Vue.use(ElementUI)

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
