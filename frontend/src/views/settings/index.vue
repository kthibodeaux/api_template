<script setup>
</script>

<template lang="pug">
.columns
  .column.is-3
    section.section
      article.panel.is-link
        p.panel-heading Access
        RouterLink.panel-block(:to="{ name: 'settings__active_sessions' }")
          span.panel-icon
            BaseIcon(icon="book-stack")
          | Active Sessions
        RouterLink.panel-block(:to="{ name: 'settings__change_email' }")
          span.panel-icon
            BaseIcon(icon="mail")
          | Change Email
        RouterLink.panel-block(:to="{ name: 'settings__change_password' }")
          span.panel-icon
            BaseIcon(icon="lock")
          | Change Password
  .column
    RouterView
</template>
