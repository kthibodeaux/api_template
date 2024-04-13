<script setup>
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import { errorToast } from '@/lib/toasts'
import { ref } from 'vue'

const props = defineProps({
  userId: { type: String, required: true },
})

const isSent = ref(false)

const sendValidationLink = function() {
  runMutation({
    endpoint: endpoints.users.resendVerification(props.userId),
  })
    .then(() => {
      isSent.value = true
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
      .block
        h1.title.has-text-centered Verify
        p Your account has been created, but you cannot log in until your email address is verified. Please check your email and click the link to verify your account.
      .block
        template(v-if="isSent")
          p.has-text-centered
            BaseButton(disabled) Verification link sent
        template(v-else)
          p.has-text-centered
            BaseButton(@click="sendValidationLink") Resend validation link
      hr
      RouterLink(:to="{ name: 'sign_in' }") Back to Sign In
</template>
