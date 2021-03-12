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
                dark
                label="Address"
                name='address'
                v-model="order.address"
                v-validate="'required'"
                :error-messages="errors.collect('address')"
              )
              v-autocomplete(
                dark
                :items="RomaniaCities"
                v-model="order.city"
                label="City"
                name='city'
                v-validate="'required'"
                :error-messages="errors.collect('city')"
              )
              v-text-field(
                dark
                label="Phone"
                name="Phone"
                v-model="order.phone"
                v-validate="{ required: true, regex: /^(07[0-8]{1}[0-9]{1}){1}[0-9]{6}$/}"
                :error-messages="errors.collect('Phone')"
              )
            v-layout(
              flex-column
              justify-center
            )
              div.mt-6(
                style="font-size: 21px"
              ) Card details
              v-flex.bank-cards.my-6
                v-img.card-logo#mc-logo(
                  contain
                  max-width="40"
                  max-height="40"
                  v-on:click="handleMC()"
                  :src="require('../../images/mc_symbol.svg')"
                )
                v-img.card-logo#visa-logo(
                  contain
                  max-width="40"
                  max-height="40"
                  v-on:click="handleVisa()"
                  :src="require('../../images/visa.svg')"
                )
              v-flex.card-details(
                flex-column
                justify-center
                style="width: 70%; margin: 0 auto;"
              )
                span(
                  style="font-size: 12px"
                ) Name on card
                v-text-field(
                  dark
                  name="card_name"
                  v-model="card.name"
                  v-validate="'required'"
                  :error-messages="errors.collect('card_name')"
                )
                span(
                  style="font-size: 12px"
                ) Card number
                v-text-field(
                  dark
                  name="card_number"
                  v-model="card.number"
                  placeholder="9432-4352-6543-6688"
                  v-validate="{ required: true, regex: /^([0-9]{4})-([0-9]){4}-([0-9]){4}-([0-9]){4}$/}"
                  :error-messages="errors.collect('card_number')"
                )
                v-flex(
                  d-flex
                )
                  v-flex(
                    flex-column
                    justify-start
                  )
                    span(
                      style="font-size: 12px"
                    ) Expiration date
                    v-flex(
                      d-flex
                    )
                      v-select(
                        dark
                        style="max-width: 100px; margin-right: 20px"
                        :items="months"
                        label="mm"
                        name="month"
                      )
                      v-select(
                        dark
                        width="30"
                        style="max-width: 100px"
                        :items="Array.from({length:10},(v,k)=>k+2020)"
                        name="year"
                        label="yyyy"
                      )
                v-flex(
                  flex-column
                  justify-start
                )
                  span(
                    style="font-size: 12px"
                  ) CVV
                  v-text-field(
                    style="width: 150px"
                    dark
                    name="cvv"
                    v-model="card.cvv"
                    placeholder="777"
                    v-validate="{ required: true, regex: /^[1-9]{3}$/ }"
                    :error-messages="errors.collect('cvv')"
                  )

            v-card-actions
                v-btn.mt-4(
                  @click="submit"
                  depressed block
                  color="#FDC07B"
                  :disabled="cart_products.length == 0"
                  style="font-size: 20px"
                  class="white--text"
                  height="90"
                ) CHECKOUT
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
        v-flex(
          d-flex
          justify-space-between
          align-center
          style="max-width: 600px; margin: 1.5em auto"
        )
          span(
            style="font-size: 20px; cursor: pointer"
            v-on:click="backToShopping()"
          ) Continue shopping
          v-spacer
          span.total(
            style="font-size: 28px; font-weight: 600; color: #FDC07B"
          ) {{ cart_products.reduce((a, b) => a + parseFloat(b.price), 0) }} $
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
      card: {
        number: '',
      },
      cart_products: [],
      months: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
    }
  },

  mounted() {
    this.getProducts().then(resp => {
      if(resp.status == 200) {
        this.cart_products = resp.data;
      }
      else {
        this.$router.push("/")
        this.$toaster.error(resp.data['message'])
      }
    })
  },

  methods: {
    ...mapActions({
      getProducts: 'getCartProducts',
      decrementCartCount: 'decrementCartCount',
      emptyCart: 'emptyCart',
      incrementCartCount: 'incrementCartCount',
      setCartCount: 'setCartCount'
    }),

    handleVisa() {
      const visa = document.getElementById('visa-logo')
      visa.style.filter = 'brightness(0) invert(1)';

      const mc = document.getElementById('mc-logo')
      mc.style.filter = 'brightness(1) invert(0)';
    },

    handleMC() {
      const mc = document.getElementById('mc-logo')
      mc.style.filter = 'brightness(0) invert(1)';

      const visa = document.getElementById('visa-logo')
      visa.style.filter = 'brightness(1) invert(0)';
    },

    backToShopping() {
      this.$router.push("/")
    },

    submit() {
      this.$validator.validateAll()
      if (!this.errors.any()) {
        this.$toaster.error('Please complete all fields');
        return
      }
      axios
        .post('/api/v1/orders', { order: this.order })
        .then(response => {
            const status =
              JSON.parse(response.status);
            const id = response.data

            //redirect logic
            if (status == '200') {
              this.setCartCount(0)
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
              this.$toaster.success('Product has been added to cart', { timeout: 1500 })
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
            this.$toaster.error('Product has been removed from cart', { timeout: 1500 })
          }
        })
    },

    handleEmptyCart(product_id) {
      this.emptyCart(product_id)
        .then(resp => {
          if(resp.status == 200) {
            this.cart_products = resp.data['products']
            this.setCartCount(resp.data['products_count'])
            this.$toaster.error('Products have been removed from cart', { timeout: 1500 })
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
  min-width: 600px;
  padding: 0;
}

.row {
  background-color: rgba(0, 0, 0, 0.02);
  align-items: center;
}

.card-details {
  text-align: left;
}

.v-image {
  margin-left: -2px;
}

.card-logo {
  cursor: pointer;
  margin: 0 1.3em;
}

.card-logo:hover {
  filter: brightness(0) invert(1);
}

.v-card__actions {
  padding: 0
}

.v-card {
  border-radius: 20px;
  margin: auto;
  box-shadow: 0 1px 0px -100px rgba(0,0,0,.2),0 10px 5px 1px rgba(0,0,0, 0),0 4px 18px 3px rgba(0,0,0, 0.1)!important
}

.purchase-form {
  color: white;
  background-color: rgba(0,0,0, 0.82);
  border-radius: 5px;
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

.bank-cards {
  display: flex;
  justify-content: center;
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