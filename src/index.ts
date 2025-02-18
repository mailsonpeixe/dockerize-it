import 'reflect-metadata';
import express from 'express';

import { appRoutes } from './routes/';
import { dataSource } from './database/DataSource';
import { config } from './config';

(async () => {
  const app = express();
  app.use(
    express.json({ limit: '5mb' }),
    express.urlencoded({ limit: '5mb', extended: true }),
    appRoutes,
  );
  await dataSource.initialize();
  app.listen(config.SERVER.port, () => {
    console.log(`Application is up and running on port ${config.SERVER.port}`);
  });
})();
