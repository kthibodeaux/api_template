export default {
  signIn: '/sign_in',
  signOut: (id) => `/sessions/${id}`,
  signUp: '/sign_up',
  users: {
    current: '/identity/current',
    verify: '/identity/email_verification',
    resendVerification: (id) => `/identity/email_verification?uid=${id}`,
    sendPasswordReset: '/identity/password_reset',
    resetPassword: '/identity/password_reset',
  },
}
