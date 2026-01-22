import type { FastifyReply, FastifyRequest } from 'fastify'
import { UnauthorizedError } from '@/errors/UnauthorizedError'
import { premissionEnabled } from '@/services/permission'

export function authorize(requiredPermissions: string | string[]) {
  return async (request: FastifyRequest, reply: FastifyReply) => {
    const { sub } = request.user
    if (!sub) {
      throw new UnauthorizedError()
    }

    const permissions = Array.isArray(requiredPermissions)
      ? requiredPermissions
      : [requiredPermissions]

    const roles = await premissionEnabled(sub)

    if (!roles) {
      return
    }

    const rolesA = roles.RoleUser.map((u) => u.role.slug)

    const hasPermission = permissions.some((permission) =>
      rolesA.includes(permission),
    )

    if (!hasPermission) {
      return reply.status(403).send({
        message: 'Você não tem permissão para acessar este recurso',
      })
    }
  }
}
