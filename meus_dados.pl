:- encoding(utf8).
% meus_dados.pl · Base de conhecimento do Assistente Lógico Pessoal
% Átomos em minúsculas, sem acento e sem espaço. Toda linha termina com ponto.

:- discontiguous gosta/2.

% ---------- Dias e turnos (usados pelas regras) ----------
dia(segunda).
dia(terca).
dia(quarta).
dia(quinta).
dia(sexta).
dia(sabado).

turno(manha).
turno(tarde).
turno(noite).

% ---------- Quem sou eu ----------
eu(joao_vitor_vergilio).

% ---------- cursa(Disciplina, Dia, Turno) ----------
cursa(redes_de_computadores, segunda, noite).
cursa(lpp, quarta, noite).
cursa(programacao_web_1, quinta, noite).
cursa(estrutura_de_dados_2, sexta, noite).

% ---------- compromisso(Dia, Turno, Atividade) ----------
% (as aulas já estão em cursa/3, por isso não se repetem aqui)
compromisso(segunda, manha, academia).
compromisso(segunda, manha, trabalho).
compromisso(terca, manha, trabalho).
compromisso(terca, manha, academia).
compromisso(quarta, manha, trabalho).
compromisso(quinta, manha, academia).
compromisso(quinta, manha, trabalho).
compromisso(sexta, manha, trabalho).
compromisso(sabado, manha, trabalho).

% ---------- sabe(Linguagem, Nivel) ----------
sabe(python, intermediario).
sabe(php, basico).
sabe(javascript, basico).
sabe(csharp, basico).
sabe(sql, basico).

% ---------- gosta(Categoria, Item) ----------
gosta(hobby, carros).
gosta(hobby, jogar_videogame).
gosta(comida, churrasco).
gosta(comida, pizza).
gosta(serie, lupin).
gosta(serie, la_casa_de_papel).
gosta(musica, funk).

% =================== REGRAS ===================

% R1 · Estou ocupado se tenho aula OU compromisso (duas cláusulas = OU)
ocupado(Dia, Turno) :- cursa(_, Dia, Turno).
ocupado(Dia, Turno) :- compromisso(Dia, Turno, _).

% R2 · Estou livre se NÃO for possível provar que estou ocupado
livre(Dia, Turno) :- dia(Dia), turno(Turno), \+ ocupado(Dia, Turno).

% R3 · O que faço em um dia e turno (aula ou compromisso)
o_que_faco(Dia, Turno, Atividade) :- cursa(Atividade, Dia, Turno).
o_que_faco(Dia, Turno, Atividade) :- compromisso(Dia, Turno, Atividade).

% R4 · Posso ensinar uma linguagem se sei em nível intermediário ou avançado
pode_ensinar(Linguagem) :- sabe(Linguagem, Nivel), member(Nivel, [intermediario, avancado]).

% R5 · Dia cheio: dois turnos ou mais ocupados
dia_cheio(Dia) :- dia(Dia), findall(T, ocupado(Dia, T), Ts), sort(Ts, Unicos), length(Unicos, N), N >= 2.

% R6 · MINHA REGRA: maratona de série.
% Num dia em que a minha noite está livre, posso maratonar uma série de que gosto.
% Subobjetivos: o dia existe, a noite desse dia está livre (usa a R2) e eu gosto da série.
maratona(Dia, Serie) :- dia(Dia), livre(Dia, noite), gosta(serie, Serie).
