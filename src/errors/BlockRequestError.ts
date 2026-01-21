export class BlockRequestError extends Error {
  constructor() {
    super(
      'Seu acesso está bloqueado. Entre em contato com a equipe de suporte no e-mail tic@segov.rj.gov.br'
    )
  }
}
