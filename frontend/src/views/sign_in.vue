<script setup>
import router from '@/router'
import { errorToast } from '@/lib/toasts'
import { ref } from 'vue'
import { useUserStore } from '@/stores/user'

const email = ref('')
const password = ref('')
const rememberMe = ref(false)

const user = useUserStore()

const signIn = () => {
  user.signIn({
    email: email.value,
    password: password.value,
    rememberMe: rememberMe.value,
  })
    .then(data => {
      if (data?.session) {
        router.push('/')
      } else if (data.errorId === 'not_verified') {
        router.push({ name: 'not_verified', params: { userId: data.user.id } })
      }
    })
    .catch(errors => {
      errorToast(errors.join())
    })
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Sign In
      BaseForm(@submit="signIn")
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
        BaseSubmitButton Sign In
      hr
      RouterLink(:to="{ name: 'sign_up' }")
        BaseButton(link fullwidth) Sign Up
</template>
