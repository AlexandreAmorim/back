import type { FastifyReply, FastifyRequest } from 'fastify'
import { UserFactory } from '@/useCases/factories/UserFactory'

export async function getMeController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const { getUserMe } = UserFactory()

  const { user } = await getUserMe.execute({
    userId: request.user.sub,
  })

  if (!user) {
    return reply.status(404).send({ message: 'Usuario nao encontrado' })
  }

  return reply.status(200).send({
    user: {
      ...user,
      name: `${user.firstName} ${user.lastName}`,
      password: undefined,
    },
  })
}
