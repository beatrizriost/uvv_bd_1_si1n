
CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON COLUMN hr.regioes.id_regiao IS 'Chave primária da tabela regioes.';
COMMENT ON COLUMN hr.regioes.nome IS 'Nome da região.';


CREATE UNIQUE INDEX regioes_idx
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR NOT NULL,
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT paises_pk PRIMARY KEY (id_pais)
);
COMMENT ON COLUMN hr.paises.id_pais IS 'Chave primária da tabela países.';
COMMENT ON COLUMN hr.paises.id_regiao IS 'Chave estrangeira da tabela regioes.';
COMMENT ON COLUMN hr.paises.nome IS 'Nome do país.';


CREATE UNIQUE INDEX paises_idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao)
);
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primária da tabela localização.';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Endereço (rua e número) de uma facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.cep IS 'CEP de uma facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade de localização de uma facilidade da empresa.';
COMMENT ON COLUMN hr.localizacoes.uf IS 'Estado de loalização de alguma facilidade da empresa (abreviado ou por extenso).';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'Chave primária da tabela países.';


CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON COLUMN hr.cargos.id_cargo IS 'Chave primária da tabela cargos.';
COMMENT ON COLUMN hr.cargos.cargo IS 'Nome do cargo.';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'O menor salário existente para um cargo.';
COMMENT ON COLUMN hr.cargos.salario_maximo IS 'O maior salário existente para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.empregados (
                id_empregados INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                id_departamento INTEGER NOT NULL,
                id_supervisor INTEGER NOT NULL,
                CONSTRAINT empregados_pk PRIMARY KEY (id_empregados)
);
COMMENT ON COLUMN hr.empregados.id_empregados IS 'Chave primária da tabela empregados.';
COMMENT ON COLUMN hr.empregados.nome IS 'Nome completo do empregado.';
COMMENT ON COLUMN hr.empregados.email IS 'Usuário de email do empregado (parte antes do @).';
COMMENT ON COLUMN hr.empregados.telefone IS 'Telefone completo do empregado (possui espaço para país e estado).';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Data que o empregado iniciou no cargo atual.';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'Chave primária da tabela cargos.';
COMMENT ON COLUMN hr.empregados.salario IS 'Salário atual do empregado (mensal).';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'Chave estrangeira da tabela empregados (auto-relacionamento). Representa o supervisor direto do empregado 9pode ou não ser o gerente do departamento.';


CREATE UNIQUE INDEX empregados_idx
 ON hr.empregados
 ( email );

CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_gerente INTEGER NOT NULL,
                id_localizacao INTEGER NOT NULL,
                CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento)
);
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN hr.departamentos.nome IS 'Nome do departamento.';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'Chave estangeira da tabela empregados. representa o gerente do departamento.';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'Chave primária da tabela localização.';


CREATE UNIQUE INDEX departamentos_idx
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.historico_cargos (
                id_empregados INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT historico_cargos_pk PRIMARY KEY (id_empregados, data_inicial)
);
COMMENT ON COLUMN hr.historico_cargos.id_empregados IS 'Chave primária da tabela empregados.';
COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'Chave primária da tabela de histórico de cargos. Deve ser maior que a data_final.';
COMMENT ON COLUMN hr.historico_cargos.data_final IS 'Último dia do empregado naquele cargo. deve ser maios que a data inicial.';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'Chave estrangeira da tabela cargos.';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'Chave primária da tabela departamentos.';


ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregados)
REFERENCES hr.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
