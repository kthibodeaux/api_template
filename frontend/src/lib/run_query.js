import axios from '@/lib/axios'

export default function({ endpoint }) {
  return new Promise((resolve, reject) => {
    axios.get(endpoint)
      .then(response => {
        resolve(response.data)
      })
      .catch((error) => {
        reject(error.response.data.errors)
      })
  })
}
