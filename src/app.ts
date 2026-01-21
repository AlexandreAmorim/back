import { fastifyCors } from '@fastify/cors'
import { fastifyJwt } from '@fastify/jwt'
import { fastifyRateLimit } from '@fastify/rate-limit'
import { fastify } from 'fastify'
import { env } from './config/env'
import { errorHandler } from './http/middlewares/errorHandler'
import { userRoutes } from './http/routes/user.routes'

export const app = fastify({})

// Registrar plugins
app.register(fastifyCors, {
  origin: true, // Em produção, especifique os domínios permitidos
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
})

app.register(fastifyJwt, {
  secret: env.TOKEN_SECRET || 'senha_super_secreta',
})

app.register(fastifyRateLimit, {
  max: 1000,
  timeWindow: '1 minute',
})

app.get('/', {
  schema: {
    tags: ['Health'],
    description: 'Health check da API',
    response: {
      200: {
        type: 'object',
        properties: {
          message: { type: 'string' },
          timestamp: { type: 'string' },
        },
      },
    },
  },
  handler: async () => {
    return {
      message: 'API is Running!',
      timestamp: new Date().toISOString(),
    }
  },
})

// Configurar error handler ANTES de registrar as rotas
//app.addHook('preHandler', loggerMiddleware)
app.setErrorHandler(errorHandler)

// Registrar rotas
//app.register(authRoutes, { prefix: '/auth' })
app.register(userRoutes, { prefix: '/api' })
