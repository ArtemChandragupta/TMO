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
#set math.cases(reverse: false)
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

При д/у 1-го рода:

#math.equation(block: true, numbering: none)[$ cases(
  dv(T,r,2) + 2/r dot dv(T,r)=0 "- Лапласиан в сферических координатах",
  T|_(r=r_1) = T_W_1,
  T|_(r=r_2) = T_W_2
) $]

#math.equation(block: true, numbering: none)[$ T(r)=T_W_1 - (T_W_1 - T_W_2) (1/r_1 - 1/r)/(1/r_1 - 1/r_2) $]

$ Q = -lambda dv(T,r)|_(r=r_1) pi r_1^2= (lambda (T_W_1 - T_W_2)pi)/(1/r_1-1/r_2) = (pi (T_W_1 - T_W_2))/(1/lambda (1/r_1-1/r_2)) $
\

При д/у 3-го рода:

$ Q = (pi (T_f_1 - T_f_2))/(1/(alpha_1 D_1^2) + 1/lambda (1/r_1-1/r_2) + 1/(alpha_2 D_2^2) ) $
\

Составная шаровая стенка: \
При д/у 1-го рода:

$ Q = (pi (T_W_1 - T_W_(n+1)))/( sum_(k=1)^n 1/(2 lambda_k) (1/D_k-1/D_(k+1))) $

При д/у 3-го рода:

$ Q = (pi (T_f_1 - T_f_(n+1)))/(1/(alpha_1 D_1^2) + sum_(k=1)^n 1/(2 lambda_k) (1/D_k-1/D_(k+1)) + 1/(alpha_2 D_2^2) ) $
\

Коэффициент теплопередачи шаровой стенки:

$ K_ш = 1/(1/(alpha_1 D_1^2) + sum_(k=1)^n 1/(2 lambda_k) (1/D_k-1/D_(k+1)) + 1/(alpha_2 D_2^2) ) $

= Оребрение, его эффективность. Коэффициент эффективности ребра. Расчёт ребра прямоугольного сечения. Возможный порядок расчёта оребрения.

Оребрение выполняется на поверхностях с низким коэффициентом теплопередачи с целью его увеличения.


#figure(
  image("assets/rexxxxxxxxx.png", width: 80%),
) <fig-rexxxxxxxxx>

#math.equation(block: true, numbering: none)[$ Q = "const" $]

#math.equation(block: true, numbering: none)[$ cases(
  Q = alpha_1 (T_f_1 - T_W_1) F_1,
  Q = lambda/delta (T_W_1 - T_W_2) F_1,
  Q = alpha_(2W) (T_W_2-T_f_2) F_2 + alpha_(2l) (overline(T) - overline(T)_f_2) F_р
) $]

#math.equation(block: true, numbering: none)[$ Q &= alpha_(2W) (T_W_2-T_f_2) F_2 + alpha_(2l) (overline(T) - overline(T)_f_2) F_р = (alpha_(2W) F_2/F_1 + alpha_(2l) eta F_р/F_1 )(T_W_2-T_f_2)F_1 \ &= tilde(alpha)_2(T_W_2-T_F_2)F_1 $]
\

$tilde(alpha)_2$ - приведённый коэффициент теплопередачи

$eta = (overline(T) - T_f_2)/(T_W_2-T_F_2)<1$ - Коэффициент энергоэффективности ребра: отношение теплового потока, отдаваемого ребром, к тепловому потоку, отдаваемому идельным ребром с бесконечной теплопроводностью и температурой $T_W_2$.

$tilde(K) = 1/(1/alpha_1 + delta/lambda + 1/ tilde(alpha)_2)$ - приведённый коэффициент теплопередачи

\

*Расчет ребра прямоугольного сечения:*

#figure(
  image("assets/rereeeee.png", width: 80%),
) <fig-rereeeee>

Примем допущения:
+ $T$ меняется только по x,
+ Конвективный теплообмен происходит только на боковых поверхностях,
+ $q(X)=alpha(T-T_f); "  " alpha="const".$
\

Рассмотрим тепловой баланс элемента $difference(x)$. Теплота, переданная с границы, равна убыли теплоты внутри пластины:

#math.equation(block: true, numbering: none)[$ q(x) dot 2 delta p - q(x+difference(x)) dot 2 delta p - alpha (2 p difference(x)) (T(x)-T_f)=0|:2 delta p dd(x) $]

#math.equation(block: true, numbering: none)[$ op(arrow, limits:#true)_(difference(x) arrow 0) - dv(q,x) = alpha/delta (T(x)-T_f); "  " q(x) = -lambda dv(T,x)=> $]

#math.equation(block: true, numbering: none)[$ cases(
  dv(T,x,2) = alpha/delta (T(x) - T_f),
  T(0) = T_W,
  dv(T,x)|_(x=l) = 0 "- нет теплообмена на торце"
) $]

*Безразмерный взгляд*:\
$ Theta = (T(x)-T_f)/(T_W-T_f) &"- безразмерная температура"\
X=x/L &"- безразмерная координата"\
L^*=L/delta &"- безразмерная длина ребра"\
"Bi" = (alpha L)/lambda = R_lambda/R_alpha &"- число Био" $

#math.equation(block: true, numbering: none)[$ cases(
  dv(Theta,x,2) = Theta dot "Bi" dot L^*,
  Theta|_(x=0)=1,
  dv(Theta,x)|_(x=1) = 0 
) => Theta = ("ch" ( (1-x) sqrt("Bi" dot L^*) ) )/("ch" (sqrt("Bi" dot L^*) ) ) $]

Тепловой напор, отводимый от ребра:
$ Q= sqrt("Bi" dot L^*) (lambda dot 2 delta p )/L (T_W-T_f) "th" (sqrt("Bi" dot L^*)) $

$ Q^*= lambda dot 2 delta p (T_W-T_f) "- для идеального ребра" $

$ eta = Q/Q^* = sqrt( "Bi" dot L^* ) "th" (sqrt("Bi" dot L^*)) $
\

Порядок расчёта оребрения:
+ Выбрать материал ребра с высокой теплопроводностью $lambda$;
+ Задают размеры ребра (delta, p, L). Оценивают $alpha$;
+ Переходят к безразмерным параметрам ($"Bi", L^*,X$);
+ По графику определяют $eta$ и уточняют расчёт;
+ Расчитывают тепловой поток - $Q = eta alpha F (T_W - T_f)$

При большом количестве рёбер:


#figure(
  image("assets/rebrrrr.png", width: 80%),
) <fig-rebrrrr>

$F_p$ - площадь боковой поверхности ребра;
$F_c$ - площадь неоребрённой поверхности;
$F_(p c)=F_c + 2 F_p$ - площадь поверхности теплоотдачи.

$ tilde(alpha)_2 = alpha_(2W) F_c/F_(p c) + alpha_(2l) eta F_p/F_(p c) $

$ q = Q/F_1 = (T_f_1-T_f_2)/(1/alpha_1 + delta/lambda + 1/(tilde(alpha)_2 F_"pc"/F_1 )) = (T_f_1-T_f_2)/(1/alpha_1 + delta/lambda + 1/(tilde(alpha)_2 beta )) $

$beta = F_"pc"/F_1=5 dots 10$ - коэффициент оребрения

= Нестационарная теплопроводность. Неограниченная пластина при симметричных граничных условиях 3 рода. Форма решения, характеристические уравнения и их корни. Безразмерные соотношения, расчёт по таблицам и графикам.

Термически тонкое тело - тело, у которого температура в каждый момент времени одинакова по всему объёму. $R_lambda/R_alpha << 1 => B i << 1$ - условие термической тонкости. 

Термически тонкое тело погружено в среду. Уменьшение энергии тела равно подведённому теплу:

$ -rho V C pdv(T(tau),tau)=alpha F (T-T_f) $

Введём $J = T-T_f$ - избыточная температура.

$ cases(
  -rho V C pdv(T(tau),tau)=alpha F J,
  J|_(tau=0)=J_0=T_0-T_f
) "- начальное условие" => (J(tau))/J_0 = e^((- alpha F tau)/(rho V c)) $

$R=V/F$ - обобзённый размер.

$ (alpha F tau)/(rho V c) = (alpha lambda F tau)/(rho V C lambda) = (alpha R)/lambda dot (alpha tau)/R^2= "Bi" dot F_0; "  " F_0 = (alpha tau)/R^2 "- число Фурье" $

$ Theta = (J(tau))/J_0=e^(- "Bi" F_0) "- безразмерная избыточная температура" $

