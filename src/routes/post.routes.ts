import { Router } from 'express';

import { postGetAllAction } from '../controller/PostGetAllAction';
import { postGetByIdAction } from '../controller/PostGetByIdAction';
import { postSaveAction } from '../controller/PostSaveAction';

const postRoutes = Router();

postRoutes.get('/', postGetAllAction);
postRoutes.get('/:id', postGetByIdAction);
postRoutes.post('/', postSaveAction);

export { postRoutes };
