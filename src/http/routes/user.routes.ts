import type { FastifyInstance } from 'fastify'
import { getListAllController } from '@/http/controllers/user/GetListAllController'
import { getMeController } from '@/http/controllers/user/GetMeController'
import { authenticate } from '@/http/middlewares/authenticate'
import { multipleAcess } from '@/http/middlewares/multipleAccess'

export async function userRoutes(app: FastifyInstance) {
  app.route({
    url: '/users',
    method: 'GET',
    preHandler: [authenticate],
    handler: getListAllController,
  })

  app.route({
    url: '/users/me',
    method: 'GET',
    preHandler: [authenticate, multipleAcess],
    handler: getMeController,
  })
}
