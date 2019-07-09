import Koa from 'koa'
import cors from '@koa/cors'

const { API_PORT } = process.env

const app = new Koa()

app.use(cors())
app.use(async ctx => {
  ctx.body = {
    entity: 'Docker'
  }
})

app.listen(API_PORT, () => console.log(`Api is running on http://localhost:${API_PORT}`))
