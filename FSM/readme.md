# Finite State Machine
Implementação de uma máquina de estados finita básica.

### Classes
- State
  - Define um estado da FSM. Usa as funções `enter()` e `exit()` para entrar
  e sair do estado, respectivamente. Estados definidos pelo desevolvedor devem
  herdar dessa classe.
  - As funções `can_enter()` e `can_exit()` são usadas para controlar a passagem
  entre estados. Por exemplo, se o estado atual retornar `false` da função
  `can_exit()` no momento em que uma transição for acionada, essa transição não
  será realizada. O mesmo é válido se o próximo estado retornar `false` na
  função `can_enter()` (útil para criar cooldown e outros efeitos).
- FSM
  - Mantém controle dos estados e transições entre eles.
  - Os estados da FSM são inicializados automaticamente se forem filhos do nodo
  FSM, ou podem ser adicionados por código (com a função `add_state(node)`).
  **O primeiro estado encontrado entre os filhos será o estado inicial da FSM.**
  - As transições entre estados devem ser inicializadas por código. Isso pode
  ser feito criando um novo script que estenda a classe FSM, ou por outro nodo
  através da função `add_transition(from, to, key)`. Essa função recebe o
  **nome** dos estados de partida e fim da transição, e uma chave de ativação da
  transição. A chave pode ser qualquer valor, mas é recomendado o uso de strings
  ou contantes, pra manter uma boa legibilidade.
  - Para realizar uma transição, use a função `make_transition(key)`. Essa
  função procura no nodo atual uma transição com a chave especificada e, caso
  essa transição seja encontrada e os estados permitam a transição, chama as
  funções `exit()` no nodo de partida da transição e `enter()` no nodo de fim
  da transição.

### Exemplo
Uma máquina de estados para controlar animações de um `AnimatedSprite`.

Considere a seguinte árvore para uma cena de jogador
- Player (KinematicBody2D)
  - AnimatedSprite (possui todas as animações do player)
  - FSM (estende o script `FSM.gd` para criar as transições entre os estados)
    - idle (toca animação de idle no `AnimatedSprite`; é o estado inicial da FSM)
    - move (toca animação de movimento no `AnimatedSprite`)
    - dash (se o timer não estiver correndo, toca a animação de dash)
      - timer (cooldown, evita que a FSM entre em dash em `can_enter()`)
    - death (.... you get it, right?)

A FSM também pode ser usada para controlar as ações do jogador ou de NPCs,
mas pra isso é recomendado lembrar do
[Command Pattern](http://gameprogrammingpatterns.com/command.html).
