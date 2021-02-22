import Vue from 'vue';
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    currentUser: {}
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
      context.commit('currentUser', axios.get(uri).then(resp => { console.log(resp.data); return resp.data } ))
    }
  }
})

export default store;