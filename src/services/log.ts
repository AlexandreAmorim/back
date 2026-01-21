import { generateId } from '@/lib/id'
import { prisma } from '@/lib/prisma'

interface CreateLogProps {
  userId?: string
  action: string
  resource: string
  method: string
  path: string
  ip?: string
  userAgent?: string
  statusCode?: number
}

const logCreate = async (data: CreateLogProps) => {
  try {
    await prisma.log.create({
      data: {
        id: generateId(),
        ...data,
      },
    })
  } catch (error) {
    console.error('Erro ao criar log:', error)
  }

}
export { logCreate }