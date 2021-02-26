<template lang="pug">
  footer#footer(
    text-white
  )
    div(class="grid")
      div(class="mb-12 mt-12 align-center flex-column d-flex")
        .wrap-text
          span Need help?
          span.bold-text Find me on
        .social-media
          a(href="https://github.com/codrutzu" target="_blank")
            img(
              :src="require('../images/git.png')"
            )
          a(href="https://dribbble.com/Ard12" target="_blank")
            img(
              :src="require('../images/dribbble-logo.png')"
            )
        div.mt-8 Codreanu Ioan-Andrei © 2020 - 2021

</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>

span {
  font-size: 30px;
}

img {
  border: 4px solid white;
  border-radius: 50%;
  background-color: white;
  width: 40px;
  margin: .6em;
}

#footer {
  background-color: #051120;
  color: white;
}

.bold-text {
  margin-left: .4em;
  font-weight: 700;
}

</style>