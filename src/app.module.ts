import { Module } from '@nestjs/common';
import { StatusModule } from './status/status.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [StatusModule, PrismaModule],
})
export class AppModule {}
