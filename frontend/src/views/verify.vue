<script setup>
import endpoints from '@/lib/endpoints'
import router from '@/router'
import runQuery from '@/lib/run_query'
import { errorToast, successToast } from '@/lib/toasts'
import { onMounted, ref } from 'vue'

const props = defineProps({
  token: { type: String, required: true },
})

const isLoading = ref(true)
onMounted(() => {
  runQuery({
    endpoint: endpoints.users.verify(props.token),
  })
    .then(() => {
      successToast('Verification successful')
    })
    .catch(errors => {
      errorToast(errors.join())
    })
    .finally(() => {
      isLoading.value = false
      router.push({ name: 'sign_in' })
    })
})
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Verify
      .has-text-centered
        template(v-if="isLoading")
          p Verifying...
        template(v-else)
          RouterLink(:to="{ name: 'sign_in' }")
            BaseButton(link fullwidth) Back to Sign In
</template>
