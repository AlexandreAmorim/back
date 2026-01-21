import { PrismaAllocationRepository } from '@/repositories/prisma/PrismaAllocationRepository'
import { PrismaTokenRepository } from '@/repositories/prisma/PrismaTokenRepository'
import { PrismaUserRepository } from '@/repositories/prisma/PrismaUserRepository'
import { AuthenticateUseCase } from '../AuthenticateUseCase'
import { ForgotUseCase } from '../ForgotUseCase'
import { PreviewUseCase } from '../PreviewUseCase'
import { UserTokenUseCase } from '../UserTokenUseCase'

export function AuthenticateFactory() {
  const userRepository = new PrismaUserRepository()
  const allocationsRepository = new PrismaAllocationRepository()
  const tokenForgotRepository = new PrismaTokenRepository()

  const getUserTokenUseCase = new UserTokenUseCase(userRepository)
  const previewUseCase = new PreviewUseCase(userRepository)
  const forgotUseCase = new ForgotUseCase(tokenForgotRepository)
  const authenticateUseCase = new AuthenticateUseCase(
    userRepository,
    allocationsRepository,
  )

  return {
    authenticateUseCase,
    getUserTokenUseCase,
    previewUseCase,
    forgotUseCase,
  }
}
