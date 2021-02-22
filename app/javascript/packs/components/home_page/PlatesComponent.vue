<template lang="pug">
  .plates
    v-container(grid-list-md mt-12)
      v-layout(
        row
        wrap
      )
        v-flex(
          v-for="product in products"
          :key="product.id"
        )
          v-hover(v-slot="{hover}")
            v-card.my-16.mx-6(
              width="250"
              height="360"
              :class="{ 'on-hover': hover }"
            )
              img(
                :src="product.image"
              )

              v-card-text
                .product-title
                  | {{ product.title }}
                .price
                  | $ {{ product.price }}


</template>


<script>

import axios from 'axios'

export default {
  name: 'PlatesComponent',

  data() {
    return {
      products: []
    }
  },

  mounted() {
    this.fetchProducts();
  },

  methods: {
    fetchProducts() {
      axios.get('/api/v1/products').then(response => {
        this.products = response.data
      })
    }
  }
}
</script>

<style scoped>

.v-card {
  position: relative;
  background: rgb(83,20,20);
  background: linear-gradient(10deg, rgba(83,20,20,1) 0%, rgba(24,24,172,1) 100%);
  border-radius: 20px;
  text-align: center;
  display: flex;
  align-items: flex-end;
}

.layout {
  justify-content: center;
}

img {
  width: 180px;
}

.v-card img {
  position: absolute;
  bottom: 200px;
  right: 35px;
}

.v-card__text .product-title {
  font-size: 40px;
  font-weight: 600;
  color: white;
  padding-bottom: 65px;
}

.v-card {
  transition: height .4s ease-in-out;
  transition: width .4s ease-in-out;
}

.v-card.on-hover {
  height: 400px !important;
  width: 270px !important;
  cursor: pointer;
}

.v-card__text .price {
  font-size: 28px;
  color: #CBC9C9;
  padding-bottom: 25px;
}

</style>