По закону Ньютона: $Q(tau)=alpha F (T-T_f)=alpha F J $

$ Q^*(tau) = (Q(tau))/(alpha F J_0)=e^(-"Bi" F_0) "- безразмерный тепловой поток" $

Количество теплоты, отданное телу: 
$ Q_tau = integral_0^tau Q(tau) dd(tau)= alpha F J_0(t) integral_0^tau e^(- "Bi" dot F_0) dd(tau) $

В безразмерной форме:
$ Q_tau^* = Q_tau/(alpha F J_0 tau) = (1-e^(-"Bi" dot F_0))dot 1/e^(-"Bi" dot F_0) $

Неограниченная пластина при симметричных г/у 3-го:

#grid(
  columns:(1fr,2fr),
  [
    #figure(
      image("assets/ululul.png", width: 80%),
    ) <fig-ululul>
  ],
  [
    $ cases(
      pdv(T,tau)=alpha pdv(T,x,2),
      -lambda pdv(T,x)|_(x=delta) = alpha (T_w - T_f),
      T|_(tau=0)=T_0
    ) $
  ]
)
\

Введём безразмерные величины:

$ Theta = (T(x,tau)-T_f)/(T_0-T_f) "- безразмерная избыточная температура" $

$ Theta_w = (T_w(tau)-T_f)/(T_0-T_f), "  " L=x/delta "- безразмерная координата" => $

$ "Bi" = (alpha delta)/lambda, "  " F_0 = (alpha tau)/delta^2 $

$ cases(
  pdv(Theta, F_0)=pdv(Theta,L,2),
  pdv(Theta,L)|_(L=+- 1) = "Bi" dot Theta_w,
  Theta|_(F_0=0)=1
) => Theta = sum_(n=1)^(+ infinity) A_n (mu_n) cos(mu_n L) e^(-mu_n^2 F_0) $

$mu_n$ - корни уравнения $ctg mu=mu/"Bi" $ - характеристическое уравнение.

$ A_n(mu_n) = (2 sin(mu_n))/(mu_n + cos(mu_n) sin(mu_n) "- амплитудная функция" $

#figure(
  image("assets/Bi-.png", width: 80%),
) <fig-bi->

// $ J=C e^(-m tau) => m = () $
Расчёт процессов по формулам и таблицам:\
Безразмерные соотношения:

$ Theta^* =1-Theta; "  " Theta= (T(x,tau)-T_f)/(T_0 - T_f) "- безразмерная избыточная температура" $

$ F_0 = (alpha tau)/delta^2 "- число Фурье  " "Bi"= (alpha delta)/lambda "- число Био" $

$ overline(Theta) = (overline(T)(tau)-T_f)/(T_0-T_f), " где" overline(T)(tau) "- среднемассовая температура" $
// $ overline(Theta) = sum_(n=1)^(+infinity)  $
$ Theta_"пов"^*=1-(T(delta,tau)-T_f)/(T_0-T_f), "  " Theta_"ц"^*=1-(T(0,tau)-T_f)/(T_0-T_f) $


#figure(
  image("assets/Biobio.png", width: 80%),
) <fig-biobio>

= Нагрев и охлаждение тел конечных размеров. Мультипликативные формулы.

Тела конечных размеров представлюятся в виде пересечения бесконечных тел.

Мультипликативные формулы:\
Безразмерная избыточная температура тела может быть найдена как произведение безразмерных температур бесконечных тел, его образующих:

Для бруска: $Theta = Theta_(т 1)(X) Theta_(т 2)(Y)$
Для циллиндра: $Theta = Theta_т (L_y) Theta_y (L_R)$


= Регулярный тепловой режим. Темп охлаждения тела. Коэффициент неравномерности распределения температуры. Теоремы Кондратьева, их использование.

При $F_0> 0.3$ в решении задачи теплопроводности можно ограничиться первым членом ряда, $T$ будет меняться экспаненциально.

$ J=C dot e^(-m r) => m= (ln(J_2)-ln(J_1))/(r_2-r_1) "- темп охлаждения," [m] = 1/"с" $

Первая теорема Кондратьева:

$m = Psi dot (alpha F)/(c rho V)$ при конечном $alpha$, где $c rho V$ - полная теплоёмкость тела,

$Psi = overline(J)_F/overline(J)_V$ - коэффициент неравномерности распределения температуры,

$overline(J)_F$ - избыточная температура, усреднённая по поверхности,

$overline(J)_V$ - избыточная температура, усреднённая по объёму.\
При $"Bi" -> 0 " " overline(J)_f approx overline(J)_V=> Psi=1 $\
При $"Bi" -> infinity " " T_W -> T_f => overline(J)_f -> 0 => Psi=0 $

\

Вторая теорема Кондратьева:\
При $"Bi"-> infinity$ темп охлаждения $m_infinity$ прямо пропорционально температуро проводности тела

$ alpha = K m_infinity; K "- коэффициент, зависящий от формы и размеров тела." $

$ "Для пластины толщиной " 2 delta: &K= 1/( (pi/ (2 delta))^2 ) \ "Для шара": &K=1/( (pi/r_0)^2 ) $

= Методы конечных разностей. Метод Шмидта. Метод элементарных балансов (Ваничева). Устойчивость решения. Явные и неявные схемы.

Приближённо заменяют гладкую кривую распределения температур нанекоторую ломаную.

Метод Шмидта:

Разобьём пластину на слои толщиной $difference(x)$. Номер слоя - $n$, номер момента времени - $(difference(r)) = K$, $T_(n,K)$ - температура $n$-ного слоя в $K$-тый момент времени. Ломаная приближённо задаёт распределение температур в пластине.

#figure(
  image("assets/Shmidt.png", width: 80%),
  caption: [],
) <fig-shmidt>

$ pdv(T,tau) = alpha pdv(T,x,2) -> dv(R, tau, d:Delta) = alpha (Delta^2 T)/(Delta x^2); "  " tau = K difference(tau) $

$ ( dv(T,x, d:Delta) )_- = (T_(n,K)- T_(n-1,K) )/difference(x), "  " ( dv(T,x, d:Delta) )_+ = (T_(n+1,K)- T_(n,K) )/difference(x) $

$ pdv(T,x,2,d:Delta) = 1/difference(x) ( (dv(T,x,d:Delta))_+ - (dv(T,x,d:delta))_- )= 1/difference(x)^2 (T_(n+1,K) + T_(n-1,K) - 2 T_(n,K) ) $

$ dv(T,tau,d:Delta) = ( T_(n,K+1) - T_(n,K) )/difference(tau) = alpha ( T_(n+1,K) - T_(n-1,K) - 2 T_(n,K) )/difference(x)^2 => $

$ => T_(n, K+1) - T_(n,K) = (2 alpha difference(tau))/difference(x)^2 ( (T_(n+1,K)+T_(n-1,K) )/2 -T_(n,K) ) $

$ "При" (2 alpha difference(tau))/difference(x)^2=1 => T_(n,K+1) = 1/2 ( T_(n+1,K) + T_(n-1,K) ) => $

Температура в слое $n$ в момент $tau=(K+1)difference(tau)$ равна получумме температур в соседних слоях в момент $tau = K difference(tau)$

$ (alpha difference(tau))/difference(x)^2=1/2 => F_0=0.5 $

Для использования метода Шмидта нужно:
+ Задать начальное распределение температур;
+ Выбрать $difference(tau)$ и $difference(x)$ так, чтобы $F_0=0.5$
+ Определить температуры в последующие моменты времени.

$ T_(n,K+1)=1/2 (T_(n-1,K) + T_(n+1,K) ) $


#figure(
  image("assets/Shmidt2.png", width: 80%),
  caption: [],
) <fig-shmidt2>
\

Метод Ваничева (элементарных балансов):\
Предполагая, что теплоёмкость каждого слоя сосредоточена в центре. С соседними слоями слой соединяется тепловыми связями, по которым перераспределяется тепло.


#figure(
  image("assets/Vanicheva.png", width: 80%),
  caption: [],
) <fig-vanicheva>

Допущения:
+ Изменение температуры между точками происходит по линейному закону.
+ Изменение температуры во времени происходит скачками.
+ Увеличение энтальпии элементарного объёма, прилегающего к узлу, пропорционально приращению температуры в узле.
\

Выделим в слое прямоугольник со сторонами $difference(x), difference(x),1$ - элементарный объём.

