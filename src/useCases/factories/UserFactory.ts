import { PrismaUserRepository } from '@/repositories/prisma/PrismaUserRepository'
import { GetUserAllUseCase } from '../GetUserAllUseCase'
import { GetUserMeUseCase } from '../GetUserMeUseCase'

export function UserFactory() {
  const userRepository = new PrismaUserRepository()

  const getUsers = new GetUserAllUseCase(userRepository)
  const getUserMe = new GetUserMeUseCase(userRepository)

  return {
    getUsers,
    getUserMe,
  }
}
