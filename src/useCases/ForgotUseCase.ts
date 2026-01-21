import type { TokenModel } from '@/lib/generated/models/Token'
import type { TokenRepository } from '@/repositories/TokenRepositories'

interface TokenUseCaseRequest {
  token: string
  type: string
  userId: string
}

export class ForgotUseCase {
  constructor(private tokenForgotRepository: TokenRepository) {}

  async execute(data: TokenUseCaseRequest): Promise<TokenModel> {
    const token = await this.tokenForgotRepository.tokenCreate(data)
    return token
  }
}
