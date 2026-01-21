import type { FastifyReply, FastifyRequest } from 'fastify'
import { env } from '@/config/env'
import { AuthenticateFactory } from '@/useCases/factories/AthenticateFactory'

export async function refreshController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  try {
    const { getUserTokenUseCase } = AuthenticateFactory()

    const _token = await getUserTokenUseCase.execute({
      id: request.user.sub,
    })

    const token = await reply.jwtSign(
      {
        sub: request.user.sub,
        token: _token,
      },
      {
        sign: {
          expiresIn: env.TOKEN_EXPIRES_IN,
        },
      },
    )

    return reply.status(200).send({
      token,
    })
  } catch (err) {
    if (err instanceof Error) {
      return reply.status(400).send({ message: 'Credenciais inválidas.' })
    }

    throw err
  }
}
