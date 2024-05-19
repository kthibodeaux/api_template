<script setup>
import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import runQuery from '@/lib/run_query'
import { errorToast, successToast } from '@/lib/toasts'
import { ref } from 'vue'
import { useUserStore } from '@/stores/user'

const user = useUserStore()

const sessions = ref([])

runQuery({ endpoint: endpoints.users.sessions })
  .then(data => {
    sessions.value = data
  })

const signOut = (sessionId) => {
  runMutation({
    endpoint: endpoints.users.signOutSession(sessionId),
    method: 'delete',
  })
    .then(() => {
      const index = sessions.value.findIndex((e) => e.id === sessionId)
      sessions.value.splice(index, 1)

      successToast('Session has been signed out')
    })
    .catch(() => {
      errorToast('Something went wrong')
    })
}
</script>

<template lang="pug">
section.section
  h1.title Active Sessions
  .block
    p You are signed in from the following devices. If you do not recognize any, you can sign it out and reset your password.
  .block
    .card(v-for="session in sessions" :key="session.id")
      .card-content
        .level
          .left
            .title.is-5 {{session.ipAddress}}
          .right
            template(v-if="session.id == user.state.sessionId")
              | This Device
            template(v-else)
              a(@click="signOut(session.id)" href="#") Sign Out
        p {{session.userAgent}}
        p Signed in since {{session.createdAt}}
</template>
