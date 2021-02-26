import VueRouter from 'vue-router'

import HomePage from './components/home_page/index.vue'
import CartComponent from './components/cart/index.vue'
import QrCodeComponent from './components/order/show.vue'
import LoginComponent from './components/auth/index.vue'
import RegisterComponent from './components/auth/index.vue'

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
    },
    {
      path: '/cart',
      component: CartComponent,
      name: 'cart_path'
    },
    {
      path: '/orders/:id',
      component: QrCodeComponent,
      name: 'order_path'
    },
    {
      path: '/login',
      component: LoginComponent,
      name: 'login_path'
    },
    {
      path: '/register',
      component: RegisterComponent,
      name: 'register_path'
    }
  ]
})

export default router;