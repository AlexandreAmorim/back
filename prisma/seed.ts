// prisma/seed.ts

import { hash } from 'bcryptjs'
import { generateId } from '@/lib/id'
import { prisma } from '@/lib/prisma'

async function main() {
  // Permissions
  const permissions = [
    { name: 'c:user', description: 'Criar usuários' },
    { name: 'r:user', description: 'Visualizar usuários' },
    { name: 'u:user', description: 'Atualizar usuários' },
    { name: 'd:user', description: 'Deletar usuários' },

    { name: 'c:role', description: 'Criar roles' },
    { name: 'r:role', description: 'Visualizar roles' },
    { name: 'u:role', description: 'Atualizar roles' },
    { name: 'd:role', description: 'Deletar roles' },

    { name: 'r:log', description: 'Visualizar logs' },

    { name: 'c:order', description: 'Criar consultas' },
    { name: 'r:order', description: 'Visualizar consultas' },
    { name: 'u:order', description: 'Atualizar consultas' },
    { name: 'd:order', description: 'Deletar consultas' },

    { name: 'r:order-oper', description: 'Visualizar consultas operador' },
    { name: 'c:order-oper', description: 'Responder consultas (Central)' },
  ]

  for (const permission of permissions) {
    await prisma.permission.upsert({
      where: { name: permission.name },
      update: {},
      create: {
        name: permission.name,
        slug: permission.name,
        description: permission.description,
      },
    })
  }

  // Roles
  const adminRole = await prisma.role.upsert({
    where: { name: 'Admin' },
    update: {},
    create: {
      slug: 'admin',
      name: 'Admin',
      description: 'Administrador com acesso total',
    },
  })

  const operRole = await prisma.role.upsert({
    where: { name: 'Operador' },
    update: {},
    create: {
      slug: 'operator',
      name: 'Operador',
      description: 'Operador de consultas',
    },
  })

  const userRole = await prisma.role.upsert({
    where: { name: 'Usuario' },
    update: {},
    create: {
      slug: 'user',
      name: 'Usuario',
      description: 'Usuário padrão',
    },
  })

  // Admin tem todas as permissions
  const allPermissions = await prisma.permission.findMany()

  for (const permission of allPermissions) {
    const existing = await prisma.permissionRole.findFirst({
      where: {
        roleId: adminRole.id,
        permissionId: permission.id,
      },
    })

    if (!existing) {
      await prisma.permissionRole.create({
        data: {
          roleId: adminRole.id,
          permissionId: permission.id,
        },
      })
    }
  }

  // Oper tem apenas read
  const operPermission = await prisma.permission.findUnique({
    where: { name: 'r:order-oper' },
  })

  if (operPermission) {
    const existing = await prisma.permissionRole.findFirst({
      where: {
        roleId: operRole.id,
        permissionId: operPermission.id,
      },
    })

    if (!existing) {
      await prisma.permissionRole.create({
        data: {
          roleId: operRole.id,
          permissionId: operPermission.id,
        },
      })
    }
  }

  // User tem apenas read
  const readPermission = await prisma.permission.findUnique({
    where: { name: 'r:user' },
  })

  if (readPermission) {
    const existing = await prisma.permissionRole.findFirst({
      where: {
        roleId: userRole.id,
        permissionId: readPermission.id,
      },
    })

    if (!existing) {
      await prisma.permissionRole.create({
        data: {
          roleId: userRole.id,
          permissionId: readPermission.id,
        },
      })
    }
  }

  // Criar admin user
  const hashedPassword = await hash('admin123', 10)

  await prisma.user.upsert({
    where: { email: 'admin@example.com' },
    update: {},
    create: {
      id: generateId(),
      firstName: 'Admin',
      lastName: 'Segov',
      document: '11111111111',
      documentSecondary: '1111111',
      email: 'admin@example.com',
      password: hashedPassword,
      isIntelligence: true,
      birthday: new Date('1990-01-01'),
      gender: 'Masculino',
      phone: '(21)999999999',
    },
  })

  // Criar usuário Operacional
  await prisma.user.upsert({
    where: { email: 'usuario@example.com' },
    update: {},
    create: {
      id: generateId(),
      email: 'usuario@example.com',
      password: hashedPassword,
      firstName: 'Usuario Operacional',
      lastName: 'Teste',
      document: '22222222222',
      documentSecondary: '2222222',
      birthday: new Date('1990-01-01'),
      gender: 'Masculino',
      phone: '(21)888888888',
    },
  })

  // Criar usuário Operador
  await prisma.user.upsert({
    where: { email: 'operador@example.com' },
    update: {},
    create: {
      id: generateId(),
      email: 'operador@example.com',
      password: hashedPassword,
      firstName: 'Operador de Consultas',
      lastName: 'Teste',
      document: '33333333333',
      documentSecondary: '3333333',
      isIntelligence: true,
      birthday: new Date('1990-01-01'),
      gender: 'Masculino',
      phone: '(21)777777777',
    },
  })

  console.log('✅ Usuários criados')
  console.log('\n📧 Credenciais de acesso:')
  console.log('Admin: admin@example.com / admin123')
  console.log('Operacional: usuario@example.com / admin123')
  console.log('Central: operador@example.com / admin123')
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect())
