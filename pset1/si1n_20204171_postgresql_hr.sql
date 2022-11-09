CREATE TABLE public.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE public.regioes IS 'Tabela regiões, contém os nomes e os identificadores das regiões do mundo onde a empresa mantém empregados, escritórios ou outras facilidades.';
COMMENT ON COLUMN public.regioes.id_regiao IS 'Chave primária da tabela regiões.';
COMMENT ON COLUMN public.regioes.nome IS 'Nome da região a ser referenciada.';


CREATE UNIQUE INDEX regioes_idx
 ON public.regioes
 ( nome );

CREATE TABLE public.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT paises_pk PRIMARY KEY (id_pais)
);
COMMENT ON TABLE public.paises IS 'Tabela com informaçẽos sobre os país onde a empresa mantém escritórios, empregados ou outras facilidades.';
COMMENT ON COLUMN public.paises.id_pais IS 'Chave primária da tabela países.';
COMMENT ON COLUMN public.paises.nome IS 'Nome do país a ser referenciado.';


CREATE UNIQUE INDEX paises_idx
 ON public.paises
 ( nome );

CREATE TABLE public.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2),
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE public.localizacoes IS 'Tabela localizações, armazena os endereços dos escritórios e facilidades da empresa. Não armazena endereços de clientes.';
COMMENT ON COLUMN public.localizacoes.id_localizacao IS 'Chave primária da tabela localizações.';
COMMENT ON COLUMN public.localizacoes.endereco IS 'Endereço de uma facilidade da empresa (rua, número).';
COMMENT ON COLUMN public.localizacoes.cep IS 'CEP da localização de uma facilidade da empresa.';
COMMENT ON COLUMN public.localizacoes.cidade IS 'Cidade onde estã localizado a facilidade da empresa.';
COMMENT ON COLUMN public.localizacoes.uf IS 'Estado onde está locaizada uma facilidade da empresa (pode ser inserido abreviado ou por extenso).';
COMMENT ON COLUMN public.localizacoes.id_pais IS 'Chave estrangeira para a tabela países.';


CREATE TABLE public.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                slario_maximo NUMERIC(8,2),
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE public.cargos IS 'Tabela cargos, dedicada a armazenar cargos existentes e a faixa salarial entre funcionários (salário máximo e mínimo), para cada cargo.';
COMMENT ON COLUMN public.cargos.id_cargo IS 'Chave primária da tabela cargos.';
COMMENT ON COLUMN public.cargos.cargo IS 'Nome do cargo a ser referenciado.';
COMMENT ON COLUMN public.cargos.salario_minimo IS 'O menor salário atribuido a um cargo.';
COMMENT ON COLUMN public.cargos.slario_maximo IS 'O maior salário atribuído a um cargo.';


CREATE UNIQUE INDEX cargos_idx
 ON public.cargos
 ( cargo );

CREATE TABLE public.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(4,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER,
                id_supervisor INTEGER,
                CONSTRAINT empregados_pk PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE public.empregados IS 'Tabela empregados, armazena informações, como dados pessoais, dos empregados da empresa.';
COMMENT ON COLUMN public.empregados.id_empregado IS 'Chave primária da tabela empregados.';
COMMENT ON COLUMN public.empregados.nome IS 'Nome completo do empregado.';
COMMENT ON COLUMN public.empregados.email IS 'Usuãrio de email do empregado, parte inicial do email (antes do @).';
COMMENT ON COLUMN public.empregados.telefone IS 'Telefone do empregado (existe espaço disponível para identificadores de país e estado)';
COMMENT ON COLUMN public.empregados.data_contratacao IS 'Data de contratação do empregado no cargo atual.';
COMMENT ON COLUMN public.empregados.id_cargo IS 'Chave estrangeira para a tabela cargos, representa o atual cargo do empregado na empresa.';
COMMENT ON COLUMN public.empregados.salario IS 'Atual salário mensal do empregado.';
COMMENT ON COLUMN public.empregados.comissao IS 'Porcentagem de comissão recebida pelo funcionário, apenas funcionários do setor de vendas podem ter uma comissão atribuída a seu cargo.';
COMMENT ON COLUMN public.empregados.id_departamento IS 'Chave estrangeira para a tabela departamentos, indica o atual departamento de atuação do funcionário.';
COMMENT ON COLUMN public.empregados.id_supervisor IS 'Chave estrangeira para a prórpia tabela empregados. Indica o supervisor direto do empregado, que pode ou não ser o mesmo gerente do departamento referenciado como id_gerente na tabela departamentos.';


CREATE UNIQUE INDEX empregados_idx
 ON public.empregados
 ( email );

CREATE TABLE public.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER,
                id_gerente INTEGER,
                CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE public.departamentos IS 'Tabela departamentos, armazena as informações sobre os diversos departamentos da empresa.';
COMMENT ON COLUMN public.departamentos.id_departamento IS 'Chave primária da tabela departamentos.';
COMMENT ON COLUMN public.departamentos.nome IS 'Nome do departamento referenciado.';
COMMENT ON COLUMN public.departamentos.id_localizacao IS 'Chave estrageira para a tabela localizações, se refere à localização do departamento.';
COMMENT ON COLUMN public.departamentos.id_gerente IS 'Chave estrangeira para a tabela empregados, representa, se houver, o empregado que cumpre a função de gerente do departamento referenciado.';


CREATE UNIQUE INDEX departamentos_idx
 ON public.departamentos
 ( nome );

CREATE TABLE public.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER,
                CONSTRAINT historico_cargos_pk PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE public.historico_cargos IS 'Tabela de histórico de cargos, armazena o histórico dos empregados dentro dos cargos que eles ocuparam por um tempo determinado por datas, inicial e final, na empresa. Quando um empregado muda de cargo dentro de um departamento ou quando muda de departamento em um mesmo cargo, uma nova linha deve ser adiocnada a tabela com as informações antigas do empregado.';
COMMENT ON COLUMN public.historico_cargos.id_empregado IS 'Parte da chave primária composta para a tabela de histórico de cargos (id_empregado e data_inicial). Também é uma chave estrangeira da tabela empregados, referencia o empregado na linha que serão adicionadas as informações sobre seu histórico em cada cargo ocupado na empresa.';
COMMENT ON COLUMN public.historico_cargos.data_inicial IS 'Parte da chave primária composta para a tabela de histórico de cargos (id_empregado e data_inicial). Indica a data inicial de um empregado em um cargo específico, precisa ser menor que a data_final na tabela.';
COMMENT ON COLUMN public.historico_cargos.data_final IS 'A data que marca o último dia do empregado naquele cargo, deve ser maior que a data_inicial na tabela.';
COMMENT ON COLUMN public.historico_cargos.id_cargo IS 'Chave estrangeira da tabela cargos. Corresponde ao cargo que a pessoa ocupava no passado, no perídodo referenciado pelas datas.';
COMMENT ON COLUMN public.historico_cargos.id_departamento IS 'Chave estrangeira da tabela departamentos. Corresponde ao departamento que a pessoa pertencia no passado, no perídodo referenciado pelas datas.';


ALTER TABLE public.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES public.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES public.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES public.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES public.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES public.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES public.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

