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
        ) Enter the required informations
        v-form
          v-layout(mx-16 mt-6 flex-column justify-center)
            v-flex.mb-3
              v-text-field(
                label="Password"
                type="password"
                name='password'
                v-model="password"
              )
            v-flex.mb-3
              v-text-field(
                label="Password confirmation"
                type="password"
                name='password_confirmation'
                v-model="password_confirmation"
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
  name: 'ResetPasswordUpdateComponent',
  data() {
    return {
      password: '',
      password_confirmation: ''
    }
  },

  methods: {
    ...mapActions({
      updatePass: 'updatePassword'
    }),

    validatePasswords() {
      return (this.password != this.password_confirmation)
    },

    submit() {
      if (this.validatePasswords()) {
        this.$toaster.error('Password doesnt match password confirmation')
        return
      }
      this.updatePass({
        password: this.password,
        password_confirmation: this.password_confirmation,
        token: this.$route.params.id
      }).then(resp => {
        if(resp.status == 200) {
          this.$router.push('/')
        }
        else {
          this.$toaster.error('Something went wrong')
        }
      })
    }
  }
}
</script>