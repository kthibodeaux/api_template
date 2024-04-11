<script setup>
import router from '@/router'
import { ref } from 'vue'
import { useUserStore } from '@/stores/user'

const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const error = ref(null)

const user = useUserStore()

const login = () => {
  user.login({
    email: email.value,
    password: password.value,
    rememberMe: rememberMe.value,
  })
    .then(() => {
      router.push('/')
    })
    .catch((errors) => {
      error.value = errors.join()
    })
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Login
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
        BaseCheckbox(v-model="rememberMe") Remember Me
        BaseSubmitButton Login
      hr
      RouterLink(:to="{ name: 'sign_up' }")
        BaseButton(link fullwidth) Sign Up
</template>
