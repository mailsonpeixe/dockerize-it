import path from 'path';
import { DataSource } from 'typeorm';

import { config } from '../config';

const entities = path.resolve(__dirname, 'entity', '*{.ts,.js}');
const migrations = path.resolve(__dirname, 'migrations', '*{.ts,.js}');
const subscribers = path.resolve(__dirname, 'subscribers', '*{.ts,.js}');

export const dataSource = new DataSource({
  type: 'mysql',
  host: config.DB.host,
  port: config.DB.port,
  migrationsRun: config.DB.migrationsRun,
  database: config.DB.database,
  username: config.DB.username,
  password: config.DB.password,
  synchronize: config.DB.synchronize,
  entities: [entities],
  migrations: [migrations],
  subscribers: [subscribers],
  logger: 'simple-console',
});
