import type { FastifyReply, FastifyRequest } from 'fastify'

export async function refresh(request: FastifyRequest, reply: FastifyReply) {
  try {
    await request.jwtVerify()
  } catch (err) {
    return reply.status(401).send({ message: 'REFRESH_INVALID' })
  }
}
