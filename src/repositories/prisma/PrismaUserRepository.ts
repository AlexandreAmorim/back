import type { Prisma, User } from '@/lib/generated/client'
import { prisma } from '@/lib/prisma'
import type {
  UserRepository,
  UsersParams,
  UsersResult,
} from '../UserRepositories'

export class PrismaUserRepository implements UserRepository {
  async findUsers({
    id,
    status,
    page,
    perPage,
    managementId,
    search,
  }: UsersParams): Promise<UsersResult> {
    const whereConditions: Prisma.UserWhereInput = {}

    if (id) {
      whereConditions.id = id
    }

    if (managementId) {
      whereConditions.Allocation = {
        some: {
          managementId,
        },
      }
    }

    if (status !== undefined && status !== '') {
      whereConditions.status =
        typeof status === 'boolean' ? status : status.toLowerCase() === 'true'
    }

    if (search?.trim()) {
      whereConditions.OR = [
        { firstName: { contains: search, mode: 'insensitive' } },
        { lastName: { contains: search, mode: 'insensitive' } },
        { document: { contains: search, mode: 'insensitive' } },
      ]
    }

    const users = await prisma.user.findMany({
      where: whereConditions,
      take: perPage,
      skip: (page - 1) * perPage,
      include: {
        RoleUser: {
          select: {
            role: {
              select: {
                id: true,
                name: true,
                slug: true,
              },
            },
          },
        },
        Allocation: {
          select: {
            id: true,
            startedAt: true,
            endedAt: true,
            management: {
              select: {
                id: true,
                name: true,
                initials: true,
              },
            },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    })

    const totalCount = await prisma.user.count({ where: whereConditions })

    return {
      data: users,
      totalCount: totalCount,
    }
  }
  async findById(id: string) {
    const user = await prisma.user.findUnique({
      where: {
        id,
      },
      include: {
        RoleUser: {
          select: {
            role: {
              select: {
                id: true,
                name: true,
                slug: true,
              },
            },
          },
        },
      },
    })

    return user
  }
  async findByDocument(document: string) {
    const user = await prisma.user.findUnique({
      where: {
        document,
      },
    })

    return user
  }
  async findByDocumentSecondary(documentSecondary: string) {
    const user = await prisma.user.findUnique({
      where: {
        documentSecondary,
      },
    })

    return user
  }
  async findByRolesPermissions(id: string) {
    const rolesPermissions = await prisma.user.findFirst({
      select: {
        RoleUser: {
          select: {
            role: {
              select: {
                slug: true,
                PermissionRole: {
                  select: {
                    permissions: {
                      select: {
                        slug: true,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
      where: {
        id,
      },
    })

    if (!rolesPermissions) {
      return
    }

    const roles = rolesPermissions.RoleUser.map((u) => u.role.slug)

    const permissionsFlatten = rolesPermissions.RoleUser.map((user) =>
      user.role.PermissionRole.map((p) => p.permissions.slug),
    )

    const permissions = permissionsFlatten.reduce(
      (acc, cur) => [...acc, ...cur],
      [],
    )

    return { roles, permissions }
  }
  async findByEmail(email: string): Promise<User | null> {
    const user = await prisma.user.findUnique({
      where: {
        email,
      },
    })
    return user
  }
  async findByRg(rg: string): Promise<User | null> {
    const user = await prisma.user.findUnique({
      where: {
        rg,
      },
    })
    return user
  }
  async storeToken(id: string): Promise<any> {
    const token = crypto.randomUUID()
    const _token = await prisma.user.update({
      select: {
        token: true,
      },
      where: {
        id,
      },
      data: {
        token,
      },
    })

    return _token
  }
}
