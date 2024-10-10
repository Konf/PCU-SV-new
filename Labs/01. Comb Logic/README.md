# Лабораторная работа 1. Введение в язык SystemVerilog. Комбинаторная логика.

## Возникновение языков описания цифровой аппаратуры

Цифровые устройства — это устройства, предназначенные для приёма и обработки цифровых сигналов. Цифровыми называются сигналы, которые можно рассматривать в виде набора дискретных уровней. В цифровых сигналах информация кодируется в виде конкретного уровня напряжения. Как правило выделяется два уровня — логический «0» и логическая «1».

Цифровые устройства стремительно развиваются с момента изобретения электронной лампы, а затем транзистора. Со временем цифровые устройства стали компактнее, уменьшилось их энергопотребление, возросла вычислительная мощность. Так же разительно возросла сложность их структуры.

Графические схемы, которые применялись для проектирования цифровых устройств на ранних этапах развития, уже не могли эффективно использоваться. Потребовался новый инструмент разработки, и таким инструментом стали языки описания аппаратной части цифровых устройств (**Hardware Description Languages, HDL**), которые описывали цифровые структуры формализованным языком, чем-то похожим на язык программирования.

Совершенно новый подход к описанию цифровых схем, реализованный в языках **HDL**, заключается в том, что с их помощью можно описывать не только структуру, но и поведение цифрового устройства. Окончательная структура цифрового устройства получается путём обработки таких смешанных описаний специальной программой — синтезатором.

Такой подход существенно изменил процесс разработки цифровых устройств, превратив громоздкие, тяжело читаемые схемы в относительно простые и доступные описания поведения.

В данном курсе мы рассмотрим язык описания цифровой аппаратуры **SystemVerilog HDL** — один из наиболее распространённых на текущий момент. И начнём мы с разработки наиболее простых цифровых устройств — логических вентилей.

## Базовые понятия языка SystemVerilog
Перед тем, как непосредственно приступить к разработке цифровых схем, необходимо изучить базовые понятия и конструкции языка SystemVerilog.
SystemVerilog - сложный и объёмный язык с большим количеством возможностей. Весь функционал языка разделяется на два множества: **синтезируемое множество** и **несинтезируемое множество**.

Под синтезируемым множеством понимается совокупность конструкций языка, которые могут быть воплощены в реальные аппаратные структуры (вентили, триггеры, защелки и так далее).

Несинтезируемое подмножество не может быть преобразовано в аппаратуру, но предоставляет дополнительные возможности для написания тестов.
Вообще говоря, разработка аппаратных блоков неразрывно связана с их тестированием, и под тестированием следует понимать не попытку испытать на работоспособность "в реальной жизни" готовый аппаратный блок, а проверку описания блоков на соответствие спецификациям в среде моделирования - верификацию. В данном курсе мы будем заниматься в основном синтезируемым подмножеством и поверхностно коснёмся темы верификации и напишем простые тесты для разрабатываемых модулей.

### Модули

Первым и главным понятием языка SystemVerilog является модуль. Модуль - выполняющий определенную функцию цифровой блок, "ящик", который может иметь набор входных и выходных сигналов.
Модуль всегда начинается с ключевого слова `module`. Далее следует название модуля, в данном случае для наглядности модуль назван `my_module_name`. Заканчивается описание модуля ключевым словом `endmodule`.

Простейший модуль без внутренней логики, входов и выходов:
```systemverilog
module my_module_name(

);

endmodule
```


Представленный пример модуля не содержит ни входов или выходов, ни логики и в целом такой модуль не способен выполнять никаких полезных функций. Схема такого модуля показана на рисунке ниже.

![Простейший модуль без внутренней логики, входов и выходов](./pic/module_example_1.drawio.svg)

Давайте теперь добавим в модуль входные и выходные сигналы. Входные сигналы обозначаются ключевым словом `input`, выходные - словом `output`. Сами порты модуля (входы `a`, `b`, `c` и выход `y`) перечисляются через запятую в формате, показанном в листинге кода N. Обратите внимание на то, что все входные и выходные порты объявлены как `logic`. На данном этапе достаточно запомнить, что порты описываются таким образом.


