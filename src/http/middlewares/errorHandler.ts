import type { FastifyInstance } from 'fastify'
import { ZodError } from 'zod'
import { env } from '@/config/env'
import { BadRequestError } from '@/errors/BadRequestError'
import { CoreCheckError } from '@/errors/CoreCheckError'
import { UnauthorizedError } from '@/errors/UnauthorizedError'
import { formatZodErrorFlattened } from '@/utils/format-zod-error'

type FastifyErrorHandler = FastifyInstance['errorHandler']

export const errorHandler: FastifyErrorHandler = (error, _request, reply) => {
  if (error instanceof ZodError) {
    const formattedError = formatZodErrorFlattened(error)
    return reply.status(formattedError.statusCode).send(formattedError)
  }

  if (error instanceof BadRequestError) {
    return reply.status(400).send({
      message: error.message,
    })
  }

  if (error instanceof UnauthorizedError) {
    return reply.status(401).send({
      message: error.message,
    })
  }

  if (error instanceof CoreCheckError) {
    return reply.status(403).send({
      message: error.message,
    })
  }

  if (env.NODE_ENV !== 'production') {
    console.error(error)
  } else {
    // TODO: Here we should log to a external tool like DataDog/NewRelic/Sentry
  }

  return reply.status(500).send({ message: 'INTERNAL_SERVER_ERROR' })
}