#grid(
  columns:(1fr,2fr),
  figure(
    image("assets/iiii.png", width: 80%),
    caption: [],
  ),
  [
    $ V=difference(x) dot difference(x) dot 1 = (difference(x))^2; "  " S=difference(x) dot 1 = difference(x) $
    $ Q_21 = lambda/difference(x) (T_2 - T_1) difference(x) difference(tau) $
    $ Q=q difference(tau) = lambda/delta (T_W_1 - T_W_2) S difference(tau) $
    $ Q_31 = lambda/difference(x) (T_3 - T_1) difference(x) difference(tau) $
    Тепло идёт на приращение энтальпии слоя:
  ]
)

$ c rho V (T_1' -T_1)=Q_21 + Q_31 = lambda difference(tau) (T_3 + T_2 - 2 T_1) $

$T_1'$ - температура в конце интервала $difference(tau)$

$ => T_1' = (lambda difference(tau))/(c rho V) (T_2 + T_3 - 2 T_1 + T_1/( (lambda difference(tau))/(c rho V) ) ),\ "  " alpha = lambda/(rho c), "  " V=(difference(x))^2, "  " F_0 = (alpha difference(tau))/( (difference(x))^2 ) => $

$ => T_1' = F_0 (T_2 + T_3 + T_1(1/F_0 -2)) $

При $F_0 = 0.5$ $T_1'=1/2 (T_2+T_3)$ - метод Шмидта.

С уменьшением $F_0$ растёт точность решения.

Устойчивость решения:

Оба метода дают правильные результаты при $F_0<= 0.5$.\
Пример потери устойчивости при $F_0-1$:

$ T_1'=T_2+T_3-T_1; "  " T_2=T_3=500 K, T_1 = 300 K => $

$ => T_1'=1000-300=700 K > T_2,T_3 "- физически невозможно." $

Дополнение: Для двухмерной задачи рассматриваются пространственные тепловые связи.

$ T_1' = F_0 ( T_1 + T_2 + T_3 + T_4 + T_1(1/F_0 - 4) ) $

Устойчивость при $F_0<=0.5$.

*Явные и неявные схемы*:

Методы Шмидта и Ваничева реализуют явные конечно-разностыне схемы, а именно каждая последующая оопределяется с использованием предыдущей. Существуют неявные разностные схемы, позволяющие определить температуру в любой момент времени и для любого $F_0$.

Запишем уравнение теплового баланса для момента $tau + delta tau$:

$ c rho V (T_1'-T_1) = Q_21 + Q_31 = lambda difference(tau) ( (T_2'-T_1')+(T_3'-T_1') )=> $
$ => (1+2 F_0)T_1' - F_0(T_2'-T_3') -T_1=0 $

$T_1'$ зависит от $T_2'$ и $T_3'$ в соседних узлах в тот же момент времени.

Систему уравнений нужно записать для всех узлов и решить для $tau+difference(tau)$

= Конвективный теплообмен. Основные понятия. Свободная и вынужденная конвекция. Закон конвективного теплообмена Ньютона, коэффициент теплоотдачи. Закон вязкого трения Ньютона, динамическая и кинематическая вязкость жидкости. Режимы движения жидкости. Динамический и тепловой пограничный слой.

При теплообмене конвекцией совместно действуют как конвективный перенос тепла, так и теплопроводность. Среда, участвующая в ковективном теплообмене, условно называется жидкостью.

Основная задача конвективного теплообмена - установить связь плотности теплового потка на поверхности с температурами жидкости. (распределением температуры)

#grid(
  columns: (1fr, 1fr),
  figure(
    image("assets/Convek1.png", width: 80%),
    caption: [],
  ),
  [
    $delta$ - толщина динамического пограничного слоя, за его пределами $w="const"$.\
    $Delta$ - толщина теплового пограничного слоя.
  ]
)
\

*Свободная и вынужденная конвекция*:\
Если движение жидкости вызывана неоднородным полем массовых сил (гравитационных, электромагнитных), то конвекция называется свободной. Если движение жидкости вызвано воздействием поверхностных сил, внутренних массовых сил или внешним подводом кинетической энергии, то конвекция называется вынужденной.

Закон конвективного теплообмена Ньютона:
$ q=alpha (T_f-T_W), "  " [alpha]="Вт"/("м"^2 dot "К") "- коэффициент теплоотдачи" $

Если температуры жидкости и стенки неоднородны, то определяется средний коэффициент теплоотдачи:

$ overline(alpha)= Q_m/((T_f_m-T_W_m)F) $

$Q_m, T_f_m, T_W_m$ - среднее значение $Q,T_f$ и $T_W$. $F$ - площадь поверхности теплообмена.

$alpha_i= q_i/(T_f_i-T_W_i)$ - местный коэффициент теплоотдачи

$q_i, T_f_i, T_W_i$ - значение температуры стенки, жидкости и плотность теплового потока в данной точке.

Если есть участки, на которых $alpha_i approx "const"$, тепловой поток $Q$ определяется, как:

$ Q=sum_(i=1)^n q_i F_i = sum_(i=1)^n alpha_i (T_f_i-T_W_i) F_i $

В общем случае $Q$ определяется интегрированием по поверхности $F$:

$ integral_F alpha (T_f-T_W) dd(F) $

$ cases(
  q = alpha(T_f-T_W),
  q = -lambda_f pdv(T,n)|_(n=0) "- закон фурье"
) => alpha = -lambda_f (pdv(T,n)|_(n=0) )/(T_f-T_W) &"- уравнение"\ &"теплоотдачи" $
\

Так как $T=T_f$ на некотором удалении от стенки, то
$ pdv(T,n)|_(n=0)= - (T_f-T_W)/delta=> alpha=lambda_f/delta, "  " delta &- "толщина теплового"\ &"пограничного слоя"  $

Закон вязкого трения Ньютона, кинематическая и динамическая вязкость жидкости:

$S$ - касательное напряжение. Касательная сила, отнесённая к единице поверхности.

$ S= mu pdv(W,n) "- закон вязкого трения Ньютона" $

$[mu]="Па"/"с"$ - динамическая вязкость.\
$nu=mu/rho_f; "  " [nu]="м"^2/"с" $ - кинематическая вязкость жидкости.

Жидкость, подчиняющаяся закону Ньютона, называется ньютоновской.

Для газов введён температурный коэффициент объёмного расширения:

$ beta = 1/V (pdv(V,T_f))_p, "  " [beta]=1/K, "  " V=1/rho_f "- удельный объём" $

Для идеального газа $beta=1/T_f$

Режимы движения жидкости:
+ Ламинарный режим:
  Движение устойчиво, без случайных изменений вектора скорости по модулю и направлению.
+ Турбулентный режим:
  Характеристики потока меняются хаотично во времени. Режим характеризуется число Рейнольдса $Re= (w d)/nu$ - отношение сил инерции и кинематической вязкости.

$Re_"кр"$ - критическое число Рейнольдса.

При $Re<Re_"кр"$ течение ламинарное, при $Re>Re_"кр"$ - турбулентное.

= Краевая задача конвективного теплообмена. Используемые фундаментальные и эмпирические законы. Уравнения теплообмена, энергии, движения и сплошности. Краевые условия.

Используемые фундаментальные и эмпирические законы:
+ Жидкость является сплошной средой;
+ В объёме жидкости действуют законы сохранения энергии, массы, импульса;
+ Действуют законы теплообмены Ньютона и вязкого трения Ньютона;
+ Физические свойства жидкости считаются заданными.

*Дифференциальные уравнения конвективного теплообмена*:

+ Уравнение теплоотдачи:
  $ alpha = (-lambda_f (pdv(T,n)|_(n=0)) )/(T_f-T_W) $
+ Уравнение энергии:
  #math.equation(block: true, numbering: none)[$ (D T)/ (diff tau) = pdv(T, tau) + pdv(T,x) pdv(x,tau) + pdv(T,y) pdv(y,tau) + pdv(T,z) pdv(z,tau) "- субстанциональная производная" $]
  $pdv(T,tau)$ - локальная составляющая, остальное - конвективная.

  #math.equation(block: true, numbering: none)[$ (D T)/ (diff tau) = pdv(T, tau) + pdv(T,x) W_x + pdv(T,y) W_y + pdv(T,z) W_z $]

  $ (D T)/(diff tau) = lambda_f / (rho_f C_(p f)) ( pdv(T,x,2) + pdv(T,y,2) + pdv(T,z,2) ) = alpha_f grad^2 T "- уравнение энергии" $

  Выражает закон сохранения энергии при конвективном теплообмене.
+ Уравнение движения (уравнение Навье-Стокса):
  $ rho_f (D overline(W))/(diff tau) = rho_f overline(g) - grad p + mu grad^2 overline(W) $
  $ cases(
    rho_f (D W_x)/(diff tau) = rho_f g_x - pdv(p,x) + mu (pdv(W_x,x,2)+pdv(W_x,y,2)+pdv(W_x,z,2)),
    rho_f (D W_y)/(diff tau) = rho_f g_y - pdv(p,y) + mu (pdv(W_y,x,2)+pdv(W_y,y,2)+pdv(W_y,z,2)),
    rho_f (D W_z)/(diff tau) = rho_f g_z - pdv(p,z) + mu (pdv(W_z,x,2)+pdv(W_z,y,2)+pdv(W_z,z,2)),
  ) $
+ Уравнение неразрывности (сплошности, сохранения массы)
  В силу закона сохранения массы в любой объём поступает столько массы, сколько выходит:
  $ difference(G_m) = integral.cont_F rho_f overline(W) dd(F)=0 "- изменение массового расхода" $
  По теоремме Остроградского-Гаусса:
  $ integral.cont_F rho_f overline(W) dd(F) = integral_V ( pdv((rho_f W_x),x) + pdv((rho_f W_y),y) +pdv((rho_f W_z),z) ) dd(V) =\ = integral_V div(rho_f overline(W)) dd(V), "так как жидкость несжимаема," rho_f = "const"=>\ => div(overline(W))=0 => pdv(W_x,x)+pdv(W_y,y)+pdv(W_z,z)=0 $
\

*Краевые условия* (условия однозначности):
+ Задание геометрических размеров;
+ Задание физических свойств жидкости: $rho_f, lambda_f, c_(p f), mu, beta$;
+ Задание граничных условий: $T_W,W_W,p_W$ - $T,W,P$ на поверхности, омываемой жидксотью;
+ Если теплообмен нестационарный, задают начальные условия. Значения $T, W, rho, T_W$ в начальный момент времени по всему объёму.


= Подобие физических явлений. Необходимые условия подобия. Теоремы подобия. Достаточные условия подобия. Метод размерностей. Основные критерии подобия, их физический смысл. Выбор характерных параметров: размера, температуры, скорости. Графическая обработка опытных данных.

Когда различные физические явления описываются тождественными дифференциальными уравнениями, то говорят, что они принадлежат к одному классу. Если у таких явлений качественно совпадают начальные условия, то их называют явлениями одного рода. Если в явлениях одного рода физические величины распределены в пространстве и во времени схожим образом, то говорят о физическом подобии.

Необходимые условия подобия:
+ Явления должны происходить в геометрически подобных ситуациях;
+ Нестационарные явления должны быть гомохронными (каждому моменту во времени должен соответствовать другой момент во времени.)
  $ F o_1=F o_2 => (alpha_1 tau_1)/d_1^2 = (alpha_2 tau_2)/d_2^2 "- условие гомохронности" $
+ Отношения одноимённых величин в сходственных точках в сходственные моменты времени должны быть равны друг другу.

$ C_alpha = alpha_1/alpha_2; "  " C_l = l_1/l_2; "  " C_tau = tau_1/tau_2 "- множители преобразования" $

Теоремы подобия:

В теории подобия используются безразмерные соотношения, делящиеся на две группы:

+ Симплексы - отношения однородных величин.\
  Пример: $L=l/l_0$ - безразмерная длина, $Theta=T/T_0$ - безразмерная температура.
+ Комплексы - отношения разнородных величин, характеризующих процесс\
  Пример: $N u = (alpha l)/(lambda_f), "  " P r = nu/alpha, "  " F o = (alpha tau)/l^2, "  " B i = (alpha l)/lambda_W $
\

Первая теоремма подобия:\
Подобные явления имеют одни и те же критерии подобия.

Вторая теорема подобия:\
Всякое уравнение, связывающее между собой $n$ физических величин, может быть приведено к зависимосте между $i>=n-k$ безразмерными комплексами этих величин. $k$ - число первичных величин, используемых при описании явления. (масса, энергия, длина, температура)

Третья теорема подобия:\
Подобны между собой те явления, у которых совпадают однотипные условия однозначности и равны определяющие критерии. 

Определяющий критерий - критерий подобия, включающий в себя независимую переменную. Искомые величины входят в определяемые критерии.

Достаточное условие подобия - равенство определяющих критериев процессов.

Метод размерностей:\
$lambda=C l^b W^c rho_f^d nu^e c_(p f)^f lambda_f^g$ - уравнение коэффициента теплоотдачи при вынужденном теплообмене $n=7, k=4=>i>=3$

Задание уравнения подобия с помощью гомогенной формы.

Первичные величины: $[L]$ - длина, $[M]$ - масса, [$T$] - время, [$Theta$] - температура.

$[alpha]= "Вт"/("м"^2 dot "к")=[M/(T^3 Theta)]$, $[L]=[L]$, $[rho]=[M/L^3]$, $[J]=[L^2/T]$, $[W]=[L/T]$, $[C]=[L^2/(T^2 Theta)] $, $[lambda]=[(M L)/(T^3 Theta)] $

Подставим в исходное уравнение:

$ [M/(T^3 Theta)]=C[L]^b [L/T]^c [M/L^3]^d [L^2/T]^e [L^2/(T^2 Theta)]^f [(M L)/(T^3 Theta)]^g => $

$ cases(
  [M]&:     &1=d+g,
  [L]&:     &0=b + c - 3 d + 2 e -3 g,
  [T]&:    -&3= -c -e -2 f -3 g,
  [Theta]&:-&1= -f -g
) => cases(
  b=d-e-1,
  c=d-e,
  f=d,
  g=1-d
) => $

#math.equation(block: true, numbering: none)[$ alpha = (C L^d W^d rho^d nu^e C^d lambda)/(l^e W^e lambda^d l)=> (alpha l)/lambda &= C ((W l)/lambda)^(-e) ((W l c rho)/lambda)^d = \ &= C ((W l)/nu)^(-e) ((W l)/alpha)^d = C ((W L)/nu)^(d-e) ( (W l C rho)/lambda )^d $]

$ "Nu" = (alpha l)/lambda; "  " "Re" = (W l)/nu; "  " "Pr" = nu/alpha; "  " "Pe" = (W l)/alpha => "Nu" = C "Re"^n "Pr"^m $

Основные числа подобия:
+ $"Nu"=(alpha l)/lambda$ - число Нуссельта. Критерий конвективного теплообмена.
+ $"Re" = (W l)/nu$ - число Рейнольдса. Характеризует соотношение сил вязкости и трения.
+ $"Pr"=nu/alpha$ - число Прандтля. Характеризует теплофизические свойства жидкости.
+ $"Pe"=(W l)/alpha$ - число Пекле. $"Pe"="Re" dot "Pr" $
+ $"Bi" = (alpha l)/lambda_W $ - число Био. $"Bi" = R_lambda/R_alpha $
+ $"Gr" = (g l^3 beta difference(T))/nu^2 $ - число Грасгофа.
+ $"Ra" = "Gr" dot "Pr" $ - число Релея.
\

Выбор характерных параметров:
+ Существенные параметры;
+ Величины параметров поддаются измерению и расчёту;
+ Выбор очевиден;
+ Величины праметров = const в ходе эксперимента. Закономерность между критериями подобия представляется графически.


= Конвективный теплообмен в однофазной среде. Теплообмен при вынужденном движении жидкости вдоль неограниченной пластины. Ламинарный и турбулентный режимы. Связь коэффициентов теплоотдачи и трения. Аналогия Рейнольдса. Переходный режим движения. Поправка Михеева. Уравнения подобия для теплообмена на пластине для капельных жидкостей и для газов.

Конвективный теплообмен в однофазной среде - билет 12.

Теплообмен при вынужденном течении вдоль неограниченной пластины:\
В ходе движения жидкости различают два режима течения: ламинарный и турбулентный.

При $"Re"_x = W_x/nu >= 5 dot 10^5 $ режим течения турбулентный. При течении жидкости около поверхности пластины образуется пограничный слой.


#figure(
  image("assets/pogranSloy.png", width: 80%),
  caption: [Пограничный слой],
) <fig-pogransloy>

