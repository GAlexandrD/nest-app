import { ApiProperty } from '@nestjs/swagger';

export enum status_name {
  Done = 'Done',
  BugFound = 'BugFound',
  InReview = 'InReview',
  InProgress = 'InProgress',
  ToDo = 'ToDo',
  BackLog = 'BackLog',
}

export class CreateStatusDto {
  @ApiProperty()
  name: status_name;
}
