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
        v-img(
          :src="require('../../images/login.svg')"
        )
        div.pt-12.pb-6.font-weight-bold.text-center(
        :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
        style="font-size: 18px; margin: 20px 80px"
        ) You need to sign to place an order
        v-form
          v-layout(mt-6 flex-column justify-center)
            v-flex.mb-6(
              style="padding: 0 20%"
            )
              v-text-field(
                label="Email"
                name='email'
                v-model="user.email"
                append-icon="mdi-account"
                v-validate="'required'"
                :error-messages="errors.collect('email')"
              )
              v-flex.mb-6
                v-text-field(
                  label="Password"
                  name="password"
                  :type="marker ? 'password' : 'text'"
                  v-model="user.password"
                  v-validate="'required'"
                  :append-icon="marker ? 'mdi-eye-off' : 'mdi-eye'"
                  @click:append="toggleMarker()"
                  :error-messages="errors.collect('password')"
                )
              <input type="checkbox" v-model="rememberMe">
              <label for="checkbox" class="checkbox-title"> Remember me</label>
            v-layout(pt-12 mb-4 mx-6 d-flex align-center justify-space-between)
              v-btn.mt-4(
                text
                color="black"
                key="RESET"
                to="/reset-password"
              ) Forgot your password?
              v-btn.mt-4(
                @click="submit"
                depressed
                style="border-radius: 10px"
                color="#521414"
                class="white--text"
              ) Log in

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
      marker: true,
      rememberMe: false

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
      login: 'login',
      getCurrentUser: 'currentUser'
    }),

    clearInputs() {
      this.user.email = "",
      this.user.password = ""
    },

    toggleMarker() {
      this.marker = !this.marker;
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

.card-border-medium {
  position: relative;
}

.card-border-medium .v-image{
  max-width: 200px;
  position: absolute;
  left: 70px;
  top: -90px;
}

.checkbox-title {
  margin-left: 8px;
  font-weight: 600;
}

.login-form {
  max-width: 500px
}
</style>