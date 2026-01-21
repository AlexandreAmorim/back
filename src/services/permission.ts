import { prisma } from '@/lib/prisma'

const premissionEnabled = async (sub: string) => {
  const roles = await prisma.user.findUnique({
      select: {
        RoleUser: {
          select: {
            role: {
              select: {
                slug: true,
              },
            },
          },
        },
      },
      where: {
        id: sub,
      },
    })

  return roles

}
export { premissionEnabled }