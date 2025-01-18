#set text(
  font: "Times New Roman",
  size: 14pt,
  lang: "ru"
)
#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 1.5cm),
  numbering: "1",
  number-align: right,
)
#set par(
  justify: true,
  first-line-indent: 1.25cm,
)

// Leading fix
#let leading = 1.5em
#let leading = leading - 0.75em // "Normalization"
#set block(spacing: leading)
#set par(spacing: leading)
#set par(leading: leading)

// Обтекание текста фигурами
#import "@preview/wrap-it:0.1.0": wrap-content
// Диаграммы
#import "@preview/cetz:0.3.1"
// Отступы на первой строчке
#import "@preview/indenta:0.0.3": fix-indent
// Физические формулы
#import "@preview/physica:0.9.4": *

#align(center)[
  #text(17pt)[*Билеты для экзамена по*] \
  #text(20pt)[  *_Тепломассообмену_*]
]\

#grid(
  columns: (1fr, 1fr),
  align(center)[
    #figure(
      cetz.canvas({
        import cetz.draw: *

        scale(6)

        circle((0,0), name: "circle", radius: .2,stroke:none)
        content((name:"circle", anchor:   0deg), angle:-240deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
        content((name:"circle", anchor:  60deg), angle:-180deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
        content((name:"circle", anchor: 120deg), angle:-120deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
        content((name:"circle", anchor: 180deg), angle: -60deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
        content((name:"circle", anchor: 240deg), angle:   0deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
        content((name:"circle", anchor: 300deg), angle:  60deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
        content((0,-0.02), emph(text(fill:red,size:28pt)[#sym.integral.cont]))
      })
    ) <LOGO>
  ],
  [
    _Преподаватель_: \
    *Сапожников Сергей Захарович* \
    \
    _Автор конспекта_: \
    *Дмитриев Артем Константинович* \
    #link("mailto:artem020503@gmail.com")
  ]
)

// Custom outline
#let fakenumber = counter("mycounter")
#show outline.entry: it => {
  let loc = it.element.location()
  set text(hyphenate: false)
  set block(spacing: 1pt)
  fakenumber.step()
  grid(
    columns: (1fr,16fr,1fr),
    align: (right,left, bottom),
    context fakenumber.display() + ".  ",
    box([#link(loc)[#it.body] #box(width:1fr, repeat[.])]),
    [#box(width: 1fr, repeat[.]) #it.page]
  )
}

#show outline: it => {
  show heading: set align(center)
  show heading: set text(14pt)
  show heading: set block(above: 1.4em, below: 1em)
  it
}
#outline(
  title: "СОДЕРЖАНИЕ",
  indent: auto
)

#counter(heading).step()
#show heading: it => [
  #pagebreak(weak:true)
  #set text(14pt, hyphenate:false)
  #set block(above: 1.4em, below: 1em)
  #counter(heading).step()
  #grid(
    columns: (1fr,10fr),
    text(2em)[#counter(heading).display()],
    box(stroke:black, outset:.5em, radius:1em, it.body)
  )
  \
]

// #set enum(indent: 1.25cm)
#set math.equation(numbering: "(1)")

#show: fix-indent() // Отступ первой строки

= Теплопередача, её виды. Природа теплопроводности газов, жидкостей и твердых сред. Поле температуры. Изотермические поверхности и изотермы. Градиент температуры. Тепловой поток и его плотность.

_Теплопередача_ -- процесс передачи тепловой энергии от более нагретого тела к менее нагретому.

+ Теплопроводность -- молекулярный перенос тепла в твёрдой среде на уровне микрочастиц.
+ Конвекция -- перенос тепла посредством движения микрочастиц объёа вещества.
+ Теплообмен излучением -- передача энергии в виде электромагнитных волн.
\

Природа теплопроводности в разных средах:
- В газах диффузия происходит путём переноса атомов и молекул;
- В жидкостях и неметаллических твёрдых веществах тепло передаётся упругими волнами;
- В металлах -- электронный газ.
\

_Поле температуры_ -- совокупность значений температуры в разных точках пространства.

_Изотермическая поверхность_ -- геометрическое место точек с одинаковой температурой.

_Изотерма_ -- линия (сечение), образованная пересечением секущей плоскости и изотермической поверхности.

Градиент температуры:
$ grad T = overline(e)_x pdv(T,x) + overline(e)_y pdv(T,y) + overline(e)_z pdv(T,y) => overline(n) pdv(T,n) $

Тепловой поток:\
$Q$ -- количество теплоты прошедшее через поверхность за единицу времени:
$ Q=dv(Q_r,r), "  "[Q]="Вт"; $
$q$ -- плотность теплового потока. Тепловой поток через единичную поверхность:
$ q=dv(Q,F), "  " [q]="Вт"/"м"^2; $

= Гипотеза Био. Интегральный закон Фурье. Теплопроводность сред и материалов. Дифференциальное уравнение теплопроводности (Фурье). Температуропроводность среды. Краевые условия. Граничные условия 1-4 рода, их физический смысл и формулировка. Краевая задача теплопроводности.

_Гипотеза Био_ --\
Количество теплоты, прошедшее через изотермическую поверхность в сторону убывания температуры, пропорционально $dd(r)$, $dd(F)$ и $difference(T)$ и обратно пропорционально $difference(n)$:
$ dd(Q_r,2) = -lambda difference(T)/difference(n) dd(F) dd(r); $

Интегральный закон Фурье:
- При $difference(n)->0$:
  $ pdv(Q_r, F, r) = -lambda pdv(T, n) = -lambda grad T = q => q = -lambda grad T; $

\

Теплопроводность ($lambda$) --\
Плотность теплового потока при еденичной разнице температур. $[lambda]= "Вт"/("м"dot"к")$
$ "Газы":& 0.006 dots 0.6\
  "Жидкости":& 0.07 dots 0.7\
  "Неметаллы":& 0.04 dots 10\
  "Металлы":& 8 dots 425
$
\

*Дифференциальное уравнение теплопроводности*:

\

#grid(
  columns:(1fr,3fr),
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line((0,0),(0,5),(2,5),(2,0),close: true)
      line((0,5),(2,7),(4,7),(4,2),(2,0))
      line((2,5),(4,7))

      line(name:"Delta",(2.5,2),(2.5,4),(3.5,5),(3.5,3),close:true)
      content("Delta.centroid", $Delta$)

      line(name:"qx",(-0.5,3),(.5,3), mark:(end: "stealth"))
      line(name:"qx+dx",(3,3),(4.5,3), mark:(end: "stealth"))
      line(name:"dx",(0,1),(2,1), mark:(symbol: "stealth"))

      content("qx.mid",box($q(x)$,outset:3pt,fill:white), anchor:"south", padding: 0.2)
      content("qx+dx.mid",box($q(x+d x)$,outset:4pt,fill:white), anchor:"north", padding: 0.2)
      content("dx.mid",$Delta x$, anchor:"north", padding: 0.2)

    })
  ),
  [
    Рассмотрим пластину.\
    $[q_v]="Вт"/"м"^3$ -- плотность внутренних источников тепла;\
    $[C]="Дж"/"кг"$ -- удельная теплоёмкость.

    \

    Уравнение теплового баланса:
    #math.equation(block: true, numbering: none)[$-lambda F pdv(T(x),x) &+ q_v F difference(x)= \ &= -lambda F pdv(T(x+difference(x)),x) + rho F c difference(x) pdv(T,r);$]

    #math.equation(block: true, numbering: none)[$lambda (pdv(T(x+difference(x)),x) - pdv(T(x),x))/difference(x) + q_v = rho c pdv(T,r) op(arrow, limits:#true)_(difference(x) arrow 0) lambda pdv(T,x,2) + q_v = rho c pdv(T,r) "     "$]
  ]
)

\

Учитывая, что температуропроводность:
$ alpha = lambda/(rho c), "  " [alpha] = "м"^2/"с", $

Дифференциальное уравнение теплопроводности можно записать так:

$ pdv(T,r) = alpha pdv(T,x,2) + q_v/(rho c) $

$ pdv(T,r) = alpha grad^2 T + q_v/(rho c) $

Краевые условия:\
Для нахождения единственного решения дифференциального уравнения теплопроводности необдимы краевые условия:
+ Граничные условия
+ Начальные условия
+ Сведения о форме и размерах тела
+ Сведения о тепловых свойствах тела ($lambda,rho,c$)
\

Граничные условия:
+ Первого рода:\
  Задают $T$ на поверхности тела:
  $ T(Gamma, r) = T_Gamma (Gamma, r); $

  #align(right)[#emph(text(blue)[Пример]): кипение и конденсация.]

+ Второго рода:\
  Плотность теплового потока:
  $ -lambda (pdv(T,n))_Gamma = q_Gamma (Gamma,r) $

  #align(right)[#emph(text(blue)[Пример]): нагрев при течении тока.]

+ Третьего рода:\
  Пропорциональность теплового потока разности температур:
  $ -lambda (pdv(T,n))_Gamma = alpha(T_f-T_Gamma) $

  #align(right)[#emph(text(blue)[Пример]): конвективный теплообмен.]

+ Четвёртого рода:\
  Идеальный тепловой контакт:
  $ -lambda_1 (pdv(T,n))_(Gamma-0) = -lambda_2 (pdv(T,n))_(Gamma+0) $

  #align(right)[#emph(text(blue)[Пример]): контакт резца с деталью.]


= Канонические тела. Стационарная теплопроводность неограниченной пластины при граничных условиях 1 и 3 рода. Составная пластина. Коэффициент теплопередачи. Термические сопротивления.
Теплопроводность неограниченной пластины при г/у 1 и 3-го рода:

\

*Первого рода*:

#grid(
  columns:(1fr,3fr),
  gutter:3em,
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"y",( 0,0),(0,5), mark:(end: "stealth"))
      line(name:"x",( 0,0),(3,0), mark:(end: "stealth"))
      line(name:"q",(-1,2),(0,2), mark:(end: "stealth"))

      content("y.end",   $T$, anchor:"east" , padding: 0.2)
      content("x.end",   $x$, anchor:"north", padding: 0.2)
      content("q.start", $q$, anchor:"south", padding: 0.2)

      line((2,0),(2,4))
      line(name:"line",(0,4),(2,2),stroke:red)
      content("line.end",   $T_W_2$, anchor:"west", padding: 0.2)
      content("line.start", $T_W_1$, anchor:"east", padding: 0.2)
    })
  ),
  [
    #block( math.equation(block: true, numbering: none)[$ cases(
      dv(T,x,2)=0,
      T|_(x=0)=T_W_1,
      T|_(x=delta)=T_W_2,
    ) $] )

    #block( math.equation(block: true, numbering: none)[$ dv(T,x,2) => T=C_1 x + C_2; x=0 &=> T=T_W_1=C_2 \ x=delta &=> T=T_W_2 = C_2 delta + T_W_1 => \ &=> C_2 = (T_W_2-T_W_1)/delta $])
  ]
)

