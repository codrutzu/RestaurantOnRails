<template lang="pug">
  v-container
    Tabs(:tabLinks="courseTabLinks")
    v-row
      v-col.mb-16(
        v-if="this.$route.name === 'login_path'"
      )
        LoginComponent
      v-col.mb-16(
        v-if="this.$route.name === 'register_path'"
      )
        RegisterComponent
</template>

<script>

import LoginComponent from './LoginComponent'
import RegisterComponent from './RegisterComponent'
import Tabs from '../common/Tabs'

export default {
  name: 'AuthComponent',
  data() {
    return {
      courseTabLinks: [
        {
          link: 'login_path',
          name: 'Login'
        },
        {
          link: 'register_path',
          name: 'Register'
        }
      ]
    }
  },

  components: {
    Tabs,
    LoginComponent,
    RegisterComponent
  }
}
</script>