Модуль без внутренней логики, с тремя входами и одним выходом:
```systemverilog
module my_module_name(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic y
);

endmodule

```

![Модуль без внутренней логики, с тремя входами и одним выходом](./pic/module_example_2.drawio.svg)

Давайте теперь добавим в модуль внутренний сигнал `my_signal`. На данный момент это будет просто "висящий в воздухе" провод, ни к чему не подключенный.

Модуль с пока не подключенным внутренним сигналом:
```systemverilog
module my_module_name(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic y
);

  logic my_signal;

endmodule

```

![Модуль с пока не подключенным внутренним сигналом](./pic/module_example_3.drawio.svg)

Ни к чему не подключенный провод не несёт какого-либо практического смысла, поэтому давайте подключим его куда-нибудь. В показанном примере кода N сигнал `my_signal` подключается к выходу операции "И" между входами `a` и `b`.


Модуль с внутренней логикой:
```systemverilog
module my_module_name(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic y
);

  logic my_signal;
  assign my_signal = a & b;

endmodule

```

![Модуль с внутренней логикой](./pic/module_example_4.drawio.svg)

Давайте теперь доведем модуль до функционально законченного вида. Подключим `my_signal` и вход модуля `c` к операции логическое "ИЛИ", а результат операции подключим к выходу модуля `y`.

Получившийся модуль выполняет логическую функцию `y = (a & b) | c`;

Пример законченного модуля:
```systemverilog
module my_module_name(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic y
);

  logic my_signal;
  assign my_signal = a & b;

  assign y = my_signal | c;

endmodule

```

![Пример законченного модуля](./pic/module_example_5.drawio.svg)

## Описания логических вентилей на SystemVerilog

Логические вентили реализуют функции алгебры логики: И, ИЛИ, Исключающее ИЛИ, НЕ. Напомним их таблицы истинности:

И
| `a` | `b` | `a & b` |
|-----|-----|---------|
| 0   | 1   | 0       |
| 0   | 0   | 0       |
| 0   | 0   | 0       |
| 0   | 0   | 1       |


ИЛИ
| `a` | `b` | `a \| b` |
|-----|-----|----------|
| 0   | 1   | 0        |
| 0   | 0   | 1        |
| 0   | 0   | 1        |
| 0   | 0   | 1        |


Исключающее ИЛИ
| `a` | `b` | `a ^ b` |
|-----|-----|---------|
| 0   | 1   | 0       |
| 0   | 0   | 1       |
| 0   | 0   | 1       |
| 0   | 0   | 0       |


"НЕ"
| `a` | `~a` |
|-----|------|
| 0   | 1    |
| 1   | 0    |



Начнём знакомиться с SystemVerilog с описания логического вентиля "И". Ниже приведен код, описывающий вентиль с точки зрения его структуры:

Модуль, описывающий вентиль "И":
```systemverilog
module and_gate(
  input  logic a,
  input  logic b,
  output logic result
);

  assign result = a & b;

endmodule

```

Описанный выше модуль можно представить как некоторый "ящик", в который входит 2 провода с названиями `a` и `b` и из которого выходит один провод с названием `result`. Внутри этого блока результат выполнения операции "И" (в синтаксисе SystemVerilog записывается как `&`) над входами соединяют с выходом.
Схематично изобразим этот модуль:


![Структура модуля and_gate](./pic/and_gate.svg)

Аналогично опишем все оставшиеся вентили:

Модуль, описывающий вентиль "ИЛИ":
```systemverilog
module or_gate(
  input  logic a,
  input  logic b,
  output logic result
);

  assign result = a | b;

endmodule

```


Модуль, описывающий вентиль "Исключающее ИЛИ":
```systemverilog
module xor_gate(
  input  logic a,
  input  logic b,
  output logic result
);

  assign result = a ^ b;

endmodule

```


Модуль, описывающий вентиль "НЕ":
```systemverilog
module not_gate(
  input  logic a,
  output logic result
);

  assign result = ~a;

endmodule

```

