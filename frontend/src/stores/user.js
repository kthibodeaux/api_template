import endpoints from '@/lib/endpoints'
import runMutation from '@/lib/run_mutation'
import runQuery from '@/lib/run_query'
import { computed } from 'vue'
import { defineStore } from 'pinia'
import { ref } from 'vue'

const defaultState = function() {
  return {
    email: ref(null),
    isAdmin: ref(false),
    sessionId: ref(null),
  }
}

export const useUserStore = defineStore('userStore', () => {
  const state = ref(defaultState())

  function setState(data) {
    state.value.email = data.user.email
    state.value.isAdmin = data.user.isAdmin
    state.value.sessionId = data.session.id
  }

  function initialize() {
    state.value = defaultState()

    return new Promise((resolve, reject) => {
      runQuery({ endpoint: endpoints.users.current })
        .then(data => {
          setState(data)
          resolve()
        })
        .catch(() => {
          reject()
        })
    })
  }

  const login = function(credentials) {
    return new Promise((resolve, reject) => {
      runMutation({
        endpoint: endpoints.users.login,
        data: { session: credentials },
      })
        .then(data => {
          if (data.session) {
            setState(data)
          }
          resolve(data)
        })
        .catch(errors => {
          reject(errors)
        })
    })
  }

  const logout = function() {
    runMutation({
      endpoint: endpoints.users.logout(state.value.sessionId),
      method: 'delete',
    })
      .finally(() => {
        state.value = defaultState()
        location.href = '/login'
      })
  }

  const isLoggedIn = computed(() => {
    return !!state.value.sessionId
  })

  return {
    initialize,
    isLoggedIn,
    login,
    logout,
    state,
  }
})
