import { compare } from 'bcryptjs'
import { InvalidCredentialsError } from '@/errors/InvalidCredentialsError'
import type { AllocationRepository } from '@/repositories/AllocationRepositories'
import type { UserRepository } from '@/repositories/UserRepositories'
import { findAllocationEnabled } from '@/services/findAllocationEnabled'
import { findSettingsVersion } from '@/services/findSettingVersion'

interface AuthenticateUseCaseRequest {
  document: string
  password: string
}

interface IAllocation {
  endedAt: Date | null
  managementId: number
  startedAt: Date
}

interface IResponse {
  id: string
  email: string
  name: string
  avatar?: string
  firstName: string
  document: string
  isIntelligence: boolean | null
  allocation?: IAllocation | null | boolean
  roles?: string[]
  permissions?: string[]
}

interface AuthenticateUseCaseResponse {
  user: IResponse
  spaVersion?: string | null
}

export class AuthenticateUseCase {
  constructor(
    private userRepository: UserRepository,
    private allocationRepository: AllocationRepository,
  ) {}

  async execute({
    document,
    password,
  }: AuthenticateUseCaseRequest): Promise<AuthenticateUseCaseResponse> {
    const user = await this.userRepository.findByDocument(document)

    if (!user) {
      throw new InvalidCredentialsError()
    }

    const doestPasswordMatches = await compare(password, user.password)

    if (!doestPasswordMatches) {
      throw new InvalidCredentialsError()
    }

    if (!user.status) {
      throw new Error(
        'Seu acesso está bloqueado. Entre em contato com a equipe de suporte no e-mail tic@segov.rj.gov.br',
      )
    }

    const reponse = await this.userRepository.findByRolesPermissions(user.id)

    const allocations = await this.allocationRepository.findByUserAllocations(
      user.id,
    )

    const allocation = await findAllocationEnabled(allocations)
    const setting = await findSettingsVersion()

    return {
      user: {
        id: user.id,
        email: user.email,
        name: `${user.firstName} ${user.lastName}`,
        firstName: user.firstName,
        document: user.document,
        isIntelligence: user.isIntelligence,
        roles: reponse?.roles,
        allocation:
          allocation && typeof allocation !== 'boolean'
            ? {
                endedAt: allocation.endedAt,
                managementId: allocation.managementId,
                startedAt: allocation.startedAt,
              }
            : null,
        permissions: reponse?.permissions,
      },
      spaVersion: setting?.version,
    }
  }
}
