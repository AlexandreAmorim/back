export class ManagementAuthError extends Error {
  constructor(message?: string) {
    super(message ?? 'UNAUTHORIZED')
  }
}