#math.equation(block: true, numbering: none)[$ T= (T_W_2-T_W_1)/delta x + T_W_1 = T_W_1 - ((T_W_1-T_W_2)/delta)x $]

$ q=-lambda pdv(T,x) = lambda (T_W_1-T_W_2)/delta $

*Третьего рода* (пластина в воде):

#grid(
  columns:(1fr,3fr),
  gutter: 3em,
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"y",( 0,0),(  0 ,5), mark:(end: "stealth"))
      line(name:"x",( 0,0),(  3 ,0), mark:(end: "stealth"))
      line(name:"q",(-1,1),(-.25,1), mark:(end: "stealth"))

      content("y.end",   $T$, anchor:"east" , padding: 0.2)
      content("x.end",   $x$, anchor:"north", padding: 0.2)
      content("q.start", $q$, anchor:"north", padding: 0.2)

      line((2,0),(2,4))
      line(name:"line",(0,4),(2,2),stroke:red)
      content("line.end",   $T_W_2$, anchor:"north-east", padding: 0.2)
      content("line.start", $T_W_1$, anchor:"south-west", padding: 0.2)

      content((-.5, 2 ), text(blue)[#sym.arrow.r.squiggly])
      content((2.5, 1 ), text(blue)[#sym.arrow.r.squiggly])
      content((-.4,1.7), text(blue)[#$alpha_1$])
      content((2.6,0.7), text(blue)[#$alpha_2$])

      hobby(name:"a2",(2,2),(2.4,1.6),( 3,1.5),stroke:red)
      hobby(name:"a1",(0,4),(-.4,4.4),(-1,4.5),stroke:red)
      content("a1.end", $T_f_1$, anchor:"east")
      content("a2.end", $T_f_2$, anchor:"west")
    })
  ),
  [
    $q= "const"$ внутри пластины

    #set math.cases(reverse: true)
    #block(math.equation(block: true, numbering: none)[$ cases(
      q = alpha_1 (T_f_1 - T_W_1),
      q = lambda/delta (T_W_1 - T_W_2),
      q = alpha_2 (T_w_2 - T_f_2)
    ) => $])

    #block($ &=> q (1/alpha_1 + delta/lambda + 1/alpha_1)=T_f_1 - T_f_2 => \
      &=> q = (T_f_1 - T_f_2)/(1/alpha_1 + delta/lambda + 1/alpha_1) $)
  ]
)

