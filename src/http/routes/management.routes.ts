import type { FastifyInstance } from 'fastify'
import { authenticate } from '../middlewares/authenticate'
import { authorize } from '../middlewares/authorize'

export async function userRoutes(app: FastifyInstance) {
  app.route({
    url: '/users',
    method: 'GET',
    preHandler: [authenticate, authorize('admin')],
    handler: getListAllController,
  })
}
