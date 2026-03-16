#set page(margin: 2cm, paper: "a4")
#set text(font: "Open Sans", size: 10.5pt)
#set heading(numbering: none)
#set par(justify: true)

#show heading.where(level: 1): it => {
  v(0.6em)
  text(font: "Lato", size: 16pt, weight: "bold", fill: rgb("#1a1a2e"))[#it.body]
  v(0.3em)
  line(length: 100%, stroke: 1.5pt + rgb("#e0e0e0"))
  v(0.3em)
}

#align(center)[
  #text(font: "Lato", size: 24pt, weight: "bold", fill: rgb("#1a1a2e"))[Portable Speaker Recommendations]
  #v(0.2em)
  #text(size: 11pt, fill: rgb("#666"))[March 2026 #sym.dot.c Israel Market Pricing]
]

#v(1.2em)

= Why Your Current Speaker Falls Short

Your *Sony SRS-XB13* outputs roughly *5W from a single 46mm driver*. That's designed for arm's-length personal listening --- not filling a room so two people can comfortably hear a podcast from different positions.

What you actually need:

#block(inset: (left: 16pt))[
  - *20--30W output* --- enough headroom to fill a living room at moderate volume without distortion
  - *Good midrange clarity* --- podcasts are almost entirely voice; bass is irrelevant, mids are everything
  - *Wide dispersion* --- 360-degree or dual-driver stereo so it doesn't matter where you're sitting
]

#v(0.3em)

The picks below all meet these criteria. Each card includes a *volume comparison* against your XB13 so you know exactly what you're gaining.

#v(0.4em)

= Top 5 Recommendations

#let db_icon(db_gain) = {
  let color = if db_gain >= 10 { rgb("#1b7a1b") } else if db_gain >= 7 { rgb("#3a8a3a") } else { rgb("#5a9a5a") }
  box(
    inset: (x: 8pt, y: 4pt),
    radius: 3pt,
    fill: color,
    text(fill: white, weight: "bold", size: 9pt)[+#db_gain dB vs XB13]
  )
}

#let perceived(factor) = {
  box(
    inset: (x: 8pt, y: 4pt),
    radius: 3pt,
    fill: rgb("#2c3e6b"),
    text(fill: white, weight: "bold", size: 9pt)[~#factor#sym.times perceived loudness]
  )
}

#let pick(rank, name, watts, db_gain, loudness_factor, why_fits, where, local_price, rrp_international, value_note) = {
  block(
    width: 100%,
    inset: 14pt,
    radius: 6pt,
    stroke: 0.6pt + rgb("#d0d0d0"),
    fill: if rank == 1 { rgb("#f4faf4") } else { rgb("#fafbfc") },
  )[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [#text(font: "Lato", weight: "bold", size: 14pt, fill: rgb("#1a1a2e"))[#rank. #name] #h(6pt) #text(fill: rgb("#888"), size: 10pt)[#watts]
       #if rank == 1 [ #h(6pt) #box(inset: (x: 6pt, y: 3pt), radius: 3pt, fill: rgb("#1b7a1b"), text(fill: white, weight: "bold", size: 8pt)[BEST PICK])]],
      [#db_icon(db_gain) #h(4pt) #perceived(loudness_factor)],
    )
    #v(0.5em)

    #block(inset: (left: 2pt))[
      #text(fill: rgb("#444"), size: 10pt)[
        #text(weight: "bold", fill: rgb("#1a1a2e"))[Fit:] #why_fits
        #v(0.3em)
        #text(weight: "bold", fill: rgb("#1a1a2e"))[Buy from:] #where
        #v(0.3em)
        #grid(
          columns: (1fr, 1fr),
          [#text(weight: "bold", fill: rgb("#1a1a2e"))[Local price:] #local_price],
          [#text(weight: "bold", fill: rgb("#1a1a2e"))[Int'l RRP:] #rrp_international],
        )
        #v(0.3em)
        #text(weight: "bold", fill: rgb("#1a1a2e"))[Value:] #value_note
      ]
    ]
  ]
  v(0.5em)
}

#pick(
  1,
  [JBL Flip 7],
  [30W],
  8,
  [2.5--3],
  [30W output, 360-degree sound, excellent vocal clarity. Easily fills a living room at 40--50% volume. IP67. \~12h battery. Compact cylinder that moves room to room. The benchmark for this category.],
  [*KSP ₪349* (Eilat ₪296) #sym.bar.v Ivory ₪399 (Eilat ₪338)],
  [₪349 at KSP],
  [\~\$130 / ₪480],
  [*27% below international RRP.* The sweet spot of price, size, and performance.],
)

#pick(
  2,
  [Sony ULT Field 1],
  [\~14W],
  5,
  [1.8--2],
  [Direct successor to your XB line. Larger driver + passive radiator for proper room sound. Great speech clarity from Sony's audio tuning. 12h battery. IP67. Stays in the Sony ecosystem you already know.],
  [*KSP ₪334* (Eilat ₪283) #sym.bar.v Ivory ₪374 (Eilat ₪316)],
  [₪334 at KSP],
  [\~\$128 / ₪470],
  [*29% below international RRP.* Cheapest of the top picks locally. Natural upgrade from your XB13.],
)

#pick(
  3,
  [Tribit StormBox 2],
  [34W],
  9,
  [3],
  [More raw power than the Flip 7 at a fraction of the price. IPX7, 24h battery. Tribit is the best-regarded budget speaker brand. Mids are a step below JBL/Sony but volume and battery are unbeatable for the money.],
  [*AliExpress \$57.19* (\~₪210)],
  [\~₪210 (AliExpress)],
  [\~\$80 / ₪295],
  [*29% below RRP.* Absolute value king. Trade-off: no local warranty, \~3 week shipping.],
)

