
CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON COLUMN hr.regioes.id_regiao IS 'Chave primária da tabela regioes.';


CREATE TABLE hr.paises (
                id_pais CHAR NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT paises_pk PRIMARY KEY (id_pais)
);
COMMENT ON COLUMN hr.paises.id_pais IS 'Chave primária da tabela países.';
COMMENT ON COLUMN hr.paises.id_regiao IS 'Chave estrangeira da tabela regioes.';


CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                id_pais CHAR NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao)
);
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primária da tabela localização.';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'Chave primária da tabela países.';


CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON COLUMN hr.cargos.id_cargo IS 'Chave primária da tabela cargos.';


CREATE TABLE hr.empregados (
                id_empregados INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_supervisor INTEGER NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                CONSTRAINT empregados_pk PRIMARY KEY (id_empregados)
);
COMMENT ON COLUMN hr.empregados.id_empregados IS 'Chave primária da tabela empregados.';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'Chave estrangeira da tabela empregados (auto-relacionamento). Representa o supervisor direto do empregado 9pode ou não ser o gerente do departamento.';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'Chave primária da tabela cargos.';


CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                id_localizacao INTEGER NOT NULL,
                CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento)
);
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'Chave estangeira da tabela empregados. representa o gerente do departamento.';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'Chave primária da tabela localização.';


CREATE TABLE hr.historico_cargos (
                data_inicial DATE NOT NULL,
                id_empregados INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                CONSTRAINT historico_cargos_pk PRIMARY KEY (data_inicial, id_empregados)
);
COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'Chave primária da tabela de histórico de cargos. Deve ser maior que a data_final.';
COMMENT ON COLUMN hr.historico_cargos.id_empregados IS 'Chave primária da tabela empregados.';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'Chave estrangeira da tabela cargos.';


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
