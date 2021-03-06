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
import { mapActions } from 'vuex';

export default {
  name: 'QrCodeComponent',

  data() {
    return {
      qrCode: null
    }
  },

  methods: {
    ...mapActions({
      getQr: 'getQrCode'
    })
  },

  created() {
    this.getQr(this.$route.params.id).then(resp => {
      if(resp.status == 200) {
        this.qrCode = resp.data;
      }
      else {
        this.$router.push("/")
        this.$toaster.error(resp.data['message'])
      }
    })
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