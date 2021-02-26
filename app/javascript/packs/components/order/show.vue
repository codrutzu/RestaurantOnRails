<template lang="pug">
  v-container(
    flex-column
    justify-center
  )
    .h3.font-weight-bold.mt-12 Scan QR code to see order details
    .qr-code(
      v-html="qrCode"
    )


</template>

<script>

import axios from 'axios';

export default {
  name: 'QrCodeComponent',

  data() {
    return {
      qrCode: null
    }
  },

  methods: {
    getQrCode(id) {
      axios.get(
        `/api/v1/orders/${id}`
      )
        .then(resp => {
          this.qrCode = resp.data
        })
    }
  },

  created() {
    this.getQrCode(this.$route.params.id)
  }

}
</script>

<style>

.container {
  margin-top: 124px;
  text-align: center;
}

.qr-code svg{
  transform: scale(0.6)
}

</style>