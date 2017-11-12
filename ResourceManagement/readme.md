#### Resource Loader
Carrega qualquer recurso da engine usando uma thread dedicada, ou seja, não
trava o jogo. Útil pra fazer loading screen.

Função `queue_resource(path, priority = false)`: adiciona um recurso pra fila
de recursos a serem carregados. Essa fila é percorrida em ordem, mas o
parâmetro `priority` serve pra adicionar um pedido no início da fila, pausando
qualquer recurso que esteja sendo atendido.

Função `is_ready(path)` retorna se o recurso está pronto ou não, enquanto a
`get_resource(path)` é bloqueante, ou seja, só retorna quando o recurso estiver
pronto.

Existem outras funções definidas pra verificar o progresso dos recursos,
cancelar um recurso da fila, etc. É bom olhar o script pra entender bem.

Esse script foi feito pra ser usado como um [autoload](http://docs.godotengine.org/en/stable/learning/step_by_step/singletons_autoload.html).

#### Resource Pool