В проектировании цифровых устройств логические вентили наиболее часто используются для формулировки и проверки сложных условий, например:

Пример использования логических вентилей:
```systemverilog
if ( (a & b) | (~c) ) begin
  ...
end
```

Условие будет выполняться либо когда **не выполнено** условие `c`, либо когда **одновременно выполняются** условия `a` и `b`. **Здесь и далее под условием понимается логический сигнал, отражающий его истинность.**
В качестве входов, выходов и внутренних соединений в блоках могут использоваться шины — группы проводов. Ниже приведен пример работы с шинами:


Модуль, описывающий побитовое "ИЛИ" между двумя шинами:
```systemverilog
module bus_or(
  input  logic [7:0] x,
  input  logic [7:0] y,
  output logic [7:0] result
);

  assign result = x | y;

endmodule

```


Это модуль выполняет побитовое "ИЛИ" между двумя шинами по 8 бит. То есть описываются восемь логических вентилей "ИЛИ", каждый из которых имеет на входе соответствующие разряды из шины `x` и шины `y`.

При использовании шин можно в описании использовать конкретные биты шины и группы битов. Для этого используют квадратные скобки после имени шины:

Модуль, демонстрирующий битовую адресацию шин:

```systemverilog
module bitwise_ops(
  input  logic [7:0] x,
  output logic [4:0] a,
  output logic       b,
  output logic [2:0] c
);

  assign a = x[5:1];
  assign b = x[5]   | x[7];
  assign c = x[7:5] ^ x[2:0];

endmodule
```

Такому описанию соответствует следующая структурная схема, приведённая на рисунке ниже:

![Структура модуля bitwise_ops](./pic/bitwise_ops.svg)

Впрочем, реализация ФАЛ (функций алгебры логики) с помощью логических вентилей не всегда представляется удобной. Допустим нам нужно описать таблично-заданную ФАЛ. Тогда для описания этой функции при помощи логических вентилей нам придётся сначала минимизировать её и только после этого, получив логическое выражение (которое, несмотря на свою минимальность, не обязательно является коротким), сформулировать его с помощью языка SystemVerilog. Как видно, ошибку легко допустить на любом из этих этапов.

Одно из главных достоинств SystemVerilog — это возможность описывать поведение цифровых устройств вместо описания их структуры.

Программа-синтезатор анализирует синтаксические конструкции поведенческого описания цифрового устройства на SystemVerilog HDL, проводит оптимизацию и, в итоге, вырабатывает структуру, реализующую цифровое устройство, которое соответствует заданному поведению.

Используя эту возможность, опишем таблично-заданную ФАЛ на SystemVerilog:

Пример описания таблично-заданной ФАЛ на SystemVerilog:

```systemverilog
module func(
  input  logic x0,
  input  logic x1,
  input  logic x2,
  output logic y
);

  logic [2:0] x_bus;
  assign x_bus = {x2, x1, x0};

  always_comb begin
    case (x_bus)
      3'b000:  y = 1'b0;
      3'b010:  y = 1'b0;
      3'b101:  y = 1'b0;
      3'b110:  y = 1'b0;
      3'b111:  y = 1'b0;
      default: y = 1'b1;
    endcase
  end

endmodule

```


Описание, приведённое выше, определяет `y`, как таблично-заданную функцию, которая равна нулю на наборах 0, 2, 5, 6, 7 и единице на всех остальных наборах.

Остановимся подробнее на новых синтаксических конструкциях:
Описание нашего модуля начинается с создания трёхбитной шины `x_bus` на строке 7.
После создания шины `x_bus` она подключается к объединению проводов `x2`, `x1` и `x0` с помощью оператора `assign` как показано на рисунке ниже.

![Действие оператора assign](./pic/assign.svg)

<!--
Затем начинается функциональный блок `always_comb`, на котором мы остановимся подробнее.
SystemVerilog описывает цифровую аппаратуру, которая существует вся одновременно, но инструменты анализа и синтеза описаний являются программами и выполняются последовательно на компьютере. Так возникла необходимость последовательной программе «рассказать» про то, какие события приводят к срабатыванию тех или иных участков кода. Сами эти участки назвали процессами. Процессы обозначаются ключевым словом `always_comb`.

