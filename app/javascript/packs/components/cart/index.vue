<template lang="pug">
  v-container(
    fluid
    justify-center
  )
    v-row.mt-12.mx-16.my-16
      v-col.checkout-form
        v-card.purchase-form
          div.pt-6.font-weight-bold.text-center(
          :class="{ 'mb-4': $vuetify.breakpoint.xsOnly}"
          ) Complete your purchase
          v-form
            v-layout(mx-16 mt-6 flex-column justify-center)
              v-text-field(
                label="Address"
                name='address'
                v-model="order.address"
                v-validate="'required'"
                :error-messages="errors.collect('address')"
              )
              v-autocomplete(
                :items="RomaniaCities"
                v-model="order.city"
                label="City"
                name='city'
                v-validate="'required'"
                :error-messages="errors.collect('city')"
              )
              v-text-field(
                label="Phone"
                name="Phone"
                v-model="order.phone"
                v-validate="{ required: true, regex: /^(07[0-8]{1}[0-9]{1}){1}[0-9]{6}$/}"
                :error-messages="errors.collect('Phone')"
              )
            v-layout(pb-6 mx-4 d-flex align-center)
              v-flex(order-xs1 order-sm1)
              v-flex(order-xs2 order-sm2)
              v-flex(order-xs3 order-sm3)
                v-btn.mt-4(
                  @click="submit"
                  rounded depressed block
                  color="#521414"
                  :disabled="cart_products.length == 0"
                  class="white--text"
                ) Submit
      v-flex.flex-md-column
        div.mb-2(
          style="font-size: 30px; font-weight: bold"
        ) Shopping Cart
        div.mb-5(
          style="font-size: 16px; color: rgba(0,0,0, 0.5)"
        ) You have {{ cart_products.map(x => x.quantity).reduce((a, b) => a + b, 0) }} items in cart
        v-col(
          class="d-flex justify-end"
          v-for="product in cart_products"
        )
          v-flex
            v-card.d-flex(
              max-width="600px"
              elevation="10"
            )
              v-flex.d-flex.pa-5.align-center
                v-img(
                  :src="product.product_image"
                  max-width="50"
                  min-width="50"
                )
                div.product-desc
                  div.product-name {{ product.product_name }}
                  div.product-weight {{ product.weight }} g
              v-flex.d-flex.pa-5.align-center
                div.product-dashboard.d-flex.align-center
                  v-icon.add-product(
                    v-on:click="handleAddToCart(product.product_id)"
                    dense
                  ) mdi-plus
                  div.product-quantity {{ product.quantity }}
                  v-icon.delete-product(
                    v-on:click="handleDeleteFromCart(product.id)"
                    dense
                  ) mdi-minus
                  div.product-price $ {{ product.price }}
              v-icon.product-bin(
                medium
                style="margin-right: 20px"
                v-on:click="handleEmptyCart(product.product_id)"
              ) mdi-delete





</template>

<script>
import axios from 'axios';

import { mapActions, mapGetters } from 'vuex'
const cities = require('romanian-cities');

export default {
  name: 'CartComponent',
  data() {
    return {
      order: {
        address: '',
        city: '',
        phone: ''
      },
      cart_products: []
    }
  },

  mounted() {
    this.getProducts().then(resp => {
      if(resp.status == 200) {
        this.cart_products = resp.data;
      }
    })
  },

  methods: {
    ...mapActions({
      getProducts: 'getCartProducts',
      emptyCart: 'emptyCart',
      decrementCartCount: 'decrementCartCount',
      emptyCart: 'emptyCart',
      incrementCartCount: 'incrementCartCount',
      setCartCount: 'setCartCount'
    }),

    submit() {
      axios
        .post('/api/v1/orders', { order: this.order })
        .then(response => {
            const status =
              JSON.parse(response.status);
            const id = response.data

            //redirect logic
            if (status == '200') {
              this.emptyCart()
              this.$router.replace(`/orders/${id}`);
            }
        })
    },

    handleAddToCart(product_id) {
      this.incrementCartCount();
      axios
        .post('/api/v1/cart_products', { id: product_id })
        .then(resp => {
            if(resp.status == 200) {
              this.cart_products = resp.data
            }
        })
    },

    handleDeleteFromCart(id) {
      this.decrementCartCount();
      axios
        .delete(`/api/v1/cart_products/${id}`)
        .then(resp => {
          if(resp.status == 200) {
            this.cart_products = resp.data
          }
        })
    },

    handleEmptyCart(product_id) {
      this.emptyCart(product_id)
        .then(resp => {
          if(resp.status == 200) {
            this.cart_products = resp.data['products']
            this.setCartCount(resp.data['products_count'])
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
  margin-top: 200px;
  padding: 0 10%;
}

.checkout-form {
  min-width: 400px;
}

.v-image {
  margin-left: -2px;
}

.v-card {
  border-radius: 20px;
  margin: auto;
  box-shadow: 0 1px 0px -100px rgba(0,0,0,.2),0 10px 5px 1px rgba(0,0,0, 0),0 4px 18px 3px rgba(0,0,0, 0.1)!important
}

.font-weight-bold {
  font-size: 22px;
  font-weight: 600;
}

.v-icon::after {
  background-color: transparent;
}

.product-bin, .add-product, .delete-product {
  cursor: pointer;
}

.product-bin:hover {
  color: red;
}

.product-desc {
  padding: 0 7%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.v-image__image {
    background-repeat: no-repeat;
}

.product-name {
  font-size: 20px;
  font-weight: 600;
}

.product-price {
  margin-left: 35px;
  font-size: 22px;
  font-weight: bold;
}

.product-quantity {
  border: 2px solid rgba(0,0,0,.2);
  width: 35px;
  height: 35px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  color: rgba(0,0,0, .6);
  margin: 0 .5em;
}
.product-weight {
  font-size: 12px;
  color: rgba(0,0,0, 0.7)
}

</style>