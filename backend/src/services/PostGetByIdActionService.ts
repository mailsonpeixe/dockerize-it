import { Repository } from 'typeorm';

import { Post } from '../database/entity/Post';
import { dataSource } from '../database/DataSource';
import { HttpNotFoundError } from '../errors/HttpNotFoundError';

export class PostGetByIdActionService {
  private postRepository: Repository<Post>;

  constructor() {
    this.postRepository = dataSource.getRepository(Post);
  }

  async execute(id: number): Promise<Post> {
    const post = await this.postRepository.findOneBy({ id });

    if (!post) {
      throw new HttpNotFoundError(`Post with id ${id} not found`);
    }
    return post;
  }
}
