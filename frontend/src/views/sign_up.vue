<script setup>
import { ref } from 'vue'

const email = ref('')
const password = ref('')
const passwordConfirmation = ref('')
const error = ref(null)
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Sign Up
      BaseForm(@submit="login" :error="error")
        BaseInput(
          v-model="email"
          type="email"
          left-icon="mail"
          is-required
        ) Email Address
        BaseInput(
          v-model="password"
          type="password"
          left-icon="lock"
          is-required
        ) Password
        BaseInput(
          v-model="passwordConfirmation"
          type="password"
          left-icon="lock"
          is-required
        ) Password Confirmation
        BaseSubmitButton Sign Up
      hr
      RouterLink(:to="{ name: 'login' }")
        BaseButton(link fullwidth) Back to Login
</template>
