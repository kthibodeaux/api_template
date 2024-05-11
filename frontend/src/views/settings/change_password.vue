<script setup>
import { ref } from 'vue'

const password = ref('')
const passwordConfirmation = ref('')

const passwordValidation = () => {
  if (password.value !== passwordConfirmation.value) {
    return 'Passwords do not match'
  }
}
</script>

<template lang="pug">
section.section
  h1.title Change Password
  .block
    p Clicking "Change My Password" will log you out on all devices except this one.
  .block
    BaseForm
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
