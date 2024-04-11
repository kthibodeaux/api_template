export default {
  users: {
    current: '/identity/current',
    login: '/sign_in',
    logout: (id) => `/sessions/${id}`,
    register: '/sign_up',
    verify: (token) => `/identity/email_verification?sid=${token}`,
  },
}
