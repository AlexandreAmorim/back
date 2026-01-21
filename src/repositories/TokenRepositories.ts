import type { TokenModel } from '@/lib/generated/models/Token'

export interface IPropsToken {
  token: string
  type: string
  userId: string
}

export interface TokenRepository {
  tokenCreate(data: IPropsToken): Promise<TokenModel>
}
