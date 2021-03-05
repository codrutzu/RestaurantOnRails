<template lang="pug">
  v-container.order-tables
    v-flex.mt-3
      h3.my-6 Unconfirmed orders
      v-data-table.mx-12(
        :headers="headers"
        :items="unhandled_orders"
        :items-per-page="5"
        class="elevation-1"
      )
    v-flex.mt-3
      h3.my-6 Confirmed orders
      v-data-table.mx-12(
        :headers="headers"
        :items="handled_orders"
        :items-per-page="5"
        class="elevation-1"
      )
    template(
      v-slot:items
    )
      td test
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'OrdersComponent',
  data() {
    return {
      handled_orders: [],
      unhandled_orders: [],
      headers: [
        { text: 'Address', value: 'address' },
        { text: 'City', value: 'city' },
        { text: 'Phone', value: 'phone' },
        { text: 'Scan code', value: 'qr_codes', sortable: false }
      ]
    }
  },

  mounted() {
    this.fetchOrders();
  },


  methods: {
    ...mapActions({
      getOrders: 'getUserOrders'
    }),

    fetchOrders() {
      this.getOrders().then(resp => {
        if(resp.status == 200) {
          this.handled_orders = resp.data['handled'];
          this.unhandled_orders = resp.data['unhandled']
        }
      })
    }
  }
}
</script>

<style scoped>

h3 {
  font-weight: 600;
}

.order-tables {
  display: flex
}

</style>