<script setup>
import endpoints from '@/lib/endpoints'
import router from '@/router'
import runMutation from '@/lib/run_mutation'
import { errorToast, successToast } from '@/lib/toasts'
import { ref } from 'vue'

const password = ref('')
const passwordConfirmation = ref('')

const passwordValidation = () => {
  if (password.value !== passwordConfirmation.value) {
    return 'Passwords do not match'
  }
}

const updatePassword = () => {
  runMutation({
    endpoint: endpoints.users.updatePassword,
    method: 'patch',
    data: {
      password: password.value,
      password_confirmation: passwordConfirmation.value,
    },
  })
    .then(() => {
      successToast('Your password has been updated.')
      router.push({ name: 'home' })
    })
    .catch(() => {
      errorToast('Something went wrong')
    })
}
</script>

<template lang="pug">
section.section
  h1.title Change Password
  .block
    p Clicking "Change My Password" will log you out on all devices except this one.
  .block
    BaseForm(@submit="updatePassword")
      .block
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
      .block
        BaseSubmitButton Change My Password
</template>
