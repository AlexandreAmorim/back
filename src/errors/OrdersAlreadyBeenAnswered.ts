export class OrdersAlreadyBeenAnswered extends Error {
  constructor() {
    super('Essa consulta já foi respondida.')
  }
}
