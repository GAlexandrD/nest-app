import { Body, Injectable, NotFoundException } from '@nestjs/common';
import { CreateStatusDto } from './dto/create-status.dto';
import { UpdateStatusDto } from './dto/update-status.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { status_name } from '@prisma/client';

@Injectable()
export class StatusService {
  constructor(private prisma: PrismaService) {}
  async create(@Body() createStatusDto: CreateStatusDto) {
    try {
      const status = await this.prisma.status.create({ data: createStatusDto });
      const id = this.prisma.hex(status.id);
      return { ...status, id };
    } catch (error) {
      throw new NotFoundException('invalis status');
    }
  }

  async findAll() {
    const statuses = await this.prisma.status.findMany({});
    const responseStatuses = statuses.map((status) => ({
      ...status,
      id: this.prisma.hex(status.id),
    }));
    return responseStatuses;
  }

  async findOne(id: string) {
    const idUnHexed = this.prisma.unhex(id);
    const status = await this.prisma.status.findFirst({
      where: { id: idUnHexed },
    });
    if (!status)
      throw new NotFoundException(`status with id: ${id} does not exist`);
    return { ...status, id };
  }

  async update(id: string, updateStatusDto: UpdateStatusDto) {
    const idUnHexed = this.prisma.unhex(id);
    const status = await this.prisma.status.update({
      where: { id: idUnHexed },
      data: updateStatusDto,
    });
    if (!status)
      throw new NotFoundException(`status with id: ${id} does not exist`);
    return { ...status, id };
  }

  async remove(id: string) {
    const idUnHexed = this.prisma.unhex(id);
    const status = await this.prisma.status.delete({
      where: { id: idUnHexed },
    });
    if (!status)
      throw new NotFoundException(`status with id: ${id} does not exist`);
    return { ...status, id };
  }
}
