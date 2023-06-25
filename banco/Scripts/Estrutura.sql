CREATE GENERATOR filmes_id_gen;


CREATE TABLE filmes (
  id INTEGER NOT NULL,
  titulo VARCHAR(50),
  ano_lanc INTEGER,
  classificacao VARCHAR(3),
  categorias VARCHAR(200),
  PRIMARY KEY (id)
);



CREATE TRIGGER filmes_bi FOR filmes
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.id IS NULL) THEN
  BEGIN
    NEW.id = GEN_ID(filmes_id_gen, 1);
  END
END;





CREATE GENERATOR recibos_id_gen;

CREATE TABLE recibos (
  id INTEGER NOT NULL,
  id_sessao INTEGER,
  data DATE,
  hora TIME,
  cadeira VARCHAR(5),
  valor FLOAT,
  forma_pagamento VARCHAR(30),
  PRIMARY KEY (id)
);





CREATE TRIGGER recibos_bi FOR recibos
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.id IS NULL) THEN
  BEGIN
    NEW.id = GEN_ID(recibos_id_gen, 1);
  END
END;





CREATE TABLE salas (
  id INTEGER NOT NULL,
  nome_sala VARCHAR(30),
  fileiras INTEGER,
  cadeiras INTEGER,
  PRIMARY KEY (id)
);





CREATE TABLE sessoes (
  id INTEGER NOT NULL,
  id_filme INTEGER,
  id_sala INTEGER,
  data DATE,
  hora_incio TIME,
  hora_termino TIME,
  PRIMARY KEY (id)
);





CREATE TABLE usuarios (
  id INTEGER NOT NULL,
  nome_usuario VARCHAR(35) NOT NULL,
  senha_usuario VARCHAR(35) NOT NULL,
  PRIMARY KEY (id)
);





CREATE GENERATOR usuarios_id_gen;





CREATE TRIGGER usuarios_bi FOR usuarios
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.id IS NULL) THEN
  BEGIN
    NEW.id = GEN_ID(usuarios_id_gen, 1);
  END
END;


COMMIT WORK;


