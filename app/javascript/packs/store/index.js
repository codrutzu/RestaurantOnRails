import Vue from 'vue';
import Vuex from 'vuex'
import axios from 'axios';
import getCurrentUser from './api'

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    currentUser: null
  },


  getters: {
    currentUser: state => state.currentUser
  },

  mutations: {
    currentUser(state, user) {
      state.currentUser = user
    }
  },

  actions: {
    currentUser(context) {
      let uri = `http://localhost:3000/api/v1/users/current_user`
      const currentUser = getCurrentUser();
      axios.get(uri).then(resp => {
        context.commit('currentUser', resp.data);
      })
    }
  }
})

export default store;