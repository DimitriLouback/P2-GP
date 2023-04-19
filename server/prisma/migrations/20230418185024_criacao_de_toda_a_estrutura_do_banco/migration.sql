-- CreateTable
CREATE TABLE "Atendente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefone" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Solicitacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nomeCliente" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "nota" INTEGER NOT NULL,
    "atendenteId" TEXT NOT NULL,
    CONSTRAINT "Solicitacao_atendenteId_fkey" FOREIGN KEY ("atendenteId") REFERENCES "Atendente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Componente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tipo" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "solicitacaoId" TEXT,
    CONSTRAINT "Componente_solicitacaoId_fkey" FOREIGN KEY ("solicitacaoId") REFERENCES "Solicitacao" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "HistoricoComponente" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "evento" TEXT NOT NULL,
    "componenteId" TEXT NOT NULL,
    CONSTRAINT "HistoricoComponente_componenteId_fkey" FOREIGN KEY ("componenteId") REFERENCES "Componente" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
