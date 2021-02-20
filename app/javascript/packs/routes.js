import VueRouter from 'vue-router'

import HomePage from './components/home_page/index.vue'

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes: [
    {
      path: '/home',
      component: HomePage,
      name: 'home_page_path'
    },
    {
      path: '/', redirect: { name: 'home_page_path' }
    }
  ]
})

export default router;