#pagebreak()
*Теплопроводность составной пластины*:

#grid(
  columns:(1.5fr,1fr),
  gutter:3em,
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"y",( 0,0),(0,5), mark:(end: "stealth"))
      line(name:"x",( 0,0),(8,0), mark:(end: "stealth"))
      line(name:"q",(-1,2),(0,2), mark:(end: "stealth"))

      content("y.end",   $T$, anchor:"east" , padding: 0.2)
      content("x.end",   $x$, anchor:"north", padding: 0.2)
      content("q.start", $q$, anchor:"south", padding: 0.2)

      line((2,0),(2,4))
      line(name:"line1",(0,4),(2,3),stroke:red)
      content("line1.end",   $T_W_2$, anchor:"south-west", padding: 0.2)
      content("line1.start", $T_W_1$, anchor:"east", padding: 0.2)

      line((4,0),(4,4))
      line(name:"line2",(2,3),(4,2.5),stroke:red)
      content("line2.end",   $T_W_3$, anchor:"north-east", padding: 0.2)

      line((5,0),(5,4))
      line((7,0),(7,4))
      line(name:"line3",(5,2),(7,1),stroke:red)
      content("line3.end",   $T_W_(n+1)$, anchor:"north-west", padding: 0.2)
      content("line3.start", $T_W_n$, anchor:"south-west", padding: 0.2)
      content((1,.5),$lambda_1$)
      content((3,.5),$lambda_2$)
      content((6,.5),$lambda_n$)
    })
  ),
  [
    #block( math.equation(block: true, numbering: none)[$q="const"$])
    #block( math.equation(block: true, numbering: none)[$ cases(
      q = lambda_1/delta_1 (T_W_1-T_W_2),
      q = lambda_2/delta_2 (T_W_2-T_W_3),
      dots " " dots " " dots " " dots " " dots " " dots " " dots " " dots,
      q = lambda_n/delta_n (T_W_n-T_W_(n+1))
    ) $] )
  ]
)
#set math.cases(reverse: true)
#block( math.equation(block: true, numbering: none)[$ cases(
  T_W_1-T_W_2 = q delta_1/lambda_1,
  T_W_2-T_W_3 = q delta_2/lambda_2,
  dots " " dots " " dots " " dots " " dots " " dots " " dots " " dots,
  T_W_n-T_W_(n+1) = q delta_n/lambda_n
) => q = (T_W_1 - T_W_(n+1)/(delta_1/lambda_1 + delta_2/lambda_2 + dots + delta_n/lambda_n)= (T_W_1-T_W_(n+1))/(sum_i delta_i/lambda_i) $] )

