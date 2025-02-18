import { Request, Response } from 'express';

import { PostGetByIdActionService } from '../services/PostGetByIdActionService';

export async function postGetByIdAction(request: Request, response: Response) {
  const postGetByIdActionService = new PostGetByIdActionService();
  const post = await postGetByIdActionService.execute(
    Number(request.params.id),
  );

  if (!post) {
    response.status(404).send();
    return;
  }
  response.send(post);
}