В ходе движения около стенки образуется динамический и тепловой пограничные слои. В динамическом пограничном слое скорость плавно возрастает от 0 на стенке до скорости в ядре потока, в тепловом от температуры стенки до температуры в ядре потока.

При достижении $"Re"_("кр"1)=(W x_("кр"1))/nu$ в пограничном слое начинают образовываться хаотические пульсации. При $"Re"_("кр"2)=(W x_("кр"2))/nu$ пограничный слой окончательно турбулизуется. Остаётся вязкий подслой, где скорость и температура линейно убывает до $0$ и $T_W$ соответственно.

$delta_l / difference(l)=1/(3 sqrt("Pr_f"))$ - ламинарный режим

$delta_T approx Delta_T$ - турбулентный режим

*Ламинарный режим*:

$ "Nu"_(x f) = 0.335 "Re"_(x f)^0.5 "Pr"_f^0.33 ("Pr"_f/"Pr"_w)^0.25 $

$ "Nu"_(x f) = (alpha x)/lambda_f, "  " "Re"_(x f)=(overline(w)x)/nu_f, "  " "Pr"_f = nu_f / alpha_f "  " Pr_w = nu_w / alpha_w $

$ overline("Nu")_(L f) = 0.67 "Re"_(l f)^0.5 "Pr"_f^0.33 ("Pr"_f/"Pr"_w)^0.25 $