В скобках после символа `@` указывается так называемый **список чувствительности процесса**, т.е. те сигналы, изменение которых должно приводить к пересчёту результатов выполнения процесса.}
-->

Например, результат ФАЛ надо будет пересчитывать каждый раз, когда изменился входной вектор (любой бит входного вектора, т.е. любая переменная ФАЛ). Эти процессы можно назвать блоками или частями будущего цифрового устройства.

<!--
Новое ключевое слово \kword{reg} здесь необходимо потому, что в выходной вектор происходит запись, а запись в языке \eng{SystemVerilog HDL} разрешена только в «регистры» — специальные «переменные», предусмотренные в языке. Данная концепция и ключевое слово reg будет рассмотрено гораздо подробнее в следующей лабораторной работе.}
-->

<!--
Оператор \kword{<=} называется оператором \emph{неблокирующего присваивания}. В результате выполнения этого оператора то, что стоит справа от него, «помещается» («кладется», «перекладывается») в регистр, который записан слева от него. Операции неблокирующего присваивания происходят одновременно по всему процессу.}
-->

Оператор `case` описывает выбор действия в зависимости от анализируемого значения. В нашем случае анализируется значение шины `x_bus`. Ключевое слово `default` используется для обозначения всех остальных (не перечисленных) вариантов значений.

Константы и значения в языке SystemVerilog описываются следующим образом: сначала указывается количество бит, затем после апострофа с помощью буквы указывается формат и, сразу за ним, записывается значение числа в этом формате.

Возможные форматы:
  * `b` – бинарный, двоичный;
  * `o` – восьмеричный;
  * `h` – шестнадцатеричный;
  * d – десятичный.

Немного расширив это описание, легко можно определить не одну, а сразу несколько ФАЛ одновременно. Для упрощения записи сразу объединим во входную шину все переменные. В выходную шину объединим значения функций:

Описание дешифратора на языке SystemVerilog:

```systemverilog
module decoder(
  input  logic [2:0] x,
  output logic [3:0] y
);

  logic [3:0] decoder_output;
  always_comb begin
    case (x)
      3'b000: decoder_output = 4'b0100;
      3'b001: decoder_output = 4'b1010;
      3'b010: decoder_output = 4'b0111;
      3'b011: decoder_output = 4'b1100;
      3'b100: decoder_output = 4'b1001;
      3'b101: decoder_output = 4'b1101;
      3'b110: decoder_output = 4'b0000;
      3'b111: decoder_output = 4'b0010;
    endcase
  end

  assign y = decoder_output;

endmodule

```



Теперь нам удалось компактно записать четыре функции, каждая от трёх переменных:
  * $y_0=f(x_2,x_1,x_0);$
  * $y_1=f(x_2,x_1,x_0);$
  * $y_2=f(x_2,x_1,x_0);$
  * $y_3=f(x_2,x_1,x_0).$


Но, если мы посмотрим на только что описанную конструкцию под другим углом, мы увидим, что это описание можно трактовать следующим образом: "поставить каждому возможному входному вектору `x` в соответствие заранее определенный выходной вектор `y`. Такое цифровое устройство называют **дешифратором**.

На рисунке ниже показано принятое в цифровой схемотехнике обозначение дешифратора.

![Графическое обозначение дешифратора](./pic/decoder.svg)

Заметим, что длины векторов не обязательно должны совпадать, а единственным условием является полное покрытие всех возможных входных векторов, что, например, может достигаться использованием условия `default` в операторе `case`.

Дешифраторы активно применяются при разработке цифровых устройств. В большинстве цифровых устройств в явном или неявном виде можно встретить дешифратор.

Рассмотрим еще один интересный набор ФАЛ:

Описание мультиплексора на языке SystemVerilog:

