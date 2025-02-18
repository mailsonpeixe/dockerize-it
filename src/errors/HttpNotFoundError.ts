export class HttpNotFoundError extends Error {
  public statusCode = 404;
  constructor(message: string) {
    super(message);
  }
}
