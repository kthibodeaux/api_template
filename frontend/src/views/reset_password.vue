<script setup>
import endpoints from '@/lib/endpoints'
import router from '@/router'
import runMutation from '@/lib/run_mutation'
import { errorToast, successToast } from '@/lib/toasts'
import { ref } from 'vue'

const props = defineProps({
  token: { type: String, required: true },
})

const password = ref('')
const passwordConfirmation = ref('')

const passwordValidation = () => {
  if (password.value !== passwordConfirmation.value) {
    return 'Passwords do not match'
  }
}

const resetPassword = () => {
  runMutation({
    endpoint: endpoints.users.resetPassword,
    method: 'patch',
    data: {
      sid: props.token,
      password: password.value,
      password_confirmation: passwordConfirmation.value,
    },
  })
    .then(() => {
      successToast('Your password has been updated. You may now sign in.')
      router.push({ name: 'sign_in' })
    })
    .catch(() => {
      errorToast('Something went wrong')
    })
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Reset Password
      BaseForm(@submit="resetPassword")
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
          BaseSubmitButton Reset Password
      hr
      RouterLink(:to="{ name: 'sign_in' }") Back to Sign In
</template>
