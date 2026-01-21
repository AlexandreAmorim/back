import { endOfDay, sub } from 'date-fns'
import type { Allocation } from '@/lib/generated/client'
import { prisma } from '@/lib/prisma'
import type {
  AllocationRepository,
  CreateAllocation,
} from '../AllocationRepositories'

export class PrismaAllocationRepository implements AllocationRepository {
  async findByUserAllocations(id: string): Promise<Allocation[] | []> {
    const allocations = await prisma.allocation.findMany({
      where: {
        userId: id,
      },
      include: {
        management: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    })
    return allocations
  }

  async findByAllocation(id: number) {
    const allocation = await prisma.allocation.findUnique({
      where: {
        id,
      },
    })

    return allocation
  }

  async createUserAllocations({
    id,
    managementId,
    startedAt,
    authId,
  }: CreateAllocation): Promise<Allocation> {
    const allocation = await prisma.allocation.create({
      data: {
        userId: id,
        managementId,
        startedAt,
        authId: authId,
      },
    })

    return allocation
  }

  async updateUserAllocations({
    allocationEnable,
    startedAt,
    id,
    managementId,
  }: any): Promise<void> {
    await prisma.$transaction(async (tx) => {
      // Finaliza a alocação ativa anterior (se existir)
      if (allocationEnable) {
        await tx.allocation.update({
          where: { id: allocationEnable.id },
          data: {
            endedAt: sub(endOfDay(new Date(startedAt)), { days: 1 }),
          },
        })
      }

      // Cria a nova alocação
      await tx.allocation.create({
        data: {
          userId: id,
          managementId,
          startedAt,
        },
      })
    })
  }
}
