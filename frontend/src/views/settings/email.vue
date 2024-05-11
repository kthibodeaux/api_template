<script setup>
import { ref } from 'vue'

const email = ref('')
</script>

<template lang="pug">
section.section
  h1.title Email
  .block
    p Your email address is used to login, recover your password, and receive notifications.
    p Clicking "Change My Email Address" will send an email to the new address with instructions to complete the process.
  .block
    BaseForm
      .block
        BaseInput(
          v-model="email"
          type="email"
          left-icon="mail"
          is-required
        ) Email Address
      .block
        BaseSubmitButton Change My Email Address
</template>
