import type { FastifyInstance } from 'fastify'
import { authenticateController } from '@/http/controllers/auth/AuthenticateController'
import { getMeController } from '@/http/controllers/auth/GetMeController'
import { previewController } from '@/http/controllers/auth/PreviewController'
import { refreshController } from '@/http/controllers/auth/RefreshController'
import { authenticate } from '../middlewares/authenticate'
import { multipleAccess } from '../middlewares/multipleAccess'
import { refresh } from '../middlewares/refresh'

export async function authRoutes(app: FastifyInstance) {
  app.route({
    url: '/login',
    method: 'POST',
    handler: authenticateController,
  })

  app.route({
    url: '/refresh-token',
    method: 'POST',
    preHandler: [refresh],
    handler: refreshController,
  })

  app.route({
    url: '/preview',
    method: 'POST',
    handler: previewController,
  })

  app.route({
    url: '/me',
    method: 'GET',
    preHandler: [authenticate, multipleAccess],
    handler: getMeController,
  })
}
