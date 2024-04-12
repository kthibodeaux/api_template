<script setup>
import endpoints from '@/lib/endpoints'
import router from '@/router'
import runQuery from '@/lib/run_query'
import { onMounted, ref } from 'vue'

const props = defineProps({
  token: { type: String, required: true },
})

const error = ref(null)

const isLoading = ref(true)
onMounted(() => {
  runQuery({
    endpoint: endpoints.users.verify(props.token),
  })
    .then(() => {
      router.push({ name: 'sign_in' })
    })
    .catch(errors => {
      error.value = errors.join()
    })
    .finally(() => {
      isLoading.value = false
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
          p(v-if="error") {{error}}
          hr
          RouterLink(:to="{ name: 'sign_in' }")
            BaseButton(link fullwidth) Back to Sign In
</template>
