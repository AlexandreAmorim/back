import type { ZodError } from 'zod'

export function formatZodErrorFlattened(error: ZodError) {
  const flattened = error.flatten()

  return {
    message: 'ERROR_VALIDATION',
    statusCode: 400,
    errors: flattened.fieldErrors,
  }
}
