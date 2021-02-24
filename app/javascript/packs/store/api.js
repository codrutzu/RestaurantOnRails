import axios from 'axios'

export default async function getCurrentUser() {
  let uri = `http://localhost:3000/api/v1/users/current_user`
  return axios.get(uri).then(resp => { resp.data })
}