При граничных условиях 3-го рода (в воде):

#grid(
  columns:(1.5fr,1fr),
  gutter:3em,
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"y",( 0,0),(0,5), mark:(end: "stealth"))
      line(name:"x",( 0,0),(8,0), mark:(end: "stealth"))
      line(name:"q",(-1,2),(0,2), mark:(end: "stealth"))

      content("y.end",   $T$, anchor:"east" , padding: 0.2)
      content("x.end",   $x$, anchor:"north", padding: 0.2)
      content("q.start", $q$, anchor:"south", padding: 0.2)

      line((2,0),(2,4))
      line(name:"line1",(0,4),(2,3),stroke:red)
      content("line1.end",   $T_W_2$, anchor:"south-west", padding: 0.2)
      content("line1.start", $T_W_1$, anchor:"south-west", padding: 0.2)

      line((4,0),(4,4))
      line(name:"line2",(2,3),(4,2.5),stroke:red)
      content("line2.end",   $T_W_3$, anchor:"north-east", padding: 0.2)

      line((5,0),(5,4))
      line((7,0),(7,4))
      line(name:"line3",(5,2),(7,1),stroke:red)
      content("line3.end",   $T_W_(n+1)$, anchor:"south-west", padding: 0.2)
      content("line3.start", $T_W_n$, anchor:"south-west", padding: 0.2)

      content((1,.5),$lambda_1$)
      content((3,.5),$lambda_2$)
      content((6,.5),$lambda_n$)

      hobby(name:"a2",(7,1),(7.4, .6),( 8, .5),stroke:red)
      hobby(name:"a1",(0,4),(-.4,4.4),(-1,4.5),stroke:red)
      content("a1.end", $T_f_1$, anchor:"east")
      content("a2.end", $T_f_2$, anchor:"west")

      content((-.5, 1 ), text(blue)[#sym.arrow.r.squiggly])
      content((7.5, 3 ), text(blue)[#sym.arrow.r.squiggly])
      content((-.4, .7), text(blue)[#$alpha_1$])
      content((7.6,2.7), text(blue)[#$alpha_(n+1)$])
    })
  ),
  block(  math.equation(block: true, numbering: none)[ \ $ cases(
    q = alpha_1 (T_f_1-T_W_1),
    q = lambda_1/delta_1 (T_W_1-T_W_2),
    q = lambda_2/delta_2 (T_W_2-T_W_3),
    dots " " dots " " dots " " dots " " dots " " dots " " dots " " dots,
    q = lambda_n/delta_n (T_W_n-T_W_(n+1)),
    q = alpha_(n+1) (T_W_(n+1)-T_f_(n+1))
  ) => $])
)

$ => q = (T_f_1-T_f_(n+1))/(1/alpha_1 + sum_i delta_i/lambda_i + 1/alpha_(n+1)) $
#text("         ") Термическое сопротивление:
- $R_lambda = delta/lambda$ - внутреннее термическое сопротивление (слоя),
- $R_alpha = 1/alpha$ - внешнее термичское сопротивление (среды),
- $R_k=1/alpha_1 + sum_i delta_i/lambda_i + 1/alpha_(n+1)$ - термическое сопротивление комплекса.

\

_Коэффициент теплопередачи_ $K$ - величина, показывающая плотность теплового потока при единичной разности температур жидкостей, омывающих стенки.
$ K = 1/(1/alpha_1 + sum_i delta_i/lambda_i + 1/alpha_(n+1)) $
#set math.cases(reverse: false)

= Теплопроводность цилиндрической стенки при граничных условиях 1 и 3 рода. Линейный коэффициент теплопередачи.Составная цилиндрическая стенка. Задача о критическом диаметре цилиндрической стенки.

#grid(
  columns:(1fr,3fr),
  gutter: 3em,
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(( 0 ,-1),( 0 ,5),stroke:(dash:"dashed", paint:gray))
      line(( 0 , 0),( 3 ,0),stroke:(dash:"dashed", paint:gray))
      line(( 0 , 4),( 3 ,4),stroke:(dash:"dashed", paint:gray))
      line((2.5,-1),(2.5,5),stroke:(dash:"dashed", paint:gray))

      line(name:"r1",(0, 2 ),( 2 , 2 ), mark:(end: "stealth"))
      line(name:"r", (0,-.5),(2.5,-.5), mark:(end: "stealth"))
      line(name:"r2",(0, 1 ),( 3 , 1 ), mark:(end: "stealth"))

      content("r1.mid", $r_1$, anchor:"north")
      content("r.mid",  $r$  , anchor:"north")
      content("r2.mid", $r_2$, anchor:"north")

      line((2,0),(2,4))
      line((3,0),(3,4))
      hobby(name:"a2",(2,2),(2.4,1.6),( 3,1.5),stroke:red)
      content("a2.end",   $T_W_2$, anchor:"north-west", padding: 0.2)
      content("a2.start", $T_W_1$, anchor:"south-east", padding: 0.2)
    })
  ),
  [
    По граничным условиям 1-го рода:

    #block(math.equation(block: true, numbering: none)[$ cases(
      1/r dv(,r) (r dot dv(T,r))=0,
      T|_(r=r_1) = T_W_1,
      T|_(r=r_2) = T_W_2
    ) $])

    #math.equation(block: true, numbering: none)[$ dv(T,r,2)+1/r dv(T,r)=0 $]
    #math.equation(block: true, numbering: none)[$ U = dv(T,r) &=> dv(U,r)+U/r=0=> ln U + ln r=C_1 \ &=> U=C_1/r => dd(T)= C_1/r dd(r) => T = C_1 ln r + C_2 $]
  ]
)
\

