import type { FastifyReply, FastifyRequest } from 'fastify'
import { logCreate } from '@/services/log'

export async function loggerMiddleware(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  // Logar a requisição após a resposta ser enviada
  reply.raw.on('finish', async () => {
    const user = request.user?.sub
    const { method, url, ip, headers } = request

    // Log assíncrono sem bloquear a resposta
    try {
      await logCreate({
        userId: user,
        action: method,
        resource: url,
        method,
        path: url,
        ip,
        userAgent: headers['user-agent'],
        statusCode: reply.statusCode,
      })
    } catch (error: any) {
      console.error('Erro ao registrar log:', error)
    }
  })
}
