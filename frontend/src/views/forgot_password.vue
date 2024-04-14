<script setup>
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import { ref } from 'vue'

const email = ref('')
const isSent = ref(false)

const sendPasswordReset = () => {
  runMutation({
    endpoint: endpoints.users.sendPasswordReset,
    data: { email: email.value },
  })
    .then(() => {
      isSent.value = true
    })
    .catch(() => {})
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Forgot Password
      template(v-if="isSent")
        p If an account is associated with that email address you will receive an email with instructions on how to reset your password.
      template(v-else)
        BaseForm(@submit="sendPasswordReset")
          .block
            BaseInput(
              v-model="email"
              type="email"
              left-icon="mail"
              x-is-required
            ) Email Address
          .block
            BaseSubmitButton Send Password Reset
      hr
      RouterLink(:to="{ name: 'sign_in' }") Back to Sign In
</template>
