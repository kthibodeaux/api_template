<script setup>
const isChecked = defineModel()
</script>

<template lang="pug">
.field
  label.checkbox
    input(type="checkbox" v-model="isChecked")
    | &nbsp;
    slot
</template>