При граничных радиусах: 
#math.equation(block: true, numbering: none)[$ cases(r=r_1: T=T_W_1=C_1 ln r_1 + C_2, r=r_2: T=T_W_2=C_1 ln r_2 + C_2)  $]
#math.equation(block: true, numbering: none)[$ cases(C_1 = (T_W_1-T_W_2)/ln(r_1/r_2), C_2 = T_W_1 - (T_W_1-T_W_2) (ln r_1)/(ln (r_1/r_2)) ) $]

#math.equation(block: true, numbering: none)[$ T(r) = T_W_1 - (T_W_1-T_W_2) (ln(r/r_2))/ln(r_2/r_1) $]

$ q = -lambda dv(T,r) = (lambda (T_W_1-T_W_2))/(r ln (r_2/r_1)) $

$ Q = F q=2 pi r l q = (2 pi lambda l (T_W_1 - T_W_2))/(ln(r_2/r_1)) $

$ q_l = Q/l  = (lambda (T_W_1 - T_W_2))/(ln(r_2/r_1)) $

Это линейная плотность теплового потока, $[q_l]= "Вт"/"м"$

\

При г/у 3-го рода:
#set math.cases(reverse: true)
#math.equation(block: true, numbering: none)[$ cases(
  Q = pi D_1 l (T_f_1 - T_W_1) alpha_1,
  Q = q_1 pi D_1 l = (lambda (T_W_1 - T_W_2))/(D_1/2 ln(D_2/D_1) pi D_1l),
  T|_(r=r_2) = T_W_2
) => Q = (T_f_1-T_f_2)/(1/(alpha_1 pi D_1 l) + 1/(2 pi l lambda ) ln(D_2/D_1) + 1/(alpha_2 pi D_2 l) ) $]

