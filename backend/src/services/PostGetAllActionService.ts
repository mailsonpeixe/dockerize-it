import { Repository } from 'typeorm';

import { Post } from '../database/entity/Post';
import { dataSource } from '../database/DataSource';

export class PostGetAllActionService {
  private postRepository: Repository<Post>;

  constructor() {
    this.postRepository = dataSource.getRepository(Post);
  }

  async execute(): Promise<Post[]> {
    return this.postRepository.find();
  }
}
