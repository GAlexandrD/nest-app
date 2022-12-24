import { PrismaClient } from '@prisma/client';

// initialize Prisma Client
const prisma = new PrismaClient();

async function main() {
  await prisma.status.upsert({
    where: { name: 'BackLog' },
    update: {},
    create: {
      name: 'BackLog',
    },
  });
  await prisma.status.upsert({
    where: { name: 'BugFound' },
    update: {},
    create: {
      name: 'BugFound',
    },
  });
  await prisma.status.upsert({
    where: { name: 'Done' },
    update: {},
    create: {
      name: 'Done',
    },
  });
  await prisma.status.upsert({
    where: { name: 'InProgress' },
    update: {},
    create: {
      name: 'InProgress',
    },
  });
  await prisma.status.upsert({
    where: { name: 'InReview' },
    update: {},
    create: {
      name: 'InReview',
    },
  });
  await prisma.status.upsert({
    where: { name: 'ToDo' },
    update: {},
    create: {
      name: 'ToDo',
    },
  });
}

// execute the main function
main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    // close Prisma Client at the end
    await prisma.$disconnect();
  });
