# Assistente Lógico Pessoal

Avaliação 3 · Linguagem de Programação e Paradigmas · Sistemas de Informação · UNIDAVI · 2026/2

Base de conhecimento em **Prolog** (`meus_dados.pl`) com meus dados de rotina e gostos, consultada por um assistente em **Python** (`assistente.py`) por meio da ponte `prolog.py`.

## Arquivos

| Arquivo | O que faz |
|---|---|
| `meus_dados.pl` | Fatos (`eu`, `cursa`, `compromisso`, `sabe`, `gosta`) e regras R1 a R6 |
| `prolog.py` | Ponte: executa o `swipl`, envia a consulta e devolve uma lista de dicionários |
| `teste_ponte.py` | Confere se o Python conversa com o Prolog |
| `assistente.py` | Menu no terminal com 8 opções, cada uma é uma consulta à base |

## Como executar

Pré-requisitos: [SWI-Prolog](https://www.swi-prolog.org/download/stable) e Python 3 no PATH (nenhuma biblioteca extra).

```bash
swipl --version
python --version

# testar a base direto no Prolog
swipl meus_dados.pl

# testar a ponte
python teste_ponte.py

# rodar o assistente
python assistente.py
```

No Linux/Mac, use `python3`. No Windows, se os acentos aparecerem estranhos, rode `chcp 65001` antes.

## Minha regra (R6): `maratona/2`

```prolog
maratona(Dia, Serie) :- dia(Dia), livre(Dia, noite), gosta(serie, Serie).
```

Num dia em que a minha **noite está livre**, posso maratonar uma **série de que gosto**. A regra tem três subobjetivos: `dia/1` gera os dias da semana, `livre/2` reaproveita a R2 (negação por falha) para conferir a noite, e `gosta/2` busca as séries. É usada na opção 8 do menu.

## Saída real

```
=== Assistente pessoal de joao_vitor_vergilio ===
1. Minhas disciplinas
2. Agenda de um dia
3. Horários livres
4. Estou livre em...?
5. Linguagens que posso ensinar
6. Meus gostos por categoria
7. Dias cheios
8. Minha regra: maratona de série
0. Sair
> 2
Qual dia? (segunda, terca, quarta, quinta, sexta, sabado): segunda

== Agenda de segunda ==
   - noite: redes_de_computadores
   - manha: academia
   - manha: trabalho

> 4
Dia: terca
Turno (manha, tarde, noite): noite

Sim! terca de noite está livre.

> 4
Dia: Seg unda!
Ops: Digite só letras minúsculas, números e _ (sem acento).

> 5

== Linguagens que posso ensinar ==
   - PYTHON

> 8

== Noites livres para maratonar ==
   - terca à noite: lupin
   - terca à noite: la casa de papel
   - sabado à noite: lupin
   - sabado à noite: la casa de papel

> 0
Até mais!
```
