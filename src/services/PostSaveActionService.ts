import { Repository } from 'typeorm';

import { Post } from '../database/entity/Post';
import { dataSource } from '../database/DataSource';

export class PostSaveActionService {
  private postRepository: Repository<Post>;

  constructor() {
    this.postRepository = dataSource.getRepository(Post);
  }

  async execute(post: Post): Promise<Post> {
    const newPost = this.postRepository.create(post);

    return this.postRepository.save(newPost);
  }
}
