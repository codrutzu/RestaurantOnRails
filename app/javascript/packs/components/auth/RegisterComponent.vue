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
                type="text"
                v-validate="'required'"
                v-model="user.name"
                :error-messages="errors.collect('name')"
              )
            v-flex.mb-3
              v-text-field(
                label="Email"
                v-validate="'required|email'"
                name='email'
                v-model="user.email"
                :error-messages="errors.collect('email')"
              )
              v-flex.mb-3
                v-text-field(
                  label="Password"
                  name="password"
                  type="password"
                  v-validate="'required'"
                  v-model="user.password"
                  :error-messages="errors.collect('password')"
                )
              v-flex.mb-3
                v-text-field(
                  label="Password"
                  name="password_confirmation"
                  type="password"
                  v-validate="'required'"
                  v-model="user.password_confirmation"
                  :error-messages="errors.collect('password_confirmation')"
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

  created() {
    this.getCurrentUser().then(resp => {
      if(resp.status == 200)
      {
        this.$router.push("/")
      }
    })
  },

  methods: {
    ...mapActions({
      login: 'register',
      getCurrentUser: 'currentUser'
    }),

    submit() {
      this.login({
          email: this.user.email,
          password: this.user.password,
          password_confirmation: this.user.password_confirmation,
          name: this.user.name
      }).then(resp => {
        if(resp.status == 200) {
          this.$toaster.success('Your account was successfully created!')
          this.$router.push('/login')
        }
        else {
          this.$toaster.error(resp.join("\n"))
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