<script setup>
import endpoints from '@/lib/endpoints'
import router from '@/router'
import runMutation from '@/lib/run_mutation'
import { errorToast, successToast } from '@/lib/toasts'
import { ref } from 'vue'

const email = ref('')

const updateEmail = () => {
  runMutation({
    endpoint: endpoints.users.updateEmail,
    method: 'post',
    data: {
      emailChangeTo: email.value,
    },
  })
    .then(() => {
      successToast("We've sent an email to your new address, please verify it to complete the update")
      router.push({ name: 'home' })
    })
    .catch(() => {
      errorToast('Something went wrong')
    })
}
</script>

<template lang="pug">
section.section
  h1.title Email
  .block
    p Your email address is used to login, recover your password, and receive notifications.
    p Clicking "Change My Email Address" will send an email to the new address with instructions to complete the process.
  .block
    BaseForm(@submit="updateEmail")
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
