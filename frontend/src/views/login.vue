<script setup>
import { ref } from 'vue'

const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const error = ref(null)

const login = () => {
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Login
      BaseForm(@submit="login" :error="error")
        BaseInput(v-model="email" is-required) Email Address
        BaseInput(v-model="password" is-sensitive is-required) Password
        BaseCheckbox(v-model="rememberMe") Remember Me
        BaseSubmitButton Login
</template>
