/*:
 ![Page 2 Header](Page2_Heading.png)
 
 In order to understand the steps of the algorithms we’ll be building **PLANETS**! And our goal is to have a planet that is pretty suitable for life (just like earth 😉).

 Each individual has some characteristics, these are called **Genes**.
 
 Our planets have four genes:
 - 􀠒: Amount of **Water**
 - 􀀀: Thickness of the **Atmosphere**
 - 􀆮: Amount of **Solar Energy**
 - 􀵀: Amount of **Nutrients**

 Now we can go through the algorithm **step by step**:
 ---
 * Callout(1º Population:):
 When the algorithm starts, a completely **random population** is created. At this step, there is a low probability of having well adapted individuals, but hold on, the next steps will take care of this.
 ---
 * Callout(2º Selection:):
 With a population in hand, it is time to **select the fittest ones**, and in order to do that, we are gonna need a **fitness function**.
 The fitness function associates a numeric value to each individual, that represents how fit it is to the problem we are solving.
 In our case, the most well adapted planets are the ones with more green bars, representing that its values matches the ones that are suitable for life.
 ---
 * Callout(3º Crossover:):
 Now that we have the most well adapted individuals of the initial population, we need to generate a new one that looks more like them. To do that, we’ll choose two random individuals of our fittest ones and cross its characteristics to generate a brand-new individual that have a higher probability of being well adapted to the problem.
 This process is called “**crossover**”, and it is repeated until all the members of the original population have been replaced by new ones.
 ---
 * Callout(4º Repeat:):
 Once we have a new population based on crossovers, we can do it all over again, and in each generation our individuals are gonna be more well adapted.
 But when should we stop?
 Well, there is not a rule about that, you should stop when the top individuals suit your needs.
*/
//#-hidden-code
import PlaygroundSupport
import UIKit
import BookCore
PlaygroundPage.current.liveView = Page2_LiveViewController()
//#-end-hidden-code
