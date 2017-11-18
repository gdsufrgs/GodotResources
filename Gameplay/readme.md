#### Attribute
Objeto que controla os limites de um valor único. Atualmente só lida com valores
positivos. Oferece suporte a modificadores em bonus ou porcentagem.

**Útil para:**
- HP
- Atributos de RPG (velocidade, ataque, ataque mágico, ...)

**Variáveis exportadas**
- `base`: valor "raw" do atributo
- `max_base`: valor máximo que a variável `base` pode assumir
- `bonus`: valor somado à `base` para calcular o valor final do atributo
- `mult`: multiplicador aplicado a `base` para calcular o valor final do atributo
- `max_value`: valor máximo do atributo, incluindo `bonus` e `mult`

As variáveis `bonus` e `mult` são usadas para criar mudanças temporárias no
valor de um atributo, como buffs e debuffs.

*Exemplo:*
- Item que aumenta a velocidade do usuário em 20% por 5 minutos - pode ser
implementado apenas modificando a variável `mult` para 1.2 (ou, mais
precisamente, `speed.mult += 0.2` pra permitir efeitos concorrentes).

**Sinais**
- `changed_value`: emitido quando o valor real do atributo é alterado (ie,
quando `base`, `bonus` ou `mult` são alterados, ou quando `max_value` é alterada
e o valor atual de `base * mult + bonus` era maior do que o `max_value` anterior).
- `changed_max`: emitido quando a variável `max_value` é alterada
