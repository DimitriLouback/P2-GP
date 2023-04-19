import Fastify from "fastify"
import cors from '@fastify/cors'
import { z } from 'zod'
import { PrismaClient } from "@prisma/client"


const prisma = new PrismaClient({
    log: ['query'], 
})

async function boostrap() {
    const fastify = Fastify ({
        logger: true,
    })

    await fastify.register(cors, {
        origin: true,
    })

    fastify.get('/solicitacao/cont', async () => {
        
        const cont = await prisma.atendente.count()

        return { cont }
    })



    fastify.post('/atendente', async (request, reply) => {

        const createPoolBody = z.object ({
            nome: z.string(),
            email: z.string(),
            telefone: z.string(),
        })
        
        const { nome, email, telefone } = createPoolBody.parse(request.body)


        await prisma.atendente.create({
            data: {
                nome,
                email,
                telefone
            }
        })


        return reply.status(201).send({ nome })


        
    })



    fastify.post('/solicitacao', async (request, reply) => {

        const createPoolBody = z.object ({
            nomeCliente: z.string(),
            descricao: z.string(),
            status: z.string(),
            nota: z.number(),
            atendenteId: z.string(),
        })
        

        const atendenteId = await prisma.atendente.findMany


        const { nomeCliente, descricao, status, nota, atendenteId} = createPoolBody.parse(request.body)


        await prisma.solicitacao.create({
            data: {
                nomeCliente, 
                descricao,   
                status,      
                nota,        
                atendenteId
            }
        })


        return reply.status(201).send({ nomeCliente })
})



await fastify.listen({ port:3333 })



    await fastify.listen({ port:3333 })
     
}

boostrap()