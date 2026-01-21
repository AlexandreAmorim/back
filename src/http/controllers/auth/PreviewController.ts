import { randomBytes } from 'node:crypto'
import { env } from 'node:process'
import { promisify } from 'node:util'
//import * as aws from '@aws-sdk/client-ses'
import type { FastifyReply, FastifyRequest } from 'fastify'
import { z } from 'zod'
import { BadRequestError } from '@/errors/BadRequestError'
//import nodemailer from 'nodemailer'
import { AuthenticateFactory } from '@/useCases/factories/AthenticateFactory'

export async function previewController(
  request: FastifyRequest,
  reply: FastifyReply,
) {
  const previewSchema = z.object({
    email: z.string().email(),
  })

  const { email } = previewSchema.parse(request.body)
  const { previewUseCase, forgotUseCase } = AuthenticateFactory()
  const userFromEmail = await previewUseCase.execute({
    email,
  })

  if (!userFromEmail) {
    throw new BadRequestError('Usuário nao localizado.')
  }

  const random = await promisify(randomBytes)(24)
  const token = random.toString('hex')

  const tokenCreate = await forgotUseCase.execute({
    token,
    type: 'forgot-password',
    userId: userFromEmail.id,
  })

  if (!tokenCreate.id) {
    return reply.status(400).send({
      message: 'Erro ao gravar no banco.',
    })
  }
  const resetPasswordUrl = `${env.FRONT_URL}/reset/${token}`

  console.log('RR ', resetPasswordUrl)

  /*
  const ses = new aws.SES({
    apiVersion: '2024-08-05',
    region: env.SES_REGION, // Your region will need to be updated
    credentials: {
      accessKeyId: env.SES_ACCESS_KEY_ID,
      secretAccessKey: env.SES_SECRET_ACCESS_KEY,
    },
  })

  const transporter = nodemailer.createTransport({
    SES: { ses, aws },
  })

  transporter.sendMail({
    from: {
      name: 'Hórus Web',
      address: email,
    },
    to: email,
    subject: 'Autenticação - Hórus',
    date: 'klklkl',
  })
    */

  return reply.status(200).send({
    message:
      'Se você forneceu um e-mail cadastrado em breve receberá um e-mail com o link para você criar uma nova senha.',
  })
}
