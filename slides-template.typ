#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
)

#set text(font: "Inter", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 350)
#set par(justify: true)

#set raw(tab-size: 4)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 1em,
  radius: 0.7em,
  width: 100%,
)

#let author = box[
  #table(inset: 0.5em, stroke: none, columns: (1fr, auto),  align: (left, right),
    [*Davide Domini*], [davide.domini\@unibo.it],
    [PhD Student \@ UNIBO]
  )
]


#title-slide(
  title: "Field Based Federated Learning",
  subtitle: "",
  author: author,
  //date: datetime.today().display("[day] [month repr:long] [year]"),
)

#new-section-slide("Background on Federated Learning")

#slide(title: "Computation everywhere")[
  #figure(
    image("imgs/uc.svg", width: 65%)
  )
]

#slide(title: "Example: Google Virtual Keyboard")[
  #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      - *Task*: Next word prediction for GBoards
      - *Problem*: Users' privacy
      - *Solution*: Share weights not data
    ],
    [
      #figure(
        image("imgs/keyboard.svg", width: 70%)
      )
    ]  
  )
]

#slide(title: "What Federated Learning is?")[
 #figure(
    image("imgs/federated-learning-schema.svg", width: 50%)
  )
]

#slide(title: "How can we aggregate local models?")[

  #figure(
    image("imgs/fedavg.svg", width: 50%)
  )

]

#let check = box[ #figure(
    image("imgs/checkmark.svg", width: 6%)
  )]

#let cross = box[ #figure(
    image("imgs/crossmark.svg", width: 6%)
  )]

#slide(title: "Pros & Cons")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      #check Reduces privacy concerns

      #check Transfers less data to the server
    ],
    [
      #cross Need for a central trusted entity

      #cross Single point of failure

      #cross Data heterogeneity 
    ]  
  )

]

#slide(title: "Towards peer-to-peer Federated Learning")[
  #figure(
    image("imgs/federated-learning-schema-p2p.svg", width: 50%)
  )
]

#slide(title: "How can we address data heterogeneity?")[
  - Adding a regularization term to classic FL algorithms @scaffold @fedprox
  - #underline[*Personalized*] Federated Learning
    - #underline[*Cluster level*] @hcfl @ecfl @tapfl
    - Client level @atldd @dasbct @dalba
    - Graph level @fedu @pflwg @9832778
]


#new-section-slide("Field based coordination for Federated Learning")

#slide(title: "Why field based coordination?")[
  - Global-level system behaviour captured declaratively 

  - Seamlessly transition between fully centralized and fully decentralized aggregation methods

  - Coordination mechanisms to take into account spatial distribution of devices
  
  - Benefits of semantically similar knowledge among nearby devices
]


#slide(title: "Full peer-to-peer learning")[
  ```scala
  rep(init() )(model => { // Local model initialization
    // 1. Local training
    model.evolve(localEpochs)
    // 2. Model sharing
    val info = foldhood(Set(model))(_ ++ _)(nbr(model))
    // 3. Model aggregation
    aggregation(info)
  })
  ```  
]

#slide(title:"SCR Pattern for Federated Learning")[

    #figure(
      image("imgs/FL-SCR.svg", width: 110%)
    )
 
]

#slide(title: "Learning in zones")[
  ```scala
  val aggregators = S(area, nbrRange) // Dynamic aggregator selection
  rep(init())(model => { // Local model initialization
    model.evolve() // 1. Local training step
    val pot = gradient(aggregators) // Potential field for model sharing
    // 2. model sharing
    val info = C[Double, Set[Model]](pot, _ ++ _, Set(model), Set.empty)
    val aggregateModel = aggregation(info) // 3. Aggregation
    sharedModel = broadcast(aggregators, aggregateModel) // 4. Gossiping
    mux(impulsesEvery(epochs)){ combineLocal(sharedModel, model) } { model }
  })
  ```
]

#let adv = box[ #figure(
    image("imgs/checkmark.svg", width: 2%)
  )]

#slide(title: "Advantages")[
 
 #adv Dynamic number of clusters

 #adv Decentralized clustering

 #adv Supports both peer-to-peer interactions and the formation of specialized zones

 #adv Enables dynamic model aggregation without a centralized authority

 #adv Exploits spatial distribution of the devices

]

#new-section-slide("Proximity-based Self-FL")

#slide(title: "Scenario (?)")[
  //#table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
  #table(inset: (0.3em, 0.5em), stroke: none, columns: (2fr, 2fr, 2fr), align: (center, center),
      [
        #figure(
          image("imgs/zones.svg", width: 112%)
        )
      ],
      [
        #figure(
          image("imgs/zones2.svg", width: 112%)
        )
      ],
      [
        #figure(
          image("imgs/zones3.svg", width: 112%)
        )
      ]  
  )
]

#new-section-slide("Future Work")

#slide(title: "What's next?")[
  - More exploration with non-iid data
  - Space fluidity
  - Sparse neural networks for low resource settings
]

#slide[
  #bibliography("bibliography.bib")
]