#pick(
  4,
  [Xiaomi Sound Outdoor],
  [30W],
  8,
  [2.5--3],
  [30W in a compact rectangular body. Good midrange for voice. Mi Home app integration. The cheapest local option that fully meets the spec. Walk into KSP and walk out with it today.],
  [*KSP ₪249* (Eilat ₪211)],
  [₪249 at KSP],
  [\~\$60 / ₪220],
  [*At or near international RRP* --- no discount but no markup. ₪100 less than the Flip 7 with the same wattage.],
)

#pick(
  5,
  [JBL Charge 6],
  [30W+],
  9,
  [3],
  [JBL's premium portable. Doubles as a *USB-C power bank* --- handy during a move. \~20h battery (charge it once a week). Larger body = richer sound and better room coverage. Overkill for podcasts alone but great if you also play music.],
  [*KSP ₪489* (Eilat ₪414) #sym.bar.v Ivory ₪506 (Eilat ₪428)],
  [₪489 at KSP],
  [\~\$170 / ₪625],
  [*22% below international RRP.* Only worth the premium if you need the powerbank or marathon battery. The Flip 7 gives 90% of the sound at 70% of the price.],
)

#v(0.3em)

= Volume Comparison Explained

Perceived loudness does not scale linearly with wattage. A rough guide:

#table(
  columns: (auto, auto, auto, auto),
  align: (left, center, center, center),
  stroke: 0.5pt + rgb("#d0d0d0"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a1a2e") } else if calc.odd(row) { rgb("#f5f6f8") } else { white },
  text(fill: white, weight: "bold")[Speaker],
  text(fill: white, weight: "bold")[Output],
  text(fill: white, weight: "bold")[dB gain vs XB13],
  text(fill: white, weight: "bold")[Perceived loudness],
  [Sony SRS-XB13 _(current)_], [5W], [---], [1#sym.times _(baseline)_],
  [Sony ULT Field 1], [\~14W], [\~+5 dB], [\~1.8--2#sym.times],
  [JBL Flip 7], [30W], [\~+8 dB], [\~2.5--3#sym.times],
  [Xiaomi Sound Outdoor], [30W], [\~+8 dB], [\~2.5--3#sym.times],
  [Tribit StormBox 2], [34W], [\~+9 dB], [\~3#sym.times],
  [JBL Charge 6], [30W+], [\~+9 dB], [\~3#sym.times],
)

#text(size: 9pt, fill: rgb("#888"))[
  _dB estimates account for driver efficiency differences, not just wattage. The Charge 6 gets extra dB from its larger driver despite similar wattage to the Flip 7. Real-world room-filling volume depends on room size, positioning, and content --- these are approximate comparisons._
]

#v(0.5em)

= Price Comparison

#table(
  columns: (auto, auto, auto, auto, auto),
  align: (left, right, right, right, right),
  stroke: 0.5pt + rgb("#d0d0d0"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a1a2e") } else if calc.odd(row) { rgb("#f5f6f8") } else { white },
  text(fill: white, weight: "bold")[Speaker],
  text(fill: white, weight: "bold")[Best Local],
  text(fill: white, weight: "bold")[Int'l RRP],
  text(fill: white, weight: "bold")[Savings],
  text(fill: white, weight: "bold")[Output],
  [JBL Flip 7], [₪349 (KSP)], [\~₪480], [27%], [30W],
  [Sony ULT Field 1], [₪334 (KSP)], [\~₪470], [29%], [\~14W],
  [Tribit StormBox 2], [\~₪210 (Ali)], [\~₪295], [29%], [34W],
  [Xiaomi Sound Outdoor], [₪249 (KSP)], [\~₪220], [0%], [30W],
  [JBL Charge 6], [₪489 (KSP)], [\~₪625], [22%], [30W+],
)

#v(0.8em)

= Bottom Line

#block(
  width: 100%,
  inset: 16pt,
  radius: 6pt,
  stroke: 1.5pt + rgb("#1b7a1b"),
  fill: rgb("#f4faf4"),
)[
  #text(font: "Lato", weight: "bold", size: 13pt, fill: rgb("#1a1a2e"))[Buy the JBL Flip 7 from KSP at ₪349.]

  #v(0.3em)

  It's 2.5--3#sym.times louder than your XB13, has excellent speech clarity for podcasts, is the right size for carrying between rooms, and KSP's price is 27% below international RRP.

  #v(0.2em)

  *Tight budget?* Xiaomi Sound Outdoor at ₪249 from KSP --- same wattage, ₪100 less. \
  *Maximum value?* Tribit StormBox 2 at \~₪210 from AliExpress --- most power for the least money. \
  *Want to stay Sony?* ULT Field 1 at ₪334 from KSP --- natural upgrade, best RRP discount.
]

#v(1em)
#align(center, text(size: 8.5pt, fill: rgb("#aaa"))[
  Generated from Bug, KSP, Ivory, and AliExpress catalog screenshots (March 2026). \
  Prices may vary. International RRP estimated from USD conversion at \~₪3.68/\$. \
  Volume comparisons are approximate and account for driver size and efficiency, not just rated wattage.
])
