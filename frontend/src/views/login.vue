<script setup>
import { ref } from 'vue'

const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const error = ref(null)

const login = () => {
}
</script>

<template lang="pug">
section.section
  .columns.is-centered
    .column.is-half
      h1.title.has-text-centered Login
      form(@submit.prevent="login")
        .field.has-text-centered(v-if="error")
          p.has-text-danger {{ error }}
        .field
          label.label Email Address
          .control
            input.input(type="text" v-model="email" placeholder="Enter your email address" required)
        .field
          label.label Password
          .control
            input.input(type="password" v-model="password" placeholder="Enter your password" required)
        .field
          .control
            label.checkbox
              input(type="checkbox" v-model="rememberMe")
              |  Remember me
        .field
          .control
            button.button.is-primary.is-fullwidth(type="submit")
              | Login
</template>