$ q_l = Q/l = (pi (T_f_1-T_f_2))/(1/(alpha_1 D_1) + 1/(2 lambda ) ln(D_2/D_1) + 1/(alpha_2 D_2) ) $
\

*Составные стенки*:
#grid(
  columns:(1fr,3fr),
  gutter: 3em,
  [
    Для г/у 1-го рода:
    #math.equation(block: true, numbering: none)[$ q_l = (pi (T_W_1-T_W_(n+1)))/( sum_(k=1)^n 1/(2 lambda k) ln(D_(k+1)/D_k) ) $]
  ],
  [
    Для г/у 3-го рода:
    #math.equation(block: true, numbering: none)[$ q_l = (pi (T_f_1-T_f_(n+1)))/( 1/(alpha_1 D_1) + sum_(k=1)^n 1/(2 lambda k) ln(D_(k+1)/D_k) + 1/(alpha_(n+1) D_(n+1) ) ) $]
  ]
)
\

Линейный коэффициент теплопередачи:

$ K_l = (1)/( 1/(alpha_1 D_1) + sum_(k=1)^n 1/(2 lambda k) ln(D_(k+1)/D_k) + 1/(alpha_(n+1) D_(n+1) ) ) $

$ q_l = pi K_l (T_f_1-T_f_(n+1)) $
\

