<script setup>
import router from '@/router'
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import { errorToast } from '@/lib/toasts'
import { ref } from 'vue'

const email = ref('')
const password = ref('')
const passwordConfirmation = ref('')

const passwordValidation = () => {
  if (password.value !== passwordConfirmation.value) {
    return 'Passwords do not match'
  }
}

const signup = () => {
  runMutation({
    endpoint: endpoints.signUp,
    data: {
      user: {
        email: email.value,
        password: password.value,
        passwordConfirmation: passwordConfirmation.value,
      },
    },
  })
    .then(data => {
      router.push({ name: 'not_verified', params: { userId: data.user.id } })
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
      h1.title.has-text-centered Sign Up
      BaseForm(@submit="signup")
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
      RouterLink(:to="{ name: 'sign_in' }")
        BaseButton(link fullwidth) Back to Sign In
</template>
