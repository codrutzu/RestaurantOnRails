import VueRouter from 'vue-router'

import HomePage from './components/home_page/index.vue'
import CartComponent from './components/cart/index.vue'
import QrCodeComponent from './components/order/show.vue'
import LoginComponent from './components/auth/index.vue'
import RegisterComponent from './components/auth/index.vue'
import ResetPasswordComponent from './components/auth/reset_password.vue'
import ResetPasswordUpdateComponent from './components/auth/reset_password_update.vue'
import OrdersComponenet from './components/order/index.vue'

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
    },
    {
      path: '/reset-password',
      component: ResetPasswordComponent,
      name: 'reset_password_path'
    },
    {
      path: '/password-update/:id',
      component: ResetPasswordUpdateComponent,
      name: 'password_update_path'
    },
    {
      path: '/my-orders',
      component: OrdersComponenet,
      name: 'my_orders_path'
    }
  ]
})

export default router;