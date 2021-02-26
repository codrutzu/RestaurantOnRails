<template lang="pug">
  v-container(
    fluid
    justify-space-around
  )
    v-flex(
      md-8
      d-flex
      align-end
      justify-center
    )
      v-card.card-border-medium(
        min-width="500"
      )
        div.pt-12.mx-16.font-weight-bold.text-center(
        :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
        ) Create an account now!
        v-form
          v-layout(mx-16 mt-6 flex-column justify-center)
            v-flex.mb-3
                v-text-field(
                  label="Name"
                  name="name"
                  v-model="user.name"
                )
            v-flex.mb-3
              v-text-field(
                label="Email"
                name='email'
                v-model="user.email"
              )
              v-flex.mb-3
                v-text-field(
                  label="Password"
                  name="password"
                  type="password"
                  v-model="user.password"
                )
              v-flex.mb-3
                v-text-field(
                  label="Password"
                  name="password"
                  type="password"
                  v-model="user.password_confirmation"
                )
            v-layout(pb-6 mx-4 d-flex align-center)
              v-flex(order-xs1 order-sm1)
              v-flex(order-xs2 order-sm2)
              v-flex(order-xs3 order-sm3)
                v-btn.mt-4(
                  @click="submit"
                  rounded depressed block
                  color="#521414"
                  class="white--text"
                ) Submit

</template>

<script>

import { mapActions } from 'vuex'


export default {
  name: 'RegisterComponent',

  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  },

  methods: {
    ...mapActions({
      login: 'register'
    }),

    submit() {
      this.login({
          email: this.user.email,
          password: this.user.password,
          password_confirmation: this.user.password_confirmation,
          name: this.user.name
      }).then(resp => {
        console.log(resp)
        if(resp.status == 200)
          window.location.href = window.location.origin + '/login'
      })
    }
  }

}
</script>

<style>

.checkbox-title {
  margin-left: 8px;
  font-weight: 600;
}

.login-form {
  max-width: 500px
}
</style>