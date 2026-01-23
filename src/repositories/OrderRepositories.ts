import type { Services } from '@/lib/generated/client'

export interface OrderRepository {
  autorizateOrderService(id: string): Promise<Services | null>
}
