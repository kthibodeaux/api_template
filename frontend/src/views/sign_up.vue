<script setup>
import router from '@/router'
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import { ref } from 'vue'

const email = ref('')
const password = ref('')
const passwordConfirmation = ref('')
const error = ref(null)

const passwordValidation = () => {
  if (password.value !== passwordConfirmation.value) {
    return 'Passwords do not match'
  }
}

const signup = () => {
  runMutation({
    endpoint: endpoints.users.register,
    data: {
      user: {
        email: email.value,
        password: password.value,
        passwordConfirmation: passwordConfirmation.value,
      },
    },
  })
    .then(data => {
      router.push({ name: 'registered', params: { userId: data.user.id } })
    })
    .catch(errors => {
      error.value = errors.join()
    })
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Sign Up
      BaseForm(@submit="signup" :error="error")
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
          minlength="12"
          :validation="passwordValidation"
          v-model:validationWatch="passwordConfirmation"
        ) Password
        BaseInput(
          v-model="passwordConfirmation"
          type="password"
          left-icon="lock"
          is-required
          minlength="12"
          :validation="passwordValidation"
          v-model:validationWatch="password"
        ) Password Confirmation
        BaseSubmitButton Sign Up
      hr
      RouterLink(:to="{ name: 'login' }")
        BaseButton(link fullwidth) Back to Login
</template>