Задача о критическом диаметре цилиндрической стенки:

#box(stroke:black,outset:1em)[Имеется двухслойная цилиндрическая стенка (трубопровод с изоляцией). Толщины внутренней стенки задана $=> R_(l sum)$ зависит только от диаметра внешней стенки ($D_3$). Исслуедуем $R_(l sum)$ на экстремум.]

\

#math.equation(block: true, numbering: none)[$ R_(l sum) = 1/(alpha_1 D_1) + 1/(2 lambda_1) ln(D_2/D_1) + 1/(2 lambda_2) ln(D_3/D_2) + 1/(alpha_3 D_3) $]

#math.equation(block: true, numbering: none)[$ dv(R_(l sum),D_3) = 1/(2 lambda_2) dot 1/D_3 - 1/(alpha_3 D_3^2) = 0 => D_3^(("кр")) = (2lambda_2)/alpha_3 $]

При $D_3<D_3^("кр")$ с ростом $D_3$ $R_(l sum)$ увеличивается, при $D_3=D_3^("кр")$ $R_(l sum)$ достигает максимума, при $D_3>D_3^("кр")$ с ростом $D_3$ $R_(l sum)$ уменьшается.

= Теплопроводность шаровой стенки при граничных условиях 1 и 3 рода. Составная шаровая стенка. Коэффициент теплопередачи для шаровой стенки.



= Оребрение, его эффективность. Коэффициент эффективности ребра. Расчёт ребра прямоугольного сечения. Возможный порядок расчёта оребрения.

#lorem(400)

= Нестационарная теплопроводность. Неограниченная пластина при симметричных граничных условиях 3 рода. Форма решения, характеристические уравнения и их корни. Безразмерные соотношения, расчёт по таблицам и графикам.

#lorem(400)

= Нагрев и охлаждение тел конечных размеров. Мультипликативные формулы.

#lorem(400)

= Регулярный тепловой режим. Темп охлаждения тела. Коэффициент неравномерности распределения температуры. Теоремы Кондратьева, их использование.

#lorem(400)

= Методы конечных разностей. Метод Шмидта. Метод элементарных балансов (Ваничева). Устойчивость решения. Явные и неявные схемы.

#lorem(400)

= Конвективный теплообмен. Основные понятия. Свободная и вынужденная конвекция. Закон конвективного теплообмена Ньютона, коэффициент теплоотдачи. Закон вязкого трения Ньютона, динамическая и кинематическая вязкость жидкости. Режимы движения жидкости. Динамический и тепловой пограничный слой.

#lorem(400)

= Краевая задача конвективного теплообмена. Используемые фундаментальные и эмпирические законы. Уравнения теплообмена, энергии, движения и сплошности. Краевые условия.

#lorem(400)

= Подобие физических явлений. Необходимые условия подобия. Теоремы подобия. Достаточные условия подобия. Метод размерностей. Основные критерии подобия, их физический смысл. Выбор характерных параметров: размера, температуры, скорости. Графическая обработка опытных данных.

#lorem(400)

= Конвективный теплообмен в однофазной среде. Теплообмен при вынужденном движении жидкости вдоль неограниченной пластины. Ламинарный и турбулентный режимы. Связь коэффициентов теплоотдачи и трения. Аналогия Рейнольдса. Переходный режим движения. Поправка Михеева. Уравнения подобия для теплообмена на пластине для капельных жидкостей и для газов.

#lorem(400)

= Теплообмен при вынужденной конвекции в трубах и каналах. Профили скорости. Автомодельность. Начальный участок и участок стабилизированного течения. Ламинарный и турбулентный режимы. Теплообмен в турбулентном пограничном слое. Турбулентная теплопроводность. Интеграл Лайона. Уравнения подобия.

#lorem(400)

= Теплообмен при поперечном обтекании труб и трубных пучков. Дорожка фон Кармана. Изменение коэффициента теплоотдачи по окружности трубы. Обтекание под углом, отличным от прямого. Трубные пучки, их параметры. Уравнения подобия для теплообмена в пучках.

#lorem(400)

= Теплообмен при свободной конвекции. Физическая природа. Теплообмен на вертикальных поверхностях. Тепловой пограничный слой. Уравнения подобия для теплообмена. Режимы течения, их изменения по координате.

#lorem(400)

= Теплообмен при свободной конвекции на горизонтальных поверхностях (пластин, труб, проволок). Уравнения подобия. Теплообмен в щелях и зазорах.

#lorem(400)

= Теплообмен при кипении. Физическая природа. Режимы и кризисы кипения. Кривая Нукиямы. Параметры паровых пузырьков: отрывной диаметр, частота отрыва, число центров парообразования.

#lorem(400)

= Теплоотдача при пузырьковом кипении. Числа подобия. Основные уравнения подобия. Первая критическая плотность теплового потока: физический смысл и расчёт.

#lorem(400)

= Теплообмен при конденсации. Физическая природа. Угол смачивания и виды конденсации. Конденсация на вертикальной поверхности. Модель Нуссельта. Поправочные коэффициенты.

#lorem(400)

= Конденсация на горизонтальных трубах. Конденсация на пучках труб. Конденсация внутри труб. Режимы течения двухфазных потоков. Капельная конденсация.

#lorem(400)

= Термосифоны и тепловые трубы.

#lorem(400)

= Теплообменники. Классификация, виды расчёта. Уравнения теплового баланса и теплопередачи. Водяные эквиваленты. T – F – диаграммы. Средний температурный напор. Поправка Нуссельта. Коэффициент теплопередачи.

#lorem(400)

= Эффективность теплообменников. Идеальный теплообменник. ε – NTU – диаграмма и NTU-метод расчёта.

#lorem(400)

= Гидравлический расчёт теплообменников. Потери давления. Мощность, расходуемая на перемещение теплоносителей

#lorem(400)

= Теплообмен излучением. Физическая природа и особенности. Законы Кирхгофа и Стефана – Больцмана. Поглощательная, отражательная и пропускательная способность тел и сред. Абсолютно чёрное тело. Степень черноты.

#lorem(400)

= Теплообмен излучением в прозрачной среде. Теплообмен между параллельными серыми пластинами. Радиационные экраны. Инфракрасное излучение газов.

#lorem(400)

= Система «тело в оболочке». Угловые коэффициенты. Способы определения. Метод нитей.

#lorem(400)