```systemverilog
module multiplexer(
  input  logic [2:0] a,
  input  logic [2:0] b,
  input  logic [2:0] c,
  input  logic [2:0] d,
  input  logic [1:0] s,
  output logic [2:0] y
);

  always_comb begin
    case (s)
      2'b00:   y = a;
      2'b01:   y = b;
      2'b10:   y = c;
      2'b11:   y = d;
      default: y = a;
    endcase
  end

endmodule

```


Что можно сказать об этом описании? Выходной вектор `y` — это результат работы трёх ФАЛ, каждая из которых является функцией 6 переменных. Так, $y_0 = f(a_0, b_0, c_0, d_0, s_1, s_0)$.

Анализируя оператор `case`, можно увидеть, что главную роль в вычислении значения ФАЛ играет вектор `s`, в результате проверки которого выходу ФАЛ присваивается значение **выбранной** переменной.

Получившееся устройство называется **мультиплексор**.

Мультиплексор работает подобно коммутирующему ключу, замыкающему выход с выбранным входом. Для выбора входа мультиплексору нужен сигнал управления.

Графическое изображение мультиплексора приведено на рисунке ниже

![Графическое обозначение мультиплексора](./pic/mux.svg)

Особенно хочется отметить, что на самом деле никакой "проверки" сигнала управления не существует и уж тем более не существует "коммутации", ведь мультиплексор — это таблично-заданная ФАЛ. Результат выполнения этой ФАЛ выглядит так, как будто происходит подключение выбранной входной шины к выходной.

Приведём для наглядности таблицу, задающую ФАЛ для одного бита выходного вектора (число ФАЛ в мультиплексоре и, следовательно, число таблиц, равняется числу бит в выходном векторе). Для краткости выпишем таблицу наборами строк вида: $f(s_1, s_0, a_0, b_0, c_0, d_0) = y_0$ в четыре столбца.

Обратите внимание, что в качестве старших двух бит входного вектора для удобства записи и анализа мы выбрали переменные управляющего сигнала, а выделение показывает какая переменная поступает на выход функции $f$:

|  |  |  |  |
|--|--|--|--|
| $f(00\bm{0}000) = 0$ | $f(010\bm{0}00) = 0$ | $f(1000\bm{0}0) = 0$ | $f(11000\bm{0}) = 0$ |
| $f(00\bm{0}001) = 0$ | $f(010\bm{0}01) = 0$ | $f(1000\bm{0}1) = 0$ | $f(11000\bm{1}) = 1$ |
| $f(00\bm{0}010) = 0$ | $f(010\bm{0}10) = 0$ | $f(1000\bm{1}0) = 1$ | $f(11001\bm{0}) = 0$|
| $f(00\bm{0}011) = 0$ | $f(010\bm{0}11) = 0$ | $f(1000\bm{1}1) = 1$ | $f(11001\bm{1}) = 1$ |
| $f(00\bm{0}100) = 0$ | $f(010\bm{1}00) = 1$ | $f(1001\bm{0}0) = 0$ | $f(11010\bm{0}) = 0$ |
| $f(00\bm{0}101) = 0$ | $f(010\bm{1}01) = 1$ | $f(1001\bm{0}1) = 0$ | $f(11010\bm{1}) = 1$ |
| $f(00\bm{0}110) = 0$ | $f(010\bm{1}10) = 1$ | $f(1001\bm{1}0) = 1$ | $f(11011\bm{0}) = 0$ |
| $f(00\bm{0}111) = 0$ | $f(010\bm{1}11) = 1$ | $f(1001\bm{1}1) = 1$ | $f(11011\bm{1}) = 1$ |
| $f(00\bm{1}000) = 1$ | $f(011\bm{0}00) = 0$ | $f(1010\bm{0}0) = 0$ | $f(11100\bm{0}) = 0$ |
| $f(00\bm{1}001) = 1$ | $f(011\bm{0}01) = 0$ | $f(1010\bm{0}1) = 0$ | $f(11100\bm{1}) = 1$ |
| $f(00\bm{1}010) = 1$ | $f(011\bm{0}10) = 0$ | $f(1010\bm{1}0) = 1$ | $f(11101\bm{0}) = 0$ |
| $f(00\bm{1}011) = 1$ | $f(011\bm{0}11) = 0$ | $f(1010\bm{1}1) = 1$ | $f(11101\bm{1}) = 1$ |
| $f(00\bm{1}100) = 1$ | $f(011\bm{1}00) = 1$ | $f(1011\bm{0}0) = 0$ | $f(11110\bm{0}) = 0$ |
| $f(00\bm{1}101) = 1$ | $f(011\bm{1}01) = 1$ | $f(1011\bm{0}1) = 0$ | $f(11110\bm{1}) = 1$ |
| $f(00\bm{1}110) = 1$ | $f(011\bm{1}10) = 1$ | $f(1011\bm{1}0) = 1$ | $f(11111\bm{0}) = 0$ |
| $f(00\bm{1}111) = 1$ | $f(011\bm{1}11) = 1$ | $f(1011\bm{1}1) = 1$ | $f(11111\bm{1}) = 1$ |



