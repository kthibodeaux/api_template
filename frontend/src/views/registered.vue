<script setup>
defineProps({
  userId: { type: String, required: true },
})

const sendValidationLink = function() {
  console.log('boo')
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Verify
      p Your account has been created, but you cannot log in until your email address is verified. Please check your email and click the link to verify your account.
      p.has-text-centered
        RouterLink(to="")
          BaseButton(@click="sendValidationLink") Resend validation link
      hr
      RouterLink(:to="{ name: 'login' }")
        BaseButton(link fullwidth) Back to Login
</template>
