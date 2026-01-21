import type { User } from '@/lib/generated/client'

export type UsersParams = {
  id?: string
  status?: string
  page: number
  perPage: number
  managementId?: number
  search?: string
}
export type UsersResult = {
  data: User[]
  totalCount: number
}

export interface IPropsUserPermission {
  roles?: string[]
  permissions?: string[]
}

export interface UserRepository {
  findById(id: string): Promise<User | null>
  findUsers(params: UsersParams): Promise<UsersResult>
  findByDocument(document: string): Promise<User | null>
  findByDocumentSecondary(documentSecondary: string): Promise<User | null>
  findByRolesPermissions(id: string): Promise<IPropsUserPermission | undefined>
  findByEmail(email: string): Promise<User | null>
  storeToken(id: string): Promise<any>
}
