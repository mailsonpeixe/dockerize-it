import { Router } from 'express';
import { postRoutes } from './post.routes';

export const appRoutes = Router();

appRoutes.get('/health', (_, response) => {
  response.send('UP');
});
appRoutes.use('/posts', postRoutes);
