import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { StatusService } from './status.service';
import { CreateStatusDto } from './dto/create-status.dto';
import { UpdateStatusDto } from './dto/update-status.dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { StatusEntity } from './entities/status.entity';

@Controller('status')
@ApiTags('status')
export class StatusController {
  constructor(private readonly statusService: StatusService) {}

  @Post()
  @ApiCreatedResponse({ type: StatusEntity })
  create(@Body() createStatusDto: CreateStatusDto) {
    return this.statusService.create(createStatusDto);
  }

  @Get()
  @ApiOkResponse({ type: StatusEntity, isArray: true })
  findAll() {
    return this.statusService.findAll();
  }

  @Get(':id')
  @ApiOkResponse({ type: StatusEntity })
  findOne(@Param('id') id: string) {
    return this.statusService.findOne(id);
  }

  @Patch(':id')
  @ApiOkResponse({ type: StatusEntity })
  update(@Param('id') id: string, @Body() updateStatusDto: UpdateStatusDto) {
    return this.statusService.update(id, updateStatusDto);
  }

  @Delete(':id')
  @ApiOkResponse({ type: StatusEntity })
  remove(@Param('id') id: string) {
    return this.statusService.remove(id);
  }
}