$("Pr"_f/"Pr"_w)^0.25$ - поправка Михеева, отличная от 1 только в капельных жидкостях. Учитывает связь коэффициента теплопроводности с направлением теплового потока.

$ overline("Nu")_(L f)= (alpha L)/lambda_f, "  " Re_(L f)=(overline(w) L)/nu_f $

*Турбулентный режим:*\
Аналогия Рейнольдса:

Предположим, что частица переместилась из положения 1 в положение 2. Тогда уравнение неразрывности требует, чтобы из положения 2 в 1 также перешла частица.


#figure(
  image("assets/Analogia.png", width: 80%),
  caption: [],
) <fig-analogia>

Снизу вверх и сверху вниз идёт массовый поток $dot(m)_y$. Выравниванию скорости? препятствует сила трения между слоями жидкости.

По закону сохранения импульса:

$ S_T = dot(m)_y (overline(W)_(x 1)-overline(W)_(x 2)), "  " S_T "- касательное напряжение трения" $
$dot(m)_y$ - массовый поток вследствие турбулентных пульсаций.

Частица 1 переносит энтальпию $C_(p f) overline(T)_1 dot(m)_y $, частица 2 - $C_(p f) overline(T)_2 dot(m)_y $. Плотность теплового потока в направлении $y$:

$ q_t = C_(p f) dot(m)_y (overline(T)_1 - overline(T)_2) => q_t = (S_T (overline(T)_1 - overline(T)_2) C_(p f))/ (overline(W)_(x 1)-overline(W)_(x 2)) $

В пределах вязкого подслоя скорость и температура меняются линейно => $q_T,S_T="const"=> q_T =q_W, S_T=S_W$

$ q_W = lambda_f/delta_nu (T_W-T_nu) S_W = mu W_nu/delta_nu => q_W = (lambda_f (T_W-T_nu)S_W )/(mu W_nu) $ - уравнение аналогии Рейнольдса. Это аналогия между $alpha$ и $S_W$. Для газов $P r approx 1=> alpha= (S_W C_(p f))/W_0$ $S_W = C_f (rho_f W_0^2)/2=> alpha= (C_f rho_f^2 W_0 C_(p f) )/2=> "St"_f=alpha/(C_f rho_f W_0) $ - число Стентона.

$ S t_f = (N u_(f x))/(R e_(f x) P r_f)=> "при" P r_f approx 1 "  " N u_(f x)= C_f/2 R e_(f x) $

$C_f$ связан с $R e_(f x)$ неким соотношением. Тогда:
- Для газов: $N u_(f x)=0.0296 R e_(f x)^0.8 $
- Для капельных жидкостей: $N u_(f x)=0.0296 R e_(f x)^0.8 P r_f^0.4 ((P r_f)/(P r_w))^0.25 $

При Ламинарном течении $alpha ~ x^(-0.5)$, при турбулентном - $alpha ~ x^(-0.2)$

$ overline(alpha) =1/L ( integral_0^(x "кр" 1) alpha_"лам" dd(x) + integral_(x "кр" 1)^(x "кр" 2) alpha_"мет" dd(x) + integral_(x "кр" 2)^(x "кр" L) alpha_"турб" dd(x) ) $

#figure(
  image("assets/metastable.png", width: 80%),
  caption: [],
) <fig-metastable>

Метастабильный член $approx 0$. $lambda_"лам"$ и $lambda_"турб" $ определяют по формулам зависимости $N u_(f x)$ от $R e_(f x)$ для обоих режимов. 

= Теплообмен при вынужденной конвекции в трубах и каналах. Профили скорости. Автомодельность. Начальный участок и участок стабилизированного течения. Ламинарный и турбулентный режимы. Теплообмен в турбулентном пограничном слое. Турбулентная теплопроводность. Интеграл Лайона. Уравнения подобия.

При течении жидкости в каналах возможно смывание пограничных слоёв, что отличает данный случай от неограниченной пластины.

$R e= (overline(w) d)/nu$ - характерный размер - диаметр. $overline(w) = G_V/F, F=(pi d^2)/4 $

$R e< 2300$ - ламинарный режим, $R e>10^4$ - турбулентный режим.

Профили скорости:

*Ламинарное течение*:\
Парабола Пуазейля:

$ w(y)=w_0 (1-(y/r_0)^2) $

*Турбулентное течение*:\
Трапецевидная форма, в ядре потока - автомодельность - нет зависимости значений функции от выбранного аргумента.

$ overline(w)/w_0 = f(R e_(d f)) $

При $R e_(d f)< 2300$ принимаем $overline(w)/w_0=0.5$. При $R e_(d f)$ см график.

#figure(
  image("assets/Avtomodal.png", width: 70%),
  caption: [],
) <fig-avtomodal>

Начальный участок и участок стабилизированного течения:

Ламинарный режим:\
На стенках труб появляется пограничный слой. Его толщина на начальном участке $l_0$ увеличивается до $delta_l=r_0$. Происходит смыкание пограничных слоёв.

#figure(
  image("assets/Laminar.png", width: 80%),
  caption: [],
) <fig-laminar>

Турбулентный режим:\
При турбулентном течении происходит смыкание турбулентных пограничных слоёв. Остаётся только вязкий подслой у стенки.

#figure(
  image("assets/TurbulentSloy.png", width: 80%),
  caption: [],
) <fig-turbulentsloy>

Теплообмен при ламинарном движении в трубах:\
При ламинарном течении теплота в радиальном направлении передаётся теплопроводностью, а в осевом - конвекцией. 

#figure(
  image("assets/TeploLam.png", width: 80%),
  caption: [],
) <fig-teplolam>

Распределение температур по параболе.

$L_(0 n)$ - дина участка стабилизации.
$L_(0 n)=0.05 d R e_(d f) P r_f$

$ alpha = -lambda ((pdv(T,n))|_(n=0))/(T_f-T_W) $

При $x<= l_(0 n) $ $(pdv(T,n))|_(n=0) $ убывает быстрее, чем $T_f=T_W=> alpha$ уменьшается.

При $x> l_(0 n) (pdv(T,n))|_(n=0) ~ T_f - T_W => alpha approx "const" $

Также рассматривают $overline(alpha)= overline(q)/(overline(T)_f-overline(T)_w), "  " overline(T_f) = 1/F integral_F T dd(F) $

#figure(
  image("assets/Napravlenia.png", width: 80%),
  caption: [],
) <fig-napravlenia>

$overline(L)_(0 n)> L_(0 n)$ - участок стабилизации для $overline(alpha) $

Интеграл Лайона:

Рассчитаем $alpha$ на участке стабилихированного теплообмена $(alpha="const")$ при граничных условиях второго рода $(q_w="const") $

При массовом расходе $G_m$ на элементе длинны $dd(x)$ по первому началу термодинамики:

$ C_(p f) G_M dd(overline(T)_f) = pi d alpha (T_W-T_f) dd(x) = q_W pi d dd(x), "  " d=2 r_0=> $
$ => dv(overline(T)_f,x)= (q_w pi d)/(C_(p f) G_m) = (4 q_w pi d)/(C_(p f) rho_f pi d^2 overline(w))= (2 q_w)/(C_(p f) rho_f r_0 overline(w))= "const"\ => overline(T)_f "при" q_w="const" "линейно растёт" $

$ overline(h) = (integral_F_0 rho_f w h difference(F))/(integral_F_0 rho_f w difference(F) ) $

Для несжимаемой жидксти $rho = "const", C_(p f)="const" => h= C_(p f) T_f$

