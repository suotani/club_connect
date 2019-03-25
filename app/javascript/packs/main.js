import Vue from 'vue'
import router from './todo_router.js'
import Todo from './todo.vue'

new Vue({
  el: '#todo',
  router,
  render: h => h(Todo)
})
