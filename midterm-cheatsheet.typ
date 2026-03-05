#import "@preview/zap:0.5.0"

#set text(font: "New Computer Modern", size: 9.6pt)
#set par(leading: 0.42em, justify: false)
#set page(paper: "us-letter", margin: (x: 0.5cm, y: 0.5cm), columns: 2)

#show heading.where(level: 1): it => block(
  fill: black, width: 100%, inset: 3pt,
  text(fill: white, weight: "bold", size: 10.5pt, it.body)
)
#show heading.where(level: 2): it => block(
  fill: luma(230), width: 100%, inset: 2pt,
  text(weight: "bold", size: 9.5pt, it.body)
)

#let eq(..items) = block(width: 100%, inset: (y: 2pt),
  grid(columns: items.pos().len() * (1fr,), align: center, ..items.pos())
)

*Name: $"___________________________"$*

= Ch 1: Signals and Amplifier

== Gain Definitions
#eq($A_v = v_o / v_i$, $A_i = i_o / i_i$, $A_p = P_L / P_I = A_v A_i$)

Gain in dB:
#eq($A_i_"dB" = 20 log|A_i|$, $A_v_"dB" = 20 log|A_v|$, $A_p_"dB" = 10 log|A_p|$)


= Ch 2: Operational Amplifiers

#eq($V_d = V_2 - V_1$, $V_d = V_o/A$, [If $A arrow oo, V_d arrow 0$])

== Ideal Op-Amp Model
#eq($V_o = A(v_+ - v_-)$)
#eq($A arrow oo$, $R_i arrow oo$, $R_o arrow 0$)
#eq($V_"d" = v_+ - v_-$)

== Inverting Configuration
- *Closed-Loop:* $G = v_o / v_I = -R_2 / R_1$
- *Open-Loop:* $G = (-R_2 / R_1) (1 + (1 + R_2 / R_1) / A)^(-1)$
- *Input Impedance:* $R_"in" = R_1$
- *Virtual Ground:* $v_- = -v_o / A approx 0$

== Non-Inverting Configuration
- *Closed-Loop:* $G = v_o / v_I = 1 + R_2 / R_1$
- *Open-Loop:* $G = (1 + R_2 / R_1) (1 + (1 + R_2 / R_1) / A)^(-1)$
- *Input Impedance:* $R_"in" = oo$



== Inverting Amplifier — Finite Gain
#eq($A arrow "finite"$, $V_1 = -V_o/A$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  // Input
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  node("v1", "r1.in", label: $V_I$)

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
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee") 
  node("v1", "r1.in", label: $V_I$)
  
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
  wire((2, 1.5), (3.4, 1.5))
  node("V1", (2,1.5), label: (content: $V_i$, anchor: "west"))
  
  // Feedback to V-
  earth("g2", (0, 2.5))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "east"))
})))


== Non-Inverting Amplifier — $oo$ Gain
#eq($A arrow oo$, $V_1 = V_i$, $V_o/V_i = 1 + R_2/R_1$)

#align(center, scale(80%, zap.circuit({
  import zap: *
  opamp("oa", (4, 2), variant: "ieee")
  wire((2, 1.5), (3.4, 1.5))
  node("V1", (2, 1.5), label: (content: $V_i$, anchor: "west"))
  
  earth("g2", (0, 2.5))
  resistor("r1", (0, 2.5), (3.4, 2.5), label: $R_1$, variant: "ieee")
  node("v1", (2.8, 2.5), label: (content: $V_1$, anchor: "south"))
  
  wire((2.8, 2.5), (2.8, 4))
  resistor("rf", (2.8, 4), (5.5, 4), label: $R_2$, variant: "ieee")
  wire((5.5, 4), (5.5, 2))
  wire("oa.out", (6, 2))
  node("vo", (6, 2), label: (content: $V_o$, anchor: "east"))
})))

= Ch 3: Semiconductors

== Basic Definitions
#eq($sigma = 1 / rho$, $R = rho (L / A)$)
#eq([Resistivity ($rho$): $Omega dot "cm"$], [Conductivity ($sigma$): $(Omega dot "cm")^(-1)$])

== Intrinsic Semiconductors
#eq($n = p = n_i$, $n_i = B T^(3/2) e^(-E_g / (2 k T))$)

== Doped Semiconductors
#eq($n p = n_i^2$)
#eq($n_n approx N_D$, $p_n = n_i^2 / N_D$)
#eq($p_p approx N_A$, $n_p = n_i^2 / N_A$)

== Current Flow
// #eq($J_"drift" = q(n mu_n + p mu_p)E$)
// #eq($J_"diff" = q D_n (d n)/(d x) - q D_p (d p)/(d x)$ )
#eq($D / mu = (k T) / q = V_T arrow.l "Einstien Relation"$) 

== Universal Physical Constants
#eq($q = 1.602 times 10^(-19) " C"$, $k = 8.62 times 10^(-5) (e V) / K$)
#eq($V_T = (k T) / q approx 25.9 " mV at 300K"$)
#eq($"Kelvin" = "Celcius" + 273.15 degree$)

== Silicon Material Properties (300K)
#eq($E_g = 1.12 " eV"$, $n_i approx 1.5 times 10^10 " cm"^(-3)$)
#eq($B=7.3 times 10^(13)"cm"^(15) K^(-3/2)$)