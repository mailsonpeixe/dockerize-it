import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { Category } from './Category';

@Entity()
export class Post {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('varchar')
  title: string;

  @Column('text')
  text: string;

  @ManyToMany(() => Category, (category) => category.id, { cascade: true })
  @JoinTable()
  categories: Category[];
}
