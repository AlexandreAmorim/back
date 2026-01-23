import { ResourceNotFoundError } from '@/errors/ResourceNotFoundError'
import type { Services } from '@/lib/generated/client'
import type { OrderRepository } from '@/repositories/OrderRepositories'

interface GetUserProfileUseCaseRequest {
  userId: string
}

interface GetOrdersUseCaseResponse {
  unauthorized?: string
  message?: string
  service?: Services
}

export class GetServiceOrderUseCase {
  constructor(private orderRepository: OrderRepository) {}

  async execute({
    userId,
  }: GetUserProfileUseCaseRequest): Promise<GetOrdersUseCaseResponse> {
    const service = await this.orderRepository.autorizateOrderService(userId)

    if (!service) {
      throw new ResourceNotFoundError()
    }

    return {
      service,
    }
  }
}
