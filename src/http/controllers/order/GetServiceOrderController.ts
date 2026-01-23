import type { FastifyReply, FastifyRequest } from 'fastify'
import { OrderFactory } from '@/useCases/factories/OrderFactory'

export async function getServiceOrderController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const { getServiceOrder } = OrderFactory()

  const authorizedCheck = await getServiceOrder.execute({
    userId: request.user.sub,
  })

  if (authorizedCheck.unauthorized) {
    return reply
      .status(400)
      .send({ message: authorizedCheck.message, time: 10 })
  }

  return authorizedCheck.service
}
