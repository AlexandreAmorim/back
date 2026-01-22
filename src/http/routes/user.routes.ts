import type { FastifyInstance } from 'fastify'
import { getListAllController } from '@/http/controllers/user/GetListAllController'
import { authenticate } from '@/http/middlewares/authenticate'

export async function userRoutes(app: FastifyInstance) {
  app.route({
    url: '/users',
    method: 'GET',
    preHandler: [authenticate],
    handler: getListAllController,
  })
}
