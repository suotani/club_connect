import Vue from 'vue'
import VueRouter from 'vue-router'

import Todo from './components/todo/index.vue'
import Home from './components/home/index.vue'

Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        {path: '/', component: Home, name: "home"},
        {path: '/todo', component: Todo, name: "todo"},
    ]
})

export default router