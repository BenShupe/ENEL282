#import "@preview/zap:0.5.0"

#set text(font: "New Computer Modern", size: 7.5pt)
#set par(leading: 0.42em, justify: false)
#set page(paper: "us-letter", margin: (x: 0.5cm, y: 0.5cm), columns: 3)

#show heading.where(level: 1): it => block(
  fill: black, width: 100%, inset: 3pt,
  text(fill: white, weight: "bold", size: 8.5pt, it.body)
)
#show heading.where(level: 2): it => block(
  fill: luma(230), width: 100%, inset: 2pt,
  text(weight: "bold", size: 7.5pt, it.body)
)

#let eq(..items) = block(width: 100%, inset: (y: 2pt),
  grid(columns: items.pos().len() * (1fr,), align: center, ..items.pos())
)

= Ch 1: Signals and Amplifier

== Gain Definitions
#eq($A_v = v_o / v_i$, $A_i = i_o / i_i$, $A_p = P_L / P_I = A_v A_i$)

Gain in dB:
#eq($A_i_"dB" = 20 log|A_i|$, $A_v_"dB" = 20 log|A_v|$, $A_p_"dB" = 10 log|A_p|$)


= Ch 2: Operational Amplifiers

#eq($V_d = V_2 - V_1$, $V_d = V_o/A$, [If $A arrow oo, V_d arrow 0$])

== Inverting Amplifier — Finite Gain
#eq($A arrow "finite"$, $V_1 = -V_o/A$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  // Input
  vsource("vi", (0, 0), (0, 2.5), label: $V_i$, variant: "ieee")
  earth("g1", (0, 0))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  
  // Feedback
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "east"))
  
  // Grounded non-inv
  wire((3.4, 1.5), (2.5, 1.5))
  earth("g2", (2.5, 1.5))
})))

== Inverting Amplifier — $oo$ Gain
#eq($A arrow oo$, $V_1 = 0$, $V_o / V_i = -R_2/R_1$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  vsource("vi", (0, 0), (0, 2.5), label: $V_i$, variant: "ieee")
  earth("g1", (0, 0))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "east"))
  
  wire((3.4, 1.5), (2.5, 1.5))
  earth("g2", (2.5, 1.5))
})))

== Non-Inverting Amplifier — Finite Gain
#eq($A arrow "Finite"$, $V_1 = V_i - V_o/A$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  // Input to V+
  vsource("vi", (2, 0), (2, 1.5), label: $V_i$, variant: "ieee")
  earth("g1", (2, 0))
  wire((2, 1.5), (3.4, 1.5))
  
  // Feedback to V-
  earth("g2", (0, 2.5))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "west"))
})))

\ 
== Non-Inverting Amplifier — $oo$ Gain
#eq($A arrow oo$, $V_1 = V_i$, $V_o/V_i = 1 + R_2/R_1$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  vsource("vi", (2, 0), (2, 1.5), label: $V_i$, variant: "ieee")
  earth("g1", (2, 0))
  wire((2, 1.5), (3.4, 1.5))
  
  earth("g2", (0, 2.5))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  node("v1", (2.8, 2.5), label: (content: $V_1$, anchor: "south"))
  
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "east"))
})))

== Ideal Op-Amp Model
#eq($V_o = A(v_+ - v_-)$)
#eq($A arrow oo$, $R_i arrow oo$, $R_o arrow 0$)
#eq($V_"d" = v_+ - v_-$)

== Inverting Configuration
- *Closed-Loop:* $G equiv v_o / v_I = -R_2 / R_1$
- *Open-Loop:* $G = (-R_2 / R_1) (1 + (1 + R_2 / R_1) / A)^(-1)$
- *Input Impedance:* $R_"in" = R_1$
- *Virtual Ground:* $v_- = -v_o / A approx 0$

== Non-Inverting Configuration
- *Closed-Loop:* $G equiv v_o / v_I = 1 + R_2 / R_1$
- *Open-Loop:* $G = (1 + R_2 / R_1) (1 + (1 + R_2 / R_1) / A)^(-1)$
- *Input Impedance:* $R_"in" = oo$