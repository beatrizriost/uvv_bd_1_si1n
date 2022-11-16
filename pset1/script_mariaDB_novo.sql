--criação usuário beatriz_teixeira
CREATE USER beatriz_teixeira 
    IDENTIFIED BY "beatriz@raiz";

-- criação banco de dados uvv
CREATE DATABASE uvv
COMMENT "Banco de dados para o PSet 1"
;

-- alteração de usuário para o novo usuário beatriz_teixeira
\c "user=beatriz_teixeira password=beatriz@raiz dbname=uvv"

-- criação esquema hr 
CREATE SCHEMA hr 
COMMENT 'Esquema para as tabelas'

-- criação tabela regiões
CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária da tabela regioes.';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome da região.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

-- criação tabela países
CREATE TABLE paises (
                id_pais CHAR NOT NULL,
                id_regiao INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_pais)
);

ALTER TABLE paises MODIFY COLUMN id_pais CHAR COMMENT 'Chave primária da tabela países.';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira da tabela regioes.';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do país.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

-- criação tabela localizações
CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR NOT NULL,
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primária da tabela localização.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço (rua e número) de uma facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP de uma facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Cidade de localização de uma facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'ado ou por extenso).';

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR COMMENT 'Chave primária da tabela países.';

-- criação tabela cargos
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária da tabela cargos.';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'O menor salário existente para um cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'O maior salário existente para um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

-- criação tabela empregados
CREATE TABLE empregados (
                id_empregados INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                id_departamento INT NOT NULL,
                id_supervisor INT NOT NULL,
                PRIMARY KEY (id_empregados)
);

ALTER TABLE empregados MODIFY COLUMN id_empregados INTEGER COMMENT 'Chave primária da tabela empregados.';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome completo do empregado.';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Usuário de email do empregado (parte antes do @).';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Telefone completo do empregado (espaço para país e estado).';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data que o empregado iniciou no cargo atual.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária da tabela cargos.';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Salário atual do empregado (mensal).';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária da tabela departamentos.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'o empregado.';


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

-- criação tabela departamentos
CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50),
                id_gerente INT NOT NULL,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária da tabela departamentos.';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do departamento.';

ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'ento.';


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

-- criação tabela localizações_departamentos
CREATE TABLE localizaes_departamentos (
                id_localizacao INT NOT NULL,
                id_departamento INT NOT NULL,
                id_localizacao_departamentos INT NOT NULL,
                PRIMARY KEY (id_localizacao, id_departamento, id_localizacao_departamentos)
);

ALTER TABLE localizaes_departamentos COMMENT 'Tabela para controlar o relacionamento entre as tabelas localizações e deprtamentos';

ALTER TABLE localizaes_departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primária da tabela localização.';

ALTER TABLE localizaes_departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária da tabela departamentos.';

ALTER TABLE localizaes_departamentos MODIFY COLUMN id_localizacao_departamentos INTEGER COMMENT 'Chave primária da tabela localizacoes_departamentos.';

-- criação tabela histõrico_cargos
CREATE TABLE historico_cargos (
                id_empregados INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                PRIMARY KEY (id_empregados, data_inicial)
);

ALTER TABLE historico_cargos MODIFY COLUMN id_empregados INTEGER COMMENT 'Chave primária da tabela empregados.';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'ior que a data_final.';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'data inicial.';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeira da tabela cargos.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária da tabela departamentos.';

-- criação de chave estrangeira na tabela países
ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela localizações
ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estranegira na tabela localizações_departamentos
ALTER TABLE localizaes_departamentos ADD CONSTRAINT localizacoes_localizações_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela historico_cargos
ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela empregados
ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela empregados
ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela historico_cargos
ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregados)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela departamentos 
ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela empregados
ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela historico_cargos
ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- criação de chave estrangeira na tabela localizações departamentos
ALTER TABLE localizaes_departamentos ADD CONSTRAINT departamentos_localizações_departamentos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
