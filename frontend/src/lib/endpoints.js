export default {
  users: {
    current: '/identity/current',
    login: '/sign_in',
    logout: (id) => `/sessions/${id}`,
  },
}