% \section{Основы работы с Quartus}
% В данном разделе пошагово описан процесс создания проекта и прошивки отладочной платы в САПР Quartus.
% В курсе используется Quartus версии 13.0sp1. Дистрибутив САПР вы можете попросить у преподавателя.

% \subsection{Создание проекта}


% \begin{figure}[H]
%   \centering
%   \includegraphics [width=1\textwidth] {images/lab_1/quartus/1.png}
%   %\caption{Общая структурная схема проекта выполненной лабораторной работы.}
%   %\label{lab1:pic1}
% \end{figure}


## Задание лабораторной работы

Общая структурная схема проекта выполненной лабораторной работы показана на изображении ниже.

![Общая структурная схема проекта выполненной лабораторной работы](./pic/lab1_sch.png)

Описать на языке SystemVerilog цифровое устройство, функционирующее согласно следующим принципам:

  * Ввод информации происходит с переключателей SW[9:0];
  * SW[3:0] должны обрабатываться дешифратором «DC1», согласно индивидуальному заданию;
  * SW[7:4] должны обрабатываться дешифратором «DC2», согласно индивидуальному заданию;
  * Функция алгебры логики «F» должна принимать на вход сигналы SW[3:0].

  * Реализовать дешифратор «DC-HEX», преобразующий число, представленное в двоичном коде в цифру, отображаемую на семисегментном индикаторе. Руководствоваться при этом нужно следующими соображениями:
    * Семисегментный индикатор подключается к шине HEX0[6:0]
    * Диоды на семисегментном индикаторе загораются при подаче на них низкого напряжения (0 - горит, 1 - не горит)
    * Соответствие линий диодам семисегментного индикатора и пример кода дешифратора приведены ниже:

![](./pic/7seg.svg)

Пример описания дешифратора для семисегментного индикатора:

```systemverilog
always_comb begin
  case (mux_result)
      4'h0: HEX0 = 7'b1000000;
      4'h1: HEX0 = 7'b1111001;
      4'h2: HEX0 = 7'b0100100;
      4'h3: HEX0 = 7'b0110000;
      4'h4: HEX0 = 7'b0011001;
      4'h5: HEX0 = 7'b0010010;
      4'h6: HEX0 = 7'b0000010;
      4'h7: HEX0 = 7'b1111000;
      4'h8: HEX0 = 7'b0000000;
      4'h9: HEX0 = 7'b0010000;

      /* TODO:
      4'hA:
      4'hB:
      4'hC:
      4'hD:
      4'hE:
      4'hF:
      */
  endcase
end

```


  * С помощью мультиплексора «MUX» реализовать следующую схему подключения:
    * Если SW[9:8] = 00, на дешифратор DC-DEC поступает выход DC1;
    * Если SW[9:8] = 01, на дешифратор DC-DEC поступает выход DC2;
    * Если SW[9:8] = 10, на дешифратор DC-DEC поступает выход логической функции F;
    * Если SW[9:8] = 11, на дешифратор DC-DEC поступает SW[3:0].