$ overline(T)_f = (integral_F_0 w T_f dd(F))/(integral_F_0 w dd(F))= (integral_F_0 w T_f dd(F))/( overline(w) F_0 ) => overline(T)_f =2 integral_0^r_0 T w/overline(w) r/r_0 dd(r)/r_0=2 integral^1_0 T W R dd(R) $

Возьмём интеграл по частям:

$ overline(T)_f = T_w - 2 integral_0^1 (integral_0^1 W R dd(R)) dd(T) $

#math.equation(block: true, numbering: none)[$ C_(p f) rho_f (pdv(T,tau)+ w pdv(T,x)+ w_r pdv(T,r))=1/r pdv(,r)((lambda_f+lambda_T) r pdv(T,r)) + pdv(,x)((lambda_f+lambda_T)pdv(T,x)) $]

$lambda_f$ - теплопроводность\
$lambda_T$ - турбулентная теплопроводность

$pdv(T,tau)=0, "  " pdv(W,tau)=0 $ - на участке стабилизированного расчёта

$=> pdv(w_r,x)=0=>w_x="const" " на стенках " w=0=>w_r=0 $

Турбулентная теплопроводность:\
Теплоты, переносимую турбулентными пульсациями в пограничном слое, можно учесть в закон Фурье, добавив $lambda_T $ - турбулентная теплопроводность. $ overline(q)=- (lambda_f+lambda_T) grad T $

$ pdv(T,x,2)=0 => C_(p f) rho_f w pdv(T,x)= 1/r pdv(,r) ((lambda_f+lambda_T)r pdv(T,r)) $

На стабилизированном участке теплообмена, как $T_f$, так и $T$ меняются лейно => 

#figure(
  image("assets/IntegralChela.png", width: 80%),
) <fig-integralchela>


#figure(
  image("assets/Leden2.png", width: 80%),
) <fig-leden2>


#figure(
  image("assets/Leden3.png", width: 80%),
) <fig-leden3>

#figure(
  image("assets/Leden4.png", width: 80%),
) <fig-leden4>


#figure(
  image("assets/Leden5.png", width: 80%),
) <fig-leden5>

#figure(
  image("assets/Leden6.png", width: 80%),
) <fig-leden6>

колене и на расстоянии 10d, где вторичные течения затихают. При рассчёте каналов некруглого сечения можно пользоваться $d_"эфф"=(4F)/L $, F - площадь сечения, L - длина обогреваемой части сечения.

Только для определения $overline(alpha)$

= Теплообмен при поперечном обтекании труб и трубных пучков. Дорожка фон Кармана. Изменение коэффициента теплоотдачи по окружности трубы. Обтекание под углом, отличным от прямого. Трубные пучки, их параметры. Уравнения подобия для теплообмена в пучках.
#figure(
  image("assets/Kar1.png", width: 80%),
) <fig-kar1>

#figure(
  image("assets/Kar2.png", width: 80%),
) <fig-kar2>

// #figure(
//   image("assets/Kar3.png", width: 80%),
//   caption: [],
// ) <fig-kar3>

#figure(
  image("assets/Kar4.png", width: 80%),
) <fig-kar4>


#figure(
  image("assets/Kar5.png", width: 80%),
) <fig-kar5>


#figure(
  image("assets/Kar6.png", width: 80%),
) <fig-kar6>

Если $S_2->d$, то рассматривают течение в канале, если $S_2>>d$, рассматривают обтекание одиночной трубы.

Условия подобия для трубных пучков:

$ S_2/d approx 1...2 "  " 10^3 <=R e<= 2 dot 10^5 $

$ R e = (w_"уз" d)/nu, "  " w_"уз" "- скорость узкого сечения" $

Коридорный пучёк: 
$ overline(N u) = 0.27 R e^0.63 P r^0.36 epsilon_T, "  " epsilon_T = ((P r_f)/(P r_w))^0.2 $

Шахматный пучёк: $ S_1/S_2 <2 &=> overline(N u)=0.35 (S_1/S_2)^0.2 R e^0.6 P r^0.36 epsilon_T\ S_1/S_2>2 &=> overline(N u)=0.4 R e^0.6 P r^0.36 epsilon_T; "  " overline(N u)_(d f)=(overline(alpha) d)/lambda_f $

= Теплообмен при свободной конвекции. Физическая природа. Теплообмен на вертикальных поверхностях. Тепловой пограничный слой. Уравнения подобия для теплообмена. Режимы течения, их изменения по координате.

Движение при свободно конвективном теплообмене вызывается разностью плотностей между слоями.

Теплообмен на вертикальных поверхностях:

#figure(
  image("assets/Vert1.png", width: 80%),
) <fig-vert1>

#figure(
  image("assets/Vert2.png", width: 80%),
) <fig-vert2>


#figure(
  image("assets/Vert 3.png", width: 80%),
) <fig-vert-3>

Для турбулентного $N u_(x f)=0.6 R a_(x f)^0.5, "  " overline(N u)_(m f) = 0.15 R a_(m f)^0.33 $

Режимы течения:

Ra - число Релея - аналог числа Рейнольдса для конвективного теплообмена.
$ R a_( m f)< 10^3 ... 10^9 "- ламинарное,  " R a_(m f)> 6 dot 10^10 "- турбулентное" $

Тепловой пограничный слой и изменение режимов течения по координате:


#figure(
  image("assets/KoordinatTeol.png", width: 80%),
) <fig-koordinatteol>

= Теплообмен при свободной конвекции на горизонтальных поверхностях (пластин, труб, проволок). Уравнения подобия. Теплообмен в щелях и зазорах.

Пластина:\
Пластина может быть обращена горячей стороной как вверх, так и вниз. От пластины поднимаются нагретые струи воздуха.


#figure(
  image("assets/Plas1.png", width: 80%),
) <fig-plas1>


#figure(
  image("assets/plas2.png", width: 80%),
) <fig-plas2>


#figure(
  image("assets/plas3.png", width: 80%),
) <fig-plas3>

#figure(
  image("assets/plas4.png", width: 80%),
) <fig-plas4>

#figure(
  image("assets/plas5.png", width: 80%),
) <fig-plas5>

= Теплообмен при кипении. Физическая природа. Режимы и кризисы кипения. Кривая Нукиямы. Параметры паровых пузырьков: отрывной диаметр, частота отрыва, число центров парообразования.

Кипение - парообразование в объёме жидкости.\
Виды кипения:
+ Объёмное - парообразование во всём объёме жидкости (аварийный случай)
+ Поверхностное - образование пузырьков пара идёт только около поверхности нагрева.

Для начала парообразования должны присудствовать границы раздела фаз и центры парообразования.


#figure(
  image("assets/Lip1.png", width: 80%),
) <fig-lip1>


#figure(
  image("assets/Lip2.png", width: 80%),
) <fig-lip2>


#figure(
  image("assets/Lip3.png", width: 80%),
) <fig-lip3>


#figure(
  image("assets/Lip4.png", width: 80%),
) <fig-lip4>

+ Свободная конвекция
+ Пузырьковое кипение
+ Переходный режим. У поверности возникают паровые пятна, $q_w$ падает.
+ Пленочное кипение. У поверхности образуется паровая плёнка. $alpha="const"$, $q_w$ растёт.


#figure(
  image("assets/leded1.png", width: 80%),
) <fig-leded1>


#figure(
  image("assets/lwlelwel.png", width: 80%),
) <fig-lwlelwel>


#figure(
  image("assets/psdpd.png", width: 80%),
) <fig-psdpd>

$tau_p$ - время роста пузыря. $f=1/(tau_P+tau_o)$ - частота отрыва пузырей.

При $tau_0-> 0 f =1/tau_p$

N - число центров парообразования

При малых $q_w$ $N ~ q_w$

При $q_w=(0.5... 1.0) q_"w кр 1" N ~ q_2^(2.12)$

$L=-1/4 F_(mu J) F^(mu J)$

= Теплоотдача при пузырьковом кипении. Числа подобия. Основные уравнения подобия. Первая критическая плотность теплового потока: физический смысл и расчёт.


#figure(
  image("assets/kuttlq.png", width: 80%),
) <fig-kuttlq>


#figure(
  image("assets/dpdpdpdpdps.png", width: 80%),
) <fig-dpdpdpdpdps>

= Теплообмен при конденсации. Физическая природа. Угол смачивания и виды конденсации. Конденсация на вертикальной поверхности. Модель Нуссельта. Поправочные коэффициенты.

Поверхностная конденсация делится на два типа: капельную и плёночную:


