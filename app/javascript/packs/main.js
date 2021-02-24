/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.nv
// import 'bootstrap'
// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")
// require("jquery-ui")
// require("home/home_page.js")


import Vue from 'vue'
import VueRouter from 'vue-router'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import router from './routes.js'
import App from './app.vue'
import store from './store'


Vue.use(Vuetify)
Vue.use(VueRouter)


new Vue({
  store,
  router: router,
  template: '<App/>',
  components: { App },
  vuetify: new Vuetify()
}).$mount('#app');
