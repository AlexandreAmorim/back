import type { FastifyInstance } from 'fastify'
import { getServiceOrderController } from '@/http/controllers/order/GetServiceOrderController'
import { authenticate } from '@/http/middlewares/authenticate'

export async function orderRoutes(app: FastifyInstance) {
  app.route({
    url: '/orders/service',
    method: 'GET',
    preHandler: [authenticate],
    handler: getServiceOrderController,
  })
}
