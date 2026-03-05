/*
Q1: 5 MCQ (2 marks each)
Q2: from Ch-1
Q3: from Ch-2
Q4: from Ch-2
Q5: from Ch-3
Q6: from Ch-3
Q7: Ch-1 (derivation/proof/show that)
*/

#import "@preview/zap:0.5.0"

#set text(font: "New Computer Modern", size: 7.5pt)
#set par(leading: 0.42em, justify: false)
#set page(paper: "us-letter", margin: (x: 0.4cm, y: 0.4cm), columns: 3)

#set heading(numbering: none)
#show heading.where(level: 1): it => block(
  fill: black, width: 100%, inset: 2pt,
  text(fill: white, weight: "bold", size: 8.5pt, it.body)
)
#show heading.where(level: 2): it => block(
  fill: luma(200), width: 100%, inset: 1.5pt,
  text(weight: "bold", size: 7.5pt, it.body)
)
#show heading.where(level: 3): it => text(weight: "bold", size: 7pt, underline(it.body))

#let eq(body) = block(inset: (left: 2pt, y: 1pt), body)



= Ch 1: Signals and Amplifier

== Gain Definitions

#eq[$A_v = v_o / v_i$ #h(1em) $A_i = i_o / i_i$ #h(1em) $A_p = P_L / P_I = A_v A_i$]

Gain in dB:
#eq[$A_i_"dB" = 20 log|A_i|$ #h(0.5em) $A_v_"dB" = 20 log|A_v|$ #h(0.5em) $A_p_"dB" = 10 log|A_p|$]

= Ch 2: Operational Amplifiers


#zap.circuit({
  import zap: *

  opamp("o2", (3, 0), variant: "ieee")
})
