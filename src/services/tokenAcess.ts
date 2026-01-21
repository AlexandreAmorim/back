import { prisma } from '@/lib/prisma'

const tokenAccess = async (sub: string) => {
  const row = await prisma.user.findFirst({
          select: {
            status: true,
            token: true,
          },
      where: {
        id: sub,
      },
    })

  return row

}
export { tokenAccess }