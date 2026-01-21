import { z } from 'zod'

const envSchema = z.object({
  NODE_ENV: z
    .enum(['development', 'production', 'test'])
    .default('development'),
  HOST: z.string().default('localhost'),
  PORT: z.coerce.number().default(3333),
  FRONT_URL: z.string().default('http://localhost:3000'),
  DATABASE_URL: z.string(),
  TOKEN_SECRET: z.string(),
  TOKEN_EXPIRES_IN: z.string().default('15m'),
  REFRESH_TOKEN_EXPIRES: z.string().default('1d'),
})

export const env = envSchema.parse(process.env)
