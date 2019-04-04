import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    team_query: {
      school: "",
      category_id: "",
      school_type: "",
      page: 1
    },
    teams: [],
    categories: [],
  },
  getters: {
    team_query(state){return state.team_query}
  },
  mutations: {
    setTeamQuery(state, payload){
      state.team_query = payload.team_query
    },
    setTeamQueryPage(state, payload){
      state.team_query.page = payload.page
    }
  },
  actions: {
    updateTeamQuery({commit}, team_query){
      commit('setTeamQuery', {team_query})
    },
    updateTeamQueryPage({commit}, page){
      commit('setTeamQueryPage', {page})
    }
  }
})

export default store