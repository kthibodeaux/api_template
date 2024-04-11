<script setup>
import { ref } from 'vue'
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'

const props = defineProps({
  userId: { type: String, required: true },
})

const error = ref(null)
const isSent = ref(false)

const sendValidationLink = function() {
  runMutation({
    endpoint: endpoints.users.resendVerification(props.userId),
  })
    .then(() => {
      isSent.value = true
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
      h1.title.has-text-centered Verify
      p.has-text-centered(v-if="error") {{error}}
      p Your account has been created, but you cannot log in until your email address is verified. Please check your email and click the link to verify your account.
      template(v-if="isSent")
        p.has-text-centered
          BaseButton(disabled) Verification link sent
      template(v-else)
        p.has-text-centered
          BaseButton(@click="sendValidationLink") Resend validation link
      hr
      RouterLink(:to="{ name: 'login' }")
        BaseButton(link fullwidth) Back to Login
</template>
