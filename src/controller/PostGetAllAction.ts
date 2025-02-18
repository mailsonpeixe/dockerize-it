import { Request, Response } from 'express';

import { PostGetAllActionService } from '../services/PostGetAllActionService';

export async function postGetAllAction(_: Request, response: Response) {
  const postGetAllActionService = new PostGetAllActionService();
  const posts = await postGetAllActionService.execute();

  response.status(200).send(posts);
}