#figure(
  image("assets/ldlldldl.png", width: 80%),
) <fig-ldlldldl>


#figure(
  image("assets/dssdsaswasxdsa.png", width: 80%),
) <fig-dssdsaswasxdsa>


#figure(
  image("assets/dwer.png", width: 80%),
) <fig-dwer>


#figure(
  image("assets/ooroor.png", width: 80%),
) <fig-ooroor>


#figure(
  image("assets/2025-01-21-02-32-10.png", width: 80%),
) <fig-2025-01-21-02-32-10>


#figure(
  image("assets/sdsdsews.png", width: 80%),
) <fig-sdsdsews>

= Конденсация на горизонтальных трубах. Конденсация на пучках труб. Конденсация внутри труб. Режимы течения двухфазных потоков. Капельная конденсация.

$ d=2 r_0, T_w="const", delta<< r_0, alpha = lambda'/delta $ - теплота передаётся теплопроводностью.


#figure(
  image("assets/sdxsw.png", width: 80%),
) <fig-sdxsw>


#figure(
  image("assets/sdsds.png", width: 80%),
) <fig-sdsds>


#figure(
  image("assets/drrrr.png", width: 80%),
) <fig-drrrr>


#figure(
  image("assets/rtrtr.png", width: 80%),
) <fig-rtrtr>


#figure(
  image("assets/tyuyyyy.png", width: 80%),
) <fig-tyuyyyy>


#figure(
  image("assets/iiiiii.png", width: 80%),
) <fig-iiiiii>


#figure(
  image("assets/ppppppppppp.png", width: 80%),
) <fig-ppppppppppp>


#figure(
  image("assets/tttggf.png", width: 80%),
) <fig-tttggf>


#figure(
  image("assets/trtrtresssa.png", width: 80%),
) <fig-trtrtresssa>


#figure(
  image("assets/xcxcdsxcds.png", width: 80%),
) <fig-xcxcdsxcds>


#figure(
  image("assets/uujujuxn.png", width: 80%),
) <fig-uujujuxn>

= Термосифоны и тепловые трубы.

Термосифон - замкнутая область, частично заполненная парами жидкости.


#figure(
  image("assets/llslsl.png", width: 80%),
) <fig-llslsl>


#figure(
  image("assets/dsdda.png", width: 80%),
) <fig-dsdda>


#figure(
  image("assets/iisiisis.png", width: 80%),
) <fig-iisiisis>


#figure(
  image("assets/saswsxcxs.png", width: 80%),
) <fig-saswsxcxs>

= Теплообменники. Классификация, виды расчёта. Уравнения теплового баланса и теплопередачи. Водяные эквиваленты. T – F – диаграммы. Средний температурный напор. Поправка Нуссельта. Коэффициент теплопередачи.

Теплообменники - устройства для передачи теплоты от горячего теплоносителя к холодному.

Классификация:
+ В смесительных теплообменниках теплота передаётся от горячего теплоносителя к холодному путём смешивания.
+ В поверхностных теплообменниках теплота передаётся от горячего теплоносителя к холодному через непроницаемую перегородку.

а) В регенеративных теплообменниках перегородка сначала нагревается горячим теплоносителем, а затем передаёт тепло холодному теплоносителю.
б) В рекуперативных теплообменниках перегородка одновременно контактируюет с горячим и холодным теплоносителями.

#grid(
  columns:(1fr,2fr),
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"11" , (0, 2),(0, 1), mark:(end: "stealth"))
      line(name:"111", (-1,0),(-2,0), mark:(end: "stealth"))
      line(name:"22" , (0,-1),(0,-2), mark:(end: "stealth"))
      line(name:"222", ( 2,0),( 1,0), mark:(end: "stealth"))

      content("11.mid" , $1'$ , anchor:"west", padding:0.1)
      content("111.mid", $1''$, anchor:"south", padding:0.1)
      content("22.mid" , $2'$ , anchor:"west", padding:0.1)
      content("222.mid", $2''$, anchor:"south-west", padding:0.1)

      line((1,1),(-1,-1),stroke:gray)
      rect((-1,-1),(1,1))
    })
  ),
  [
    1' - горячий теплоноситель на входе,\
    1'' - горячий теплоноситель на выходе,\
    2' - холодный теплоноситель на входе,\
    2'' - холодный теплоноситель на выходе 
  ]
)

Уравнения теплового баланса и теплопередачи для теплообменника:

$Q_1 = G_1 C_(p 1) (T_1'  - T_1'')$

$Q_2 = G_2 C_(p 2) (T_2'' - T_2' )$
$ Q=Q_1=Q_2=> G_1 C_(p 1) (T_1'  - T_1'')=G_2 C_(p 2) (T_2'' - T_2' ) $
Это уравнение теплового баланса (1 начало термодинамики)

$w_1=G_1 C_(p 1); "  " w_2 = G_2 C_(p 2) $ - полные теплоёмкости массового расхода теплоносителя (водяные эквиваленты).

$ (T_1' - T_1'')/(T_2'' - T_2')=w_2/w_2 $

#math.equation(block: true, numbering: none)[$ dd(Q)=k difference(T) dd(F); "  " Q= integral_0^F k difference(T) dd(F)= overline(k) Delta overline(T) F "- уравнение теплопередачи" $]

$K$ - коэффициент теплопередачи. Определяет $q$ переданное от горячего теплоносителя к холодному при единичной разнице температур.

#figure(
  image("assets/Obmenniki1.png", width: 80%),
) <fig-obmenniki1>


#figure(
  image("assets/Obmenniki2.png", width: 80%),
) <fig-obmenniki2>

Какой $w$ меньше, у того больше скорость возрастания температуры. $T-F$ диаграмма показывает изменение температур теплоносителей по длине трубы.

У прямоточного теплообменника всегда $T_1''>T_2''$

#figure(
  image("assets/Obmennik3.png", width: 80%),
) <fig-obmennik3>

Средний температурный напор. Поправка Нуссельта:

Рассмотрим прямоточный теплообменник типа "труба в трубе". 

$Delta overline(T)_л$ - среднелогарифмический температурный напор. (смотреть уравнение теплопередачи)

$Delta overline(T)_л = (T_б - T_м)/ln(T_б/T_м) $
$ Delta overline(T)_л^* = Delta overline(T)_л dot epsilon_(Delta T) "- поправка Нуссельта" $

Чем она ближе к 1, тем лучше теплообмен.


#figure(
  image("assets/T.png", width: 80%),
) <fig-T>

$ p=(T_2''-T_2')/(T_1'-T_1''), "  " R= (T_1'-T_1'')/(T_2''-T_2') $


#figure(
  image("assets/RP.png", width: 80%),
) <fig-rp>

= Эффективность теплообменников. Идеальный теплообменник. ε – NTU – диаграмма и NTU-метод расчёта.

Идеальный теплообменник - теплообменник типа "труба в трубе", противоточный с нулевым гидравлическим сопротивлением и бесконечно большой поверхностью теплообмена.

$ epsilon = Q/Q_"ид" "- эффективность теплообменника" $

$Q_"ид"$ берётся для сопоставимой площади теплообмена. 

$epsilon- N T U$ диаграмма и метод рассчета:

Для теплообменника, которого можно определить $W_min$ и $W_max$ применим этот метод расчёта. NTU - Number of Transfer Units. (количество переданных единиц)

$ epsilon = (1-e^((1 + W_min/W_max)N_min ))/(1+ W_min/W_max) $

$ N_min = (overline(K) F)/W_min $

#figure(
  image("assets/NTU1.png", width: 80%),
) <fig-ntu1>

= Гидравлический расчёт теплообменников. Потери давления. Мощность, расходуемая на перемещение теплоносителей

Тепловой расчет теплообменника дополняется гидравлическим расчётом.\
Мощность, расходуемая на преодоление гидравлических сопротивлений:
$ N_i = (G_i difference(P_(i xi)))/(overline(rho)_i eta); "  " i=1,2 "- нумерует холодный игорячий теплоноситель;" $

$difference(P)_(i xi)$ - потери давления от гидравлических сопротивлений;

$overline(rho)_i $ - средняя плотность теплоносителя;

$eta = 0.7 dots 0.8 $ - КПД насоса

= Теплообмен излучением. Физическая природа и особенности. Законы Кирхгофа и Стефана – Больцмана. Поглощательная, отражательная и пропускательная способность тел и сред. Абсолютно чёрное тело. Степень черноты.

Теплообмен ведётся посредством обмена электромагнитными волнами.

$lambda$ - длина волны; $nu$ - частота; $lambda nu = c=3 dot 10^8 "м"/"с"$

