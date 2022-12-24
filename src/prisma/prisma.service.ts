import { INestApplication, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient {
  async enableShutdownHooks(app: INestApplication) {
    this.$on('beforeExit', async () => {
      await app.close();
    });
  }
  unhex(s) {
    const arr = [];
    for (let i = 0; i < s.length; i += 2) {
      const c = s.substr(i, 2);
      arr.push(parseInt(c, 16));
    }
    return Buffer.from(arr);
  }
  hex(b: Buffer) {
    return b.toString('hex');
  }
}
