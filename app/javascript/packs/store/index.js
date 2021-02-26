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
    },

    login({context}, credentials) {
      const { email, password, rememberMe } = credentials['session']
      let formData = new FormData();
      formData.set('session[email]', email);
      formData.set('session[password]', password);
      formData.set('session[rememberMe]', rememberMe);

      axios.post('/api/v1/sessions', formData).
        then(resp => {
          window.location.href = window.location.origin
        })
      .catch(errors => {
        console.log(errors)
        return Promise.reject(errors)
      })
    },

    logout({context}) {
      axios.delete('/api/v1/sessions').
        then(resp => {
          window.location.href = window.location.origin
        })
      .catch(errors => {
        console.log(errors)
        return Promise.reject(errors)
      })
    },

    register({commit}, payload) {
      const { email, password, password_confirmation, name } = payload

      let formData = new FormData();
      formData.set('user[email]', email);
      formData.set('user[password]', password);
      formData.set('user[password_confirmation]', password_confirmation);
      formData.set('user[name]', name);

      axios.post('/api/v1/users', formData)
        .then(resp => {
          console.log(resp)
        })
      .catch(errors => {
        console.log(errors)
        return Promise.reject(errors)
      })
    }
  }
})

export default store;