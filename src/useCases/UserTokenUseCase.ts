import type { UserRepository } from '@/repositories/UserRepositories'

interface TokenUseCaseRequest {
  id: string
}

export class UserTokenUseCase {
  constructor(private userRepository: UserRepository) {}

  async execute({ id }: TokenUseCaseRequest): Promise<void> {
    const { token } = await this.userRepository.storeToken(id)
    return token
  }
}
