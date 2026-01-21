import { app } from './app'
import { env } from './config/env'

const port = Number(env.PORT)
const host = env.HOST

// Iniciar servidor
const start = async () => {
  try {
    await app.listen({ port, host })

    console.log(`\n🚀 Servidor rodando em http://${host}:${port}`)
    console.log(
      `📚 Documentação Swagger disponível em: http://${host}:${port}/docs`,
    )
    console.log(`📖 OpenAPI JSON: http://${host}:${port}/docs/json`)
  } catch (error) {
    app.log.error(error)
    process.exit(1)
  }
}

start()
