const prodUrl = ''
const devUrl = 'http://localhost:30000'

const isDev = process.env.NODE_ENV !== 'production'
const apiUrl = isDev ? devUrl : prodUrl

export default apiUrl
