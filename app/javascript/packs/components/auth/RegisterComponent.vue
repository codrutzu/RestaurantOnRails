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
        v-img(
          :src="require('../../images/register.svg')"
        )
        div.pt-16.mx-16.font-weight-bold.text-center(
        :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
        style="font-size: 18px"
        ) Create an account now!
        v-form
          v-layout(mt-6 flex-column justify-center)
            v-flex.mb-3.px-16.mx-12
              v-text-field(
                label="Name"
                name="name"
                type="text"
                v-validate="'required'"
                v-model="user.name"
                :error-messages="errors.collect('name')"
              )
            v-flex.mb-3.px-16.mx-12
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
                  label="Password confirmation"
                  name="password_confirmation"
                  type="password"
                  v-validate="'required'"
                  v-model="user.password_confirmation"
                  :error-messages="errors.collect('password_confirmation')"
                )
            v-layout(pb-6 mx-4 mt-6 d-flex align-center justify-center)
              v-btn.mt-4(
                @click="submit"
                depressed
                color="#521414"
                class="white--text"
              ) Register

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
      if(this.password != this.password_confirmation) {
        this.$toaster.error('Password confirmation doesnt match!')
        return;
      }

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