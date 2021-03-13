<template lang="pug">
  v-container(fluid, justify-space-around)
    v-flex(md-8 d-flex align-center justify-center
      style="margin-top: 100px"
    )
      v-form
        h2(
          style="font-weight: 700; margin-bottom: 10px"
        ) Forgot your password?
        h6.my-6(
          style="color: #656565"
        ) Enter the email you used to sign up
        v-text-field(
          dense
          outlined
          name="email"
          v-model="email"
          style="width: 290px; margin: 0 auto;"
        )
        v-btn.mt-4(
          @click="submit"
          depressed
          style="width: 100px"
          color="#521414"
          class="white--text"
        ) Send
      v-img(
        :src="require('../../images/reset_password.svg')"
      )

</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "ResetPasswordComponent",

  data() {
    return {
      email: "",
    };
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
      resetPassword: "resetPassword",
      getCurrentUser: 'currentUser'
    }),

    clearInputs() {
      this.email = ""
    },

    submit() {
      this.resetPassword({
        email: this.email,
      }).then(resp => {
        if (resp.status == 200) {
          this.$router.replace("/");
        }
        else {
          this.$toaster.error("Invalid email")
        }
      });
    },
  },
};
</script>

<style scoped>

.v-image {
  max-width: 350px;
}

</style>