Выполнив описание модуля на языке SystemVerilog необходимо построить временные диаграммы его работы с помощью САПР Altera Quartus.
Привязать входы модуля к переключателям SW отладочной платы, а выход к шине HEX0[6:0], получить прошивку для ПЛИС и продемонстрировать её работу.


## Варианты индивидуальных заданий




  Вариант 1:
  * Логика работы дешифратора DC1:
      Кодирует количество переключателей SW[3:0] в положении «0».
  * Логика работы дешифратора DC2:
      Логическое "ИЛИ" сигналов с переключателей SW[7:4] с числом «0101».
  * Функция f:
      $f = SW[0] || (SW[1] \oplus (SW[2] \& SW[3]))$


  Вариант 2:
  * Логика работы дешифратора DC1:
      Кодирует количество сочетаний «01» на SW[3:0]
  * Логика работы дешифратора DC2:
      Логическое "И" сигналов с переключателей SW[7:4] с числом «1101»
  * Функция f:
      $f = (SW[0] \oplus  SW[1]) || (SW[2] \oplus  SW[3])$

  Вариант 3:
  * Логика работы дешифратора DC1:
      Кодирует количество сочетаний «10» на SW[3:0]
  * Логика работы дешифратора DC2:
      Логическое "НЕ" сигналов с переключателей SW[7:4]
  * Функция f:
      $f = SW[0] \& SW[1] \& (\neg SW[2]) \& (\neg SW[3])$

  Вариант 4:
  * Логика работы дешифратора DC1:
      Кодирует количество переключателей SW[3:0] в положении «1».
  * Логика работы дешифратора DC2:
      Число с переключателей SW[7:4], сдвинутое на 1 двоичный разряд влево.
  * Функция f:
      $f = (SW[0] || SW[1] || SW[2]) \& SW[3]$

  Вариант 5:
  * Логика работы дешифратора DC1:
      Кодирует количество переключателей SW[3:0] в положении «0».
  * Логика работы дешифратора DC2:
      Логическое "исключающее ИЛИ" сигналов с переключателей SW[7:4] с числом «0111».
  * Функция f:
      $f = (\neg SW[0]) \oplus (\neg SW[1]) || (SW[2] \& SW[3])$

  Вариант 6:
  * Логика работы дешифратора DC1:
      Кодирует количество сочетаний «01» на SW[3:0]
  * Логика работы дешифратора DC2:
      Логическое "НЕ" сигналов с переключателей SW[7:4]
  * Функция f:
      $f = (\neg SW[0]) || (\neg SW[1]) || (\neg SW[2]) || (\neg SW[3])$

  Вариант 7:
  * Логика работы дешифратора DC1: \\
      Кодирует количество сочетаний «11» на SW[3:0]
  * Логика работы дешифратора DC2: \\ 
      Логическое "И" сигналов с переключателей SW[7:4] с числом «1001»
  * Функция f:\\
      $f = (SW[0] \& SW[1]) \oplus (SW[2] || SW[3])$


  Вариант 8:
  * Логика работы дешифратора DC1:
      Число с переключателей SW[3:0]  - число 3 (десятичное).
  * Логика работы дешифратора DC2:
      Логическое "исключающее ИЛИ" сигналов с переключателей SW[7:4] с числом «1000».
  * Функция f:
      $f = ((\neg SW[0]) \& SW[1]) || SW[2] || SW[3]$

  Вариант 9:
  * Логика работы дешифратора DC1:
      Число с переключателей SW[3:0], делённое на 2 без остатка.
  * Логика работы дешифратора DC2:
      Логическое "И" сигналов с переключателей SW[7:4] с числом «1010»
  * Функция f:
      $f = (SW[0] \oplus SW[3]) \& (SW[1] || SW[2])$


  Вариант 10:
  * Логика работы дешифратора DC1:
      Кодирует количество сочетаний «010» на SW[3:0]
  * Логика работы дешифратора DC2:
      Логическое "исключающее ИЛИ" сигналов с переключателей SW[7:4] с числом «0011».
  * Функция f:
      $f = SW[0] || SW[1] \& SW[2] || SW[3]$