import Vue from 'vue'
import VueRouter from 'vue-router'

import Todo from './components/todo/index.vue'
import Home from './components/home/index.vue'
import HomeCalender from './components/home/calender.vue'
import HomeSetting from './components/home/setting.vue'
import Teams from './components/teams/index.vue'
import Team from './components/teams/show.vue'
import TeamCalender from './components/teams/calender.vue'
import TeamRequest from './components/teams/request.vue'
import Messages from './components/messages/index.vue'
import Message from './components/messages/show.vue'

Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        {path: '/', component: Home, name: "home"},
        {path: '/todo', component: Todo, name: "todo"},
        {path: '/calender', component: HomeCalender, name: 'calender'},
        {path: '/setting', component: HomeSetting, name: 'setting'},
        {path: '/teams', component: Teams, name: 'teams'},
        {path: '/teams/:id', component: Team, name: 'team'},
        {path: '/teams/:id/calender',component: TeamCalender, name: 'teamCalender'},
        {path: '/teams/:id/request', component: TeamRequest, name: 'request'},
        {path: '/messages', component: Messages, name: 'messages'},
        {path: '/messages/:id', component: Message, name: 'message'}
    ]
})

export default router