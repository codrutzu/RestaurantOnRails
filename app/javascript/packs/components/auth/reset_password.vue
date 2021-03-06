<template lang="pug">
v-container(fluid, justify-space-around)
  v-flex(md-8, d-flex, align-end, justify-center)
    v-card.card-border-medium
      .pt-12.mx-16.font-weight-bold.text-center(
        :class="{ 'mb-4': $vuetify.breakpoint.xsOnly }"
      ) Just enter the email you used to sign up and we'll send you a link to reset it
      v-form
        v-layout(mx-16, mt-6, flex-column, justify-center)
          v-flex.mb-3
            v-text-field(label="Email", name="email", v-model="email")
          v-layout(pb-6, mx-4, d-flex, align-center)
            v-flex(order-xs1, order-sm1)
            v-flex(order-xs2, order-sm2)
            v-flex(order-xs3, order-sm3)
              v-btn.mt-4.white--text(
                @click="submit",
                rounded,
                depressed,
                block,
                color="#521414"
              ) Submit
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
        console.log('cevatest')
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
</style>