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
      )
        div.pt-12.mx-16.font-weight-bold.text-center(
        :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
        ) You need to sign in order to be able to order
        v-form
          v-layout(mx-16 mt-6 flex-column justify-center)
            v-flex.mb-3
              v-text-field(
                label="Email"
                name='email'
                v-model="user.email"
                v-validate="'required'"
                :error-messages="errors.collect('email')"
              )
              v-flex.mb-3
                v-text-field(
                  label="Password"
                  name="password"
                  type="password"
                  v-model="user.password"
                  v-validate="'required'"
                  :error-messages="errors.collect('password')"
                )
              v-flex.mb-3
                v-btn.mt-4(
                  text
                  color="black"
                  key="RESET"
                  to="/reset-password"
                ) Forgot your password?
              <input type="checkbox" v-model="rememberMe">
              <label for="checkbox" class="checkbox-title"> Remember me</label>
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
  name: 'LoginComponent',

  data() {
    return {
      user: {
        email: '',
        password: ''
      },
      rememberMe: false

    }
  },

  methods: {
    ...mapActions({
      login: 'login',
      getCurrentUser: 'currentUser'
    }),

    clearInputs() {
      this.user.email = '',
      this.user.password = ''
    },

    submit() {
      this.login({
        session: {
          email: this.user.email,
          password: this.user.password,
          rememberMe: this.rememberMe ? '1' : '0'
        }
      }).then(resp => {
        if(resp.status == 200) {
          this.getCurrentUser();
          this.$router.push("/")
          this.$toaster.success('You are now logged in!')
        }
        else {
          this.clearInputs();
          this.$toaster.error('Invalid username or password.')
        }
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