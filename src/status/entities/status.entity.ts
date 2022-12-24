import { ApiProperty } from '@nestjs/swagger';
import { status_name } from '../dto/create-status.dto';

export class StatusEntity {
  @ApiProperty()
  id: string;
  @ApiProperty()
  name: status_name;
}
