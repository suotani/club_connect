import Vue from 'vue'
import router from './router.js'
import store from './store.js'
import App from './app.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI)

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
