#let boxed = x => table([#x])
#let pdf = (src, pages:1) => (
  for page_num in range(pages) {
    image(src, page: page_num+1)
  }
)
#align(center, [
= ENEL 282 — QUIZ 7
== Date: April 02, 2026
= Limiter Circuit Quiz
== Total: 30 points
])

== Given Information
A limiter circuit in the below figure uses a 1N4001 diode with the following specifications:

- $V_+ = 5$V
- $R = 450 Omega$
- Practical diode forward voltage drop: $V_D = 0.7$V

#align(center, image("image.png", width: 40%))

Answer all questions clearly. Show all your calculations with proper units. Submit all the datasheets
you used to get the values along with your submission.
#pagebreak()
== Questions
=== (a) Search for the datasheet of the 1N4001 diode and find the maximum (peak) reverse voltage. Report the value with units. (3 points)
According to the fairchild datasheet I found from 2014, the peak reverse voltage $V_"RRM"$ of the 1N4001 diode is $50$V.
=== (b) From the same datasheet, find the maximum forward rectified current. Report the value with units. (3 points)
According to that same datasheet the maximium average rectified current $I_"F(AV)"$ is $1.0$A
=== (c) Highlight the two values in the datasheet and submit it with your answer. (2 points)

#align(center, boxed(pdf("1N4001.pdf", pages:2)))
=== (d) Calculate the minimum input voltage $V_I("min")$ that can be safely applied to the circuit. Show your work. (3 points)

$
  V_D < V_"RMM"\
  V_D = V_+ - V_I\
  V_+ - V_I < V_"RMM"\
  -V_I< V_"RMM" - V_+\
  V_I> V_+ - V_"RMM"\
  V_I("min") = 5"V" - 48"V"\
  #boxed($V_I("min") = -43"V"$)
$

=== (e) Calculate the maximum input voltage $V_I("max")$ that can be safely applied to the circuit. Show your work. (3 points)

$
  I_D < I_"F(AV)"\
  (V_I-V_+-V_D)/R < I_"F(AV)"\
  V_I < V_D+V_++I_"F(AV)"R\
  V_I("max") = 1.1"V" + 5"V" +(1.0"A")(450 Omega)\
  #boxed($V_I("max") = 456.1"V"$)
$

=== (f) State the complete safe operating range for the input voltage $V_I$. (2 points)
$
  -43"V" <= V_I <= 456.1"V"
$
=== (g) Explain why the diode forward voltage drop must be included in one calculation but not the other. (2 points)

Forward voltage drop only applies when voltage is being applied in the forward direction. Since $V_I("min")$ is negative voltage drop does not need to be considered

=== (h) If you were to replace the 1N4001 with a 1N4007 diode, how would the safe operating range change? Find the 1N4007 specifications and explain your answer. Submit the 1N4007 datasheet as well after highlighting the two values. (5 points)

According to the same datasheet, for a 1N4007 diode, $V_"RMM" = 1000$V and $I_"F(AV)" = 1.0$A. 
$
  V_I("max") = V_D+V_++I_"F(AV)"R = 1.1"V" + 5"V" + (1.0"A")(450 Omega) \
  V_I("max") = 456.1"V"\

  V_I("min") = V_+ - V_"RMM" = 5"V" + 1000"V"\
  V_I("min") = -995"V"\
  #boxed($-995"V"<=V_I<=456.1"V"$)
$

=== (i) Of the two datasheet parameters identified in Parts (a) and (b), which one was more difficult to interpret correctly? Explain why this parameter was challenging. Then describe two specific resources where you would find authoritative information about this parameter for future reference. (3 point)

The more difficult to interpret parameter was $I_"F(AV)"$, aka maximum rectified forward current. This was challenging because the datasheet lists two forward current values ($I_"F(AV)"$ and $I_"FSM"$). Looking at the course textbook,

=== (j) If measurements showed the actual forward voltage was 0.9 V instead of 0.7 V, describe one potential cause and propose how you would investigate it experimentally. (4 point)

