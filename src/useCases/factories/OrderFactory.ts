import { PrismaOrderRepository } from '@/repositories/prisma/PrismaOrderRepository'
import { GetServiceOrderUseCase } from '../GetServiceOrderUseCase'

export function OrderFactory() {
  const orderRepository = new PrismaOrderRepository()
  const getServiceOrder = new GetServiceOrderUseCase(orderRepository)

  return {
    getServiceOrder,
  }
}
