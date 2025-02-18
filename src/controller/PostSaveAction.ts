import { Request, Response } from 'express';

import { PostSaveActionService } from '../services/PostSaveActionService';

export async function postSaveAction(request: Request, response: Response) {
  const postSaveActionService = new PostSaveActionService();
  const newPost = await postSaveActionService.execute(request.body);

  response.status(201).send(newPost);
}
