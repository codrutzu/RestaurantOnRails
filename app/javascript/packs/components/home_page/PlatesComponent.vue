<template lang="pug">
  .plates
    v-container(fluid grid-list-md mt-12)
      v-layout(row wrap)
        v-hover(v-slot="{hover}")
          v-card.mt-12.mx-8(
            min-width="250"
            height="360"
            :class="{ 'on-hover': hover }"
          )
            img(
              :src="require('../../images/burger.png')"
            )

            v-card-text
              .product-title
                | Burger
              .price
                | $ 3.00
        v-card(
          min-width="250"
          height="360"
          class="mt-12 mx-8"
        )
          img(
            :src="require('../../images/pizza.png')"
          )

          v-card-text
            .product-title
              | Burger
            .price
              | $ 3.00
        v-card(
          min-width="250"
          height="360"
          class="mt-12 mx-8"
        )
          img(
            :src="require('../../images/pizza.png')"
          )

          v-card-text
            .product-title
              | Burger
            .price
              | $ 3.00
        v-card(
          min-width="250"
          height="360"
          class="mt-12 mx-8"
        )
          img(
            :src="require('../../images/pizza.png')"
          )

          v-card-text
            .product-title
              | Burger
            .price
              | $ 3.00



</template>


<script>
export default {
  name: 'PlatesComponent'
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
  padding: 5em;
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
  transition: transform .4s ease-in-out;
}

.v-card.on-hover {
  transform: scale(1.1);
  cursor: pointer;
}

.v-card__text .price {
  font-size: 28px;
  color: #CBC9C9;
  padding-bottom: 25px;
}

</style>