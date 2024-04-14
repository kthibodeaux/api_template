export default {
  signIn: '/sign_in',
  signOut: (id) => `/sessions/${id}`,
  signUp: '/sign_up',
  users: {
    current: '/identity/current',
    verify: (token) => `/identity/email_verification?sid=${token}`,
    resendVerification: (id) => `/identity/email_verification?uid=${id}`,
    sendPasswordReset: '/identity/password_reset',
  },
}
