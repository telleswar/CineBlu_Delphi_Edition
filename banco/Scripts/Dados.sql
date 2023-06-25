INSERT INTO filmes (id, titulo, ano_lanc, classificacao, categorias) VALUES (0, 'Doutor Estranho no Multiverso da Loucura\n', 2022, '+14', 'Ação, Aventura, Suspense, Fantasia, Magia');
INSERT INTO filmes (id, titulo, ano_lanc, classificacao, categorias) VALUES (1, 'Homem-Aranha: Sem Volta para Casa\n', 2022, '+12', 'Ação, Aventura, Fantasia, Magia');
INSERT INTO filmes (id, titulo, ano_lanc, classificacao, categorias) VALUES (2, 'The Batman', 2022, '+14', 'Ação, Aventura');





INSERT INTO salas (id, nome_sala, fileiras, cadeiras) VALUES (1, 'Sala A', 5, 8);
INSERT INTO salas (id, nome_sala, fileiras, cadeiras) VALUES (2, 'Sala B', 5, 8);
INSERT INTO salas (id, nome_sala, fileiras, cadeiras) VALUES (3, 'Sala C', 5, 8);





INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (5, 0, 1, '2022-06-28', '10:30:00', '12:30:00');
INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (6, 0, 2, '2022-06-28', '17:30:00', '18:30:00');
INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (7, 1, 1, '2022-06-28', '13:30:00', '14:30:00');
INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (8, 1, 2, '2022-06-28', '19:30:00', '12:30:00');
INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (9, 2, 1, '2022-06-28', '10:15:00', '12:15:00');
INSERT INTO sessoes (id, id_filme, id_sala, data, hora_incio, hora_termino) VALUES (10, 2, 2, '2022-06-28', '17:15:00', '18:15:00');





INSERT INTO usuarios (id, nome_usuario, senha_usuario) VALUES (1, 'antony', '123');

COMMIT WORK;

