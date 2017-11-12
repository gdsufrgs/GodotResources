### Misc
Coisas variadas que devem ajudar em algum caso.

- Debug Panel
  - Cena ridiculamente simples pra printar informações na tela do jogo.
  - Carrega a cena como [autoload](http://docs.godotengine.org/en/stable/learning/step_by_step/singletons_autoload.html)
  pra facilitar o acesso de qualquer script.
    - Exemplo de uso: `get_node("/root/debug").print_line("debuguinho")`
  - Função `print_line(string)` adiciona uma linha no topo do painel de debug,
  empurrando mensagens anteriores pra baixo. A cena pode ser customizada para
  comportar mais ou menos linhas de cada vez (atualmente, mostra 10 linhas).
