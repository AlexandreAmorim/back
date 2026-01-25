import type { FastifyReply, FastifyRequest } from 'fastify'
import { tokenAccess } from '@/services/tokenAccess'

export async function multipleAccess(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const { authorization } = request.headers

  if (authorization) {
    const [, token] = authorization.split(' ')

    if (token) {
      const [, base64String] = token.split('.')
      if (base64String) {
        const decodedValue = JSON.parse(
          Buffer.from(base64String, 'base64').toString('ascii'),
        )

        const result = await tokenAccess(decodedValue.sub)

        if (!result || decodedValue.token !== result.token) {
          return reply.status(401).send({
            time: 9,
            message:
              'Um novo acesso foi identificado e você foi desconectado. Caso não tenha sido você altere sua senha.',
          })
        }
        if (!result.status) {
          return reply
            .status(401)
            .send({ message: 'Seu acesso foi bloqueado.' })
        }
      }
    }
  }
}
