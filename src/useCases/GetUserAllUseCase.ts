import type { User } from '@/lib/generated/client'
import type { UserRepository } from '@/repositories/UserRepositories'

type UserRequest = {
  id?: string
  status?: string
  page: number
  perPage: number
  managementId?: number
  search?: string
}

type UserResponse = {
  data: Partial<User[]>
  totalCount: number
}

export class GetUserAllUseCase {
  constructor(private userRepository: UserRepository) {}

  async execute({
    id,
    page,
    perPage,
    status,
    managementId,
    search,
  }: UserRequest): Promise<UserResponse> {

    const { data, totalCount } = await this.userRepository.findUsers({
      id,
      page,
      perPage,
      status,
      managementId,
      search,
    })

    return { data, totalCount }
  }
}