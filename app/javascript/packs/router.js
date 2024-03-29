import Vue from 'vue'
import VueRouter from 'vue-router'

import Todo from './components/todo/index.vue'
import Home from './components/home/index.vue'
import HomeCalender from './components/home/calender.vue'
import HomeSetting from './components/home/setting.vue'
import Contacts from './components/contact/index.vue'
import Contact from './components/contact/show.vue'
import Teams from './components/teams/index.vue'
import Team from './components/teams/show.vue'
import Members from './components/members/index.vue'
import EditMember from './components/members/edit.vue'

Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        {path: '/', component: Home, name: "home"},
        {path: '/todo', component: Todo, name: "todo"},
        {path: '/calender', component: HomeCalender, name: 'calender'},
        {path: '/setting', component: HomeSetting, name: 'setting'},
        {path: '/contacts', component: Contacts, name: 'contacts'},
        {path: '/contact/:id', component: Contact, name: 'contact'},
        {path: '/teams', component: Teams, name: 'teams'},
        {path: '/teams/:id', component: Team, name: 'team'},
        {path: '/members', component: Members, name: 'members'},
        {path: '/edit', component: EditMember, name: 'edit'}
    ]
})

export default router