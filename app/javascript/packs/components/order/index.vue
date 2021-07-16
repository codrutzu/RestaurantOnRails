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
        <template v-slot:item.qr_code="{ item }">
          v-icon(
            v-on:click="handleOrder(item.id)"
            dense
          ) mdi-qrcode
        </template>
    v-flex.mt-3
      h3.my-6 Confirmed orders
      v-data-table.mx-12(
        :headers="headers"
        :items="handled_orders"
        :items-per-page="5"
        class="elevation-1"
      )
        template(v-slot:item.qr_code="{ item }")
          v-icon(
            v-on:click="handleOrder(item.id)"
            dense
          ) mdi-qrcode
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
        { text: 'Scan code', value: 'qr_code', sortable: false }
      ]
    }
  },

  mounted() {
    this.getCurrentUser().then(resp => {
      if(resp.status == 401) {
        this.$toaster.error('Please log in!');
        this.$router.push("/")
      }
      else {
        this.fetchOrders();
      }
    })
  },


  methods: {
    ...mapActions({
      getOrders: 'getUserOrders',
      getCurrentUser: 'currentUser'
    }),

    handleOrder(id) {
      this.$router.replace(`/orders/${id}`);
    },

    fetchOrders() {
      this.getOrders().then(resp => {
        if(resp.status == 200) {
          this.handled_orders = resp.data['handled'];
          this.unhandled_orders = resp.data['unhandled']
        }
        else {
          this.$toaster.error('Something went wrong!');
          this.$router.push("/")
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