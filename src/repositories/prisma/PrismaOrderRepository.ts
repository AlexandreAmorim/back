import { addHours, isBefore } from 'date-fns'
import { prisma } from '@/lib/prisma'
import type { OrderRepository } from '../OrderRepositories'

export class PrismaOrderRepository implements OrderRepository {
  async autorizateOrderService(id: string): Promise<any> {
    const isOrderWaiting = await prisma.orders.findMany({
      select: {
        id: true,
      },
      where: {
        userId: id,
        status: 'Aguardando',
      },
    })

    if (isOrderWaiting.length > 0) {
      return {
        unauthorized: true,
        message: 'Você tem uma consulta em análise. Aguarde ser respondida.',
      }
    }

    const isOrderWaitingTwo = await prisma.orders.findMany({
      where: {
        userId: id,
        status: 'Processando',
      },
    })

    if (isOrderWaitingTwo.length > 0) {
      return {
        default: 1,
        unauthorized: true,
        message: 'Você tem uma consulta em análise. Aguarde ser respondida.',
      }
    }

    const isClosingFormWaiting = await prisma.closingForms.findMany({
      where: {
        userId: id,
        status: 'Aguardando',
      },
    })

    if (isClosingFormWaiting.length > 0) {
      return {
        default: 2,
        unauthorized: true,
        message: 'Você precisa preencher o formulário de encerramento.',
      }
    }

    const service = await prisma.services.findFirst({
      where: {
        userId: id,
      },
      include: {
        user: true,
        sector: true,
        management: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    })

    if (!service) {
      return {
        service: null,
      }
    }

    const add24Horas = addHours<any>(service.createdAt, 24)

    if (isBefore(add24Horas, new Date())) {
      return {
        service: null,
      }
    }

    const addUmaHoras = addHours<any>(service.endedAt, 1)

    if (isBefore(addUmaHoras, new Date())) {
      return {
        service: null,
      }
    }

    return {
      service: {
        id: service.id,
        sectorId: service?.sectorId,
        sInitials: service.sector ? service.sector.initials : null,
        managementId: service.managementId,
        mInitials: service.management ? service.management.initials : null,
        presenceStartedId: service.presenceStartedId,
        presenceEndedId: service.presenceEndedId,
        presenceStartedAt: service.presenceStartedAt,
        presenceEndedAt: service.presenceEndedAt,
        startedAt: service.startedAt,
        endedAt: service.endedAt,
      },
    }
  }
}
