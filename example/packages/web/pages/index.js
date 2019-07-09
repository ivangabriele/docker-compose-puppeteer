import axios from 'axios'
import React from 'react'

export default class IndexPage extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      entity: '',
      isLoading: true
    }
  }

  async componentDidMount() {
    const { data: { entity } } = await axios.get(process.env.API_URI)

    this.setState({
      entity,
      isLoading: false
    })
  }

  render() {
    if (this.state.isLoading) return <pre>Loading…</pre>

    return <h1>{`Hello ${this.state.entity}!`}</h1>
  }
}
