<template lang="pug">
  v-container(
    flex-column
    align-center
  )
    v-toolbar.mb-16(
      dark
      flat
    )
      .categories
        span.category(
          v-for="category in categories"
          v-on:click="filterByCategories(category)"
          style="font-size: 18px; font-weight: 600; cursor: pointer"
        ) {{ category.name }}
    .card-container
      v-hover(v-slot="{hover}"
                v-for="product, index in filteredProducts"
          :key="product.id")
        v-card.my-16.mx-16.product-card(

          width="250"
          height="360"
          :class="{ 'on-hover': hover }"
          v-model="index"
        )
          img(
            :src="product.image"
          )
          v-card-text
            .product-title
              | {{ product.title }}
            .price
              | $ {{ product.price }}
            .cart-button

          .add-to-cart(
            :class="{ 'visible': hover }"
          )
            span(
              v-if="currentUser != 'noUser'"
              v-on:click="handleAddToCart(product)"
            ) Add to cart
            span(
              v-on:click="handleIngredients(product)"
            ) Ingredients
      v-dialog(v-if="selectedProduct"
        v-model="ingredientsDialog"
        max-width='700'
        style="position: relative"
      )
        v-layout(column align-center)
          v-card.product-dialog(
            style="width: 100%; display: flex; flex-direction: column; align-items: center"
          )
            div(
              style="display: flex; width: 99%"
            )
              span.dialog-title.mt-4(
                style="width: 100%; text-align: center"
              )
                | {{ selectedProduct.title }}
              v-spacer
              span
                v-icon(
                  v-on:click="ingredientsDialog = false"
                  dense
                ) mdi-close
            v-card-text(
              style="text-align: center; white-space: pre-line; padding: 2em 1.5em"
            ) {{ selectedProduct.description }}
            v-spacer
            span(
              style="padding: 1em"
              v-html=""
            ) {{ selectedProduct.weight }} g

</template>


<script>

import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

export default {
  name: 'PlatesComponent',

  data() {
    return {
      products: [],
      ingredientsDialog: false,
      selectedProduct: null,
      categories: [],
      filteredProducts: [],
      filters: []
    }
  },

  mounted() {
    this.fetchCategories();
    this.fetchProducts();
  },

  methods: {
    ...mapActions({
      incrementCartCount: 'incrementCartCount'
    }),

    filterByCategories(category) {
      this.filters.includes(category.name) ? event.target.style.color = '#696969' : event.target.style.color = "#FFFFFF";
      this.filters.indexOf(category.name) === -1 ? this.filters.push(category.name) : this.filters.splice(this.filters.indexOf(category.name), 1);
      if(this.filters.length == 0)
        this.filteredProducts = this.products
      else
        this.filteredProducts = this.products.filter(x => this.filters.includes(x.category))
    },

    fetchProducts() {
      axios.get('/api/v1/products').then(response => {
        this.products = response.data;
        this.filteredProducts = this.products;
      })
    },

    fetchCategories() {
      axios.get('/api/v1/categories').then(response => {
        this.categories = response.data
      })
    },

    handleAddToCart(product) {
      axios
        .post('/api/v1/cart_products', { id: product.id }).then(
          response => {
            if(response.status == 200) {
              this.incrementCartCount()
              this.$toaster.success('Item added', { timeout: 2000 } )
            }
          }
        )
    },

    handleIngredients(product) {
      this.selectedProduct = product;
      this.ingredientsDialog = true;
    }
  },

  computed: {
    ...mapGetters({
      currentUser: 'currentUser'
    }),
  }

}
</script>

<style scoped>

.product-card {
  position: relative;
  background: rgb(83,20,20);
  background-color: #8EC5FC;
  background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
  border-radius: 20px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-end;
}

header {
  position: sticky;
  z-index: 1;
  top: 53px;
  width: 100%;
}

.v-toolbar__content {
  display: flex;
  justify-content: space-around;
}

.card-container {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 124px;
  justify-content: center;
  padding: 0 8%;
}

.categories {
  display: flex;
  width: 100%;
  justify-content: space-around;
}

.category {
  color: #696969;
}

.category:hover {
  color: rgba(255,255,255, 0.8) !important;
}

.container {
  display: flex;
  justify-content: center;
  margin: 0;
  padding: 0;
  min-width: 100%;
}

.dialog-title {
  font-size: 26px;
  font-weight: 600;
  margin-left: 20px;
}

img {
  width: 150px;
  height: 150px;
}

.product-dialog {
  border-radius: 10px;
}

.v-card img {
  position: absolute;
  top: -30px;
  right: 45px;
}

.visible-add-btn {
  opacity:1;
  transition: opacity 0.4 ease-in;
}

.hidden-add-btn {
  opacity: 0;
}

.v-card__text .product-title {
  font-size: 40px;
  font-weight: 600;
  color: white;
  padding-bottom: 30px;
}

.v-card {
  perspective: 1000px;
  backface-visibility: hidden;
}

.v-card__actions {
  width: 100%;
  display: flex;
  justify-content: center;
}

.v-card__actions{
  background-color: rgba(0,0,0, 0.1)
}

.v-btn:hover:before,
.v-btn:focus:before {
    color: transparent
}

.add-to-cart {
  opacity: 0;
  background-color: rgba(0,0,0, 0.1);
  width: 100%;
  color: white;
  cursor: pointer;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  transition: opacity 0s;
}

.add-to-cart.visible {
  opacity: 1;
  transition: opacity .6s;
}

.add-to-cart span {
  padding: 0.2em 0.7em
}

.add-to-cart span:hover {
  color: rgba(255,255,255, 0.7)
}


.v-card__text .price {
  font-size: 28px;
  color: #f1f1f1;
  padding-bottom: 20px;
}

</style>