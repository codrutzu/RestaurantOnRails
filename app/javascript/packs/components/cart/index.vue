<template lang="pug">
  v-container(
    fluid
    justify-space-around
  )
    v-row.mt-12.mx-16.my-16
      v-col.checkout-form
        v-card(

        )
          div.pt-6.font-weight-bold.text-center(
          :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
          ) Complete your purchase
          v-form
            v-layout(mx-16 mt-6 flex-column justify-center)
              v-text-field(
                label="Address"
                name='address'
                v-model="order.address"
              )
              v-autocomplete(
                :items="RomaniaCities"
                v-model="order.city"
                label="City"
                name='city'
              )
              v-text-field(
                label="Phone"
                name="phoneNumber"
                v-model="order.phone"
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
      v-col(
        class="d-flex justify-end"
      )
        | Test

</template>

<script>
import axios from 'axios';

import { mapGetters } from 'vuex'
const cities = require('romanian-cities');

export default {
  name: 'CartComponent',
  data() {
    return {
      order: {
        address: '',
        city: '',
        phone: ''
      }
    }
  },

  methods: {
    submit() {
      axios
        .post('/api/v1/orders', { order: this.order })
        .then(response => {
            const status =
              JSON.parse(response.status);
            const id = response.data

            //redirect logic
            if (status == '200') {
              this.$router.replace(`/orders/${id}`);
            }
        })
    }
  },

  computed: {
    ...mapGetters({
      currentUser: 'currentUser'
    }),

    RomaniaCities() {
      return cities.all.map(city => city.city)
    }
  }
}
</script>

<style scoped>

.container {
  margin-top: 124px;
}

.v-card {
  border-radius: 20px;
}

.checkout-form {
  max-width: 640px;
}

.font-weight-bold {
  font-size: 22px;
  font-weight: 600;
}

</style>