Особенности:
+ Происходит как при наличии, так и при отсуствии промежуточной среды между телами. Если среда не поглощает излучение, её наличие не влияет на теплообмен;
+ Тепловой поток зависит от всех тел, участвующих в теплообмене;
+ Тепловой поток определяется не разностью температур тел, а зависит от четвёртой степени их температур;
+ Тепловой поток определятется свойствами излучающих тел.

Поглощающая, отражающая и пропускательная способность тел:\
$Q_R$ - отражённое тепло;
$Q_A$ - поглощённое тепло;
$Q_D$ - пропущенное тепло.

По первому началу термодинамики:

$ Q=Q_A+Q_R+Q_D=> Q_A/Q+Q_R/Q+Q_D_Q=1=> R+A+D=1 $

- $R$ - отражательная способность тела.
  На зеркальных поверхностях отражение происходит по законам зеркальной оптики, на шероховатых - диффузионной.
- $A$ - поглощательная способность тела.
  Зависит от природы материала и $lambda$ падающего света
- $D$ - пропускательная способность тела.
  Только для стёкол и других прозрачных сред.
\

Идеальные тела:
+ $A=0, D=0, R=1$ - абсолютно белое тело;
+ $A=1, D=0, R=0$ - абсолютно чёрное тело;
+ $A=0, D=1, R=0$ - абсолютно прозрачное тело.
\

Степень черноты - отношение плотности потока собственного излучения тела к плотности потока излучения АЧТ.
$ epsilon = E_"соб"/E_0; "  " epsilon_lambda = E_lambda/E_lambda_"соб" "- спектиральная степень черноты" $

При расчёте $epsilon$ сравнивают плотность теплового потока, излучаемого во всём диапазоне частот, а при $epsilon_lambda$ - только при частоте $lambda$.

_Серое тело_ - тело, у которого $A<1$ и не зависит от температуры.

Закон Стефана-Больцмана:\
Плотность теплового потока АЧТ пропорциональна четвёртой степени его абсолютной температуры:

$ E_0 = sigma_0 T^4; "  " sigma_0 = 5.67 dot 10^(-8) "Вт"/("м"^2 "K") - "постоянная Стефана-Больцмана" $
\

Закон Кирхгофа:\
Отношение спектральной плотности теплового потока, излучаемого телом, к его спектральной поглощательной способности не зависит от природы тела.
$ ( E_lambda_"соб" (lambda,T) )/( A_lambda (lambda,T) ) $

Выоды из закона Кирхгофа:
+ Из всех тел больше всех излучает АЧТ;
+ Если тело не поглощает в данном интервале частот, то оно не излучает в нём;

= Теплообмен излучением в прозрачной среде. Теплообмен между параллельными серыми пластинами. Радиационные экраны. Инфракрасное излучение газов.

Теплообмен излучением между серыми пластинами:\
Две пластины с малым зазором.

$ q_(12) = C_0 epsilon_"пр" ( (T_1/100)^4 - (T_2/100)^4 ) $
$ epsilon_"пр" = 1/(1/epsilon_1 + 1/epsilon_2 - 1) "- приведённая степень черноты" $
$ epsilon_1, epsilon_2 > 0.7 dots 0.8 => epsilon_"пр" approx epsilon_1 epsilon_2 $

Радиационные экраны:
#grid(
  columns: (1fr, 1fr),
  figure(
    cetz.canvas({
      import cetz.draw: *
      set-style(
        mark: (
          transform-shape: false,
          fill: black
        )
      )

      line(name:"q1" , (0.3,2),(1.7,2), mark:(end: "stealth"))
      line(name:"q2" , (2.3,2),(3.7,2), mark:(end: "stealth"))
      line(name:"q12", (0.3,1),(3.7,1), mark:(end: "stealth"))

      content("q1.mid" ,  $q_(1 э)$, anchor:"south", padding:0.1)
      content("q2.mid" ,  $q_(2 э)$, anchor:"south", padding:0.1)
      content("q12.mid",  $q_(12)$ , anchor:"south-west", padding:0.1)

      line((2,0),(2,4),stroke:gray)
      line((0,0),(0,4))
      line((4,0),(4,4))

      content((0,2), $T_1,epsilon_1$, anchor:"south-east", padding:0.1)
      content((4,2), $T_2,epsilon_2$, anchor:"south-west", padding:0.1)
      content((2,3) ,  $Э$, anchor:"south", padding:0.1)
    })
  ),
  [
    #math.equation(block: true, numbering: none)[$ q_(1 э) = q_(2 э) $]
    #math.equation(block: true, numbering: none)[$ q_(1 э) = sigma_0 epsilon_"пр" (T_1^4 - T_э^4) $]
    #math.equation(block: true, numbering: none)[$ q_(2 э) = sigma_0 epsilon_"пр" (T_э^4 - T_2^4) $]
    #math.equation(block: true, numbering: none)[$ cases(
      T_э = root(4, (1/2 (T_1^4-T_э^4))),
      q_(12) = sigma_0 epsilon_"пр" (T_1^4-T_э^4)
    ) => q_(1 э) = q_(2 э) =1/2 q_(12) $]
  ]
)

Излучение серого газа. Особенности излучения газов:
+ Газы излучают и поглощают не поверхностью, а всем объёмом;
+ В инфракрасной области излучают только трёх- и многоатомные газы;
+ Излучение и поглощение объёма газа зависит от числа молекул, оказавшихся на пути луча. $L approx 3.6 V/F$ - путь луча в газе.


#figure(
  image("assets/Gas length.png", width: 80%),
  caption: [],
) <fig-gas-length>

$p$ - парциальное давление газа;
$l$ - путь луча в газе;
$ epsilon = epsilon_(H_2 O) + epsilon_(C O_2) - difference(epsilon) "- поправка на совместное действие газов" $

= Система «тело в оболочке». Угловые коэффициенты. Способы определения. Метод нитей.

$ Q_12 = Q_1 - phi_21 Q_2 $

$phi_21$ - угловой коэффициент. Показывает, какая доля излучения тела 2 попадает на тело 1.

$ Q_12 = C_0 / (1/epsilon_1 + phi_21 (1/epsilon_2 - 1) ) ( F_1 (T_1/100)^4 - phi_21 F_2 (T_2/100)^4 ) $

$ "Если" T_1 approx T_2: Q_12 = C_0 epsilon_"пр" F_1 ( (T_1/100)^4 - (T_2/100)^4 ) $

$ "Если" F_2 >> F_1: Q_12 = C_0 epsilon_1 F_1 ( (T_1/100)^4 - (T_2/100)^4 ) $

$ epsilon_"пр" =1/(1/epsilon_1 + 2/epsilon_2 -1) $
\

Угловые коэффициенты:
+ Свойство взаимности
  $ phi_12 F_1 = phi_21 F_2; "  " H_1=phi_12 F_1, H_2 = phi_21 F_2 $
  $H_1,H_2$ - взаимные поверхности излучения.
+ Рассмотрим систему из трёх поверхностей:\
  $E_1 = E_12 + E_13 + E_11$ - тепловой поток излучённый поверхностью 1.\
  $1=phi_12 + phi_13 + phi_11$; Если поверхность плоская, то $phi_11=0$.

  Если есть замкнутая система из n поверхностей, то:
  $ sum_(j=1)^n phi_(i j)=1 "- условие замкнутости" $

Способы определения угловых коэффициентов:
+ По таблицам;
+ Прямой расчет:
  #grid(
    columns:(1fr, 1fr),
    figure(
      image("assets/F_4.png", width: 80%),
      caption: [],
    ),
    [$E_1 F_1 phi_14 = E_1 F_1 phi_12 + E_1 F_1 phi_13 => phi_14 = phi_12 + phi_13$]
  )
+ Метод натянутых нитей;
#grid(
  columns: (1fr, 1fr),
  [
    #figure(
      image("assets/Niti.png", width: 80%),
      caption: [],
    ) <fig-niti>
  ],
  [
    + Соединяем хордами выступы поверхности 1;
    + Соединяе хордами выступы поверхностей 3,4 и 2;
    + Проведём диагонали $a d$ и $c f$;
    + Измеряем длины всех отрезков\
      $L_1 approx a g + g f$\
      $phi_12 = 1/(2L_1) ( (c f + a d) - (c b + b a) - (d e + e f) ) $
  ]
)

Угловой коэффициент равен полуразности сумм длинн диагоналей и непересекающихся отрезков, отнесённой к длине излучающей поверхности в плоскости чертежа.


