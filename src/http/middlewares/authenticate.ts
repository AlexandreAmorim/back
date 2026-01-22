import type { FastifyRequest } from 'fastify'
import { UnauthorizedError } from '@/errors/UnauthorizedError'

export async function authenticate(request: FastifyRequest) {
  try {
    await request.jwtVerify()
  } catch (err) {
    throw new UnauthorizedError('TOKEN_INVALID')
  }
}
