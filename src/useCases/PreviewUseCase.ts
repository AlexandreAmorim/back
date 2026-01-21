import type { User } from '@/lib/generated/client'
import type { UserRepository } from '@/repositories/UserRepositories'

interface EmailUseCaseRequest {
  email: string
}

export class PreviewUseCase {
  constructor(private userRepository: UserRepository) {}

  async execute({ email }: EmailUseCaseRequest): Promise<User | null> {
    const userFromEmail = await this.userRepository.findByEmail(email)

    return userFromEmail
  }
}
