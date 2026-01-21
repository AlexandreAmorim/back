import type { Allocation } from '@/lib/generated/client'

export interface CreateAllocation {
  id: string
  managementId: number
  startedAt: Date
  authId: string
}

export interface AllocationRepository {
  findByUserAllocations(id: string): Promise<Allocation[] | []>
  findByAllocation(id: number): Promise<Allocation | null>
  createUserAllocations({
    id,
    managementId,
    startedAt,
    authId,
  }: CreateAllocation): Promise<Allocation>
  updateUserAllocations({
    allocationEnable,
    startedAt,
    id,
    managementId,
  }: any): Promise<void>
}
