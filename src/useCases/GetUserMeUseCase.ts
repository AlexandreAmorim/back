import type { User } from '@/lib/generated/browser'
import type { UserRepository } from '@/repositories/UserRepositories'

interface GetUserMeUseCaseRequest {
  userId: string
}

interface GetUserMeUseCaseResponse {
  user: User
}

export class GetUserMeUseCase {
  constructor(private userRepository: UserRepository) {}

  async execute({
    userId,
  }: GetUserMeUseCaseRequest): Promise<GetUserMeUseCaseResponse> {
    const user = await this.userRepository.findById(userId)

    if (!user) {
      throw new Error('User not found')
    }

    return {
      user,
    }
  }
}
