import type { FastifyReply, FastifyRequest } from 'fastify'
import { z } from 'zod'
import { env } from '@/config/env'
import { InvalidCredentialsError } from '@/errors/InvalidCredentialsError'
import { AuthenticateFactory } from '@/useCases/factories/AthenticateFactory'

export async function authenticateController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const authenticateBodySchema = z.object({
    document: z.string({
      error: 'Document is required',
    }),
    password: z.string(),
  })
  try {
    const { document, password } = authenticateBodySchema.parse(request.body)
    const { authenticateUseCase, getUserTokenUseCase } = AuthenticateFactory()

    const { user, spaVersion } = await authenticateUseCase.execute({
      document,
      password,
    })

    const _token = await getUserTokenUseCase.execute({
      id: user.id,
    })
    const token = await reply.jwtSign(
      {
        sub: user.id,
        token: _token,
      },
      {
        sign: {
          expiresIn: env.TOKEN_EXPIRES_IN,
        },
      },
    )

    const refreshToken = await reply.jwtSign(
      {
        sub: user.id,
        token: _token,
      },
      { expiresIn: env.REFRESH_TOKEN_EXPIRES },
    )

    return reply.status(200).send({
      user,
      token,
      refreshToken,
      spaVersion,
    })
  } catch (err) {
    if (err instanceof InvalidCredentialsError) {
      return reply.status(400).send({
        code: 'INVALID_CREDENTIALS',
        message: err.message,
      })
    }

    // Re-throw para que o errorHandler global trate (incluindo ZodError)
    throw err
  }
}
