import type { FastifyReply, FastifyRequest } from 'fastify'
import { z } from 'zod'
import type { User } from '@/lib/generated/client'
import { UserFactory } from '@/useCases/factories/UserFactory'

export async function getListAllController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const getAllBodySchema = z.object({
    id: z.string().optional(),
    status: z.string().optional(),
    managementId: z.string().optional(),
    search: z.string().optional(),
    page: z.coerce.number().min(1).default(1),
    perPage: z.coerce.number().min(1).default(10),
  })

  const { id, status, page, managementId, perPage, search } =
    getAllBodySchema.parse(request.query)
  const { getUsers } = UserFactory()

  const { data, totalCount } = await getUsers.execute({
    id,
    status,
    page,
    perPage,
    search,
    managementId: managementId ? Number(managementId) : undefined,
  })

  const users = data
    .filter((user): user is User => user !== undefined)
    .map((user: User) => {
      return {
        id: user.id,
        name: `${user.firstName} ${user.lastName}`,
        document: user.document,
        phone: user.phone,
        email: user.email,
        status: user.status,
      }
    })

  return reply.status(200).send({
    data: users,
    meta: {
      page,
      perPage: 10,
      totalCount,
    },
  })
}
