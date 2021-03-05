import Vue from 'vue';
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    currentUser: null,
    cartItemsCount: 0
  },


  getters: {
    currentUser: state => state.currentUser,
    cartItemsCount: state => state.cartItemsCount
  },

  mutations: {
    currentUser(state, user) {
      state.currentUser = user
    },

    cartItemsCount(state, newCount) {
      state.cartItemsCount = newCount
    }
  },

  actions: {
    currentUser(context) {
      let uri = `/api/v1/users/current_user`
      axios.get(uri).then(resp => {
        context.commit('currentUser', resp.data);
        context.commit('cartItemsCount', resp.data['items_count'])
      })
      .catch(error => {
        context.commit('currentUser', 'noUser')
        return Promise.reject(error)
      })
    },

    incrementCartCount(context) {
      context.commit('cartItemsCount', context.state.cartItemsCount + 1)
    },

    decrementCartCount(context) {
      context.commit('cartItemsCount', context.state.cartItemsCount - 1)
    },

    setCartCount(context, itemsCount) {
      console.log(itemsCount)
      context.commit('cartItemsCount', itemsCount)
    },

    emptyCart({context}, product_id) {
      try {
        const response = axios.patch(`api/v1/cart_products/${product_id}`)

        return response;
      }
      catch(error) {
        return error;
      }
    },

    async login({context}, credentials) {
      const { email, password, rememberMe } = credentials['session']
      let formData = new FormData();
      formData.set('session[email]', email);
      formData.set('session[password]', password);
      formData.set('session[rememberMe]', rememberMe);

      try {
        const response = await axios.post('/api/v1/sessions', formData)
        return response;
      }
      catch(error) {
        return error;
      }
    },

    async logout({context}) {
      try {
        const resp = await axios.delete('/api/v1/sessions')
        return resp
      }
      catch(error) {
        return error
      }
    },

    async emptyCart({context}, product_id) {
      try {
        const response = await axios.patch(`/api/v1/empty_cart/${product_id}`)
        return response;
      }
      catch(error) {
        return error
      }
    },

    async register({commit}, payload) {
      const { email, password, password_confirmation, name } = payload

      let formData = new FormData();
      formData.set('user[email]', email);
      formData.set('user[password]', password);
      formData.set('user[password_confirmation]', password_confirmation);
      formData.set('user[name]', name);

      try {
        const response = await axios.post('/api/v1/users', formData)
        return response;
      }
      catch(error) {
        return error.response.data.errors;
      }

    },

    async resetPassword({commit}, payload) {
      const { email } = payload

      let formData = new FormData();
      formData.set('password_reset[email]', email);

      try {

        const response = await axios.post('/api/v1/reset_password', formData)
        return response;
      }
      catch(error) {
        console.log(error)
        return Promise.reject(error)
      }
    },

    async updatePassword({commit}, payload) {
      const { password, password_confirmation, token } = payload

      let formData = new FormData();
      formData.set('user[password]', password)
      formData.set('user[password_confirmation]', password_confirmation)

      try {
        const response = await axios.patch(`/api/v1/reset_password/${token}`, formData)
        return response
      }

      catch(error) {
        console.log(error)
        return Promise.reject(error)
      }
    },

    async getUserOrders({commit}) {
      try {
        const response = await axios.get('/api/v1/users/orders')
        return response;
      }

      catch(error) {
        return Promise.reject(error)
      }
    },

    async getCartProducts({commit}) {
      try {
        const response = await axios.get('/api/v1/cart_products')
        return response
      }

      catch(error) {
        return Promise.reject(error)
      }
    }
  }
})

export default store;