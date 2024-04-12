export default {
  signIn: '/sign_in',
  signUp: '/sign_up',
  users: {
    current: '/identity/current',
    logout: (id) => `/sessions/${id}`,
    verify: (token) => `/identity/email_verification?sid=${token}`,
    resendVerification: (id) => `/identity/email_verification?uid=${id}`,
  },
}
