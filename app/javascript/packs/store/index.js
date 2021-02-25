import Vue from 'vue';
import Vuex from 'vuex'
import axios from 'axios';

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
      let uri = `/api/v1/users/current_user`
      axios.get(uri).then(resp => {
        context.commit('currentUser', resp.data);
      })
      .catch(error => {
        context.commit('currentUser', 'noUser')
        return Promise.reject(error)
      })
    }
  }
})

export default store;