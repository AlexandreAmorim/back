import type { TokenModel } from '@/lib/generated/models/Token'
import { prisma } from '@/lib/prisma'
import type { IPropsToken, TokenRepository } from '../TokenRepositories'

export class PrismaTokenRepository implements TokenRepository {
  async tokenCreate(data: IPropsToken): Promise<TokenModel> {
    const tokenCreate = await prisma.token.create({
      data: {
        token: data.token,
        type: data.type,
        userId: data.userId,
      },
    })

    return tokenCreate
  }
}
