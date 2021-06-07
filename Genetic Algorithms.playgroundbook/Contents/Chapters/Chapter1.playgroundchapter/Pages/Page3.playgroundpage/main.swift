/*:
 ![Page 3 Header](Page3_Heading.png)

 Genetic algorithms are typically utilized for generating high-quality solutions for search and optimization problems by depending on bio-oriented operators such as selection, crossover, and mutation.

 The problem of filling a container with a set of items respecting its weight limit and maximizing its value, is called the **Unbounded Knapsack Problem**, and is vastly discussed in the scientific community.

 To illustrate this, we have a container with a weight limit of **20 tons** and the following set of **Apple products**:

 ![IPhone](Mini_Box_IPhone.png) 􀄫 **IPhone**
 
 􀄵 Weight: 230g | Value: 1100
 
 ![IPhone with Charger](Mini_Box_Charger.png) 􀄫 **IPhone with Power Adapter**
 
 􀄵 Weight: 350g | Value: 1120
 
 ![IPad Pro](Mini_Box_IPadPro.png) 􀄫 **IPad Pro**
 
 􀄵 Weight: 650g | Value: 1000
 
 ![Apple Watch](Mini_Box_Watch.png) 􀄫 **Apple Watch**
 
 􀄵 Weight: 180g | Value: 400
 
 ![Macbook Pro](Mini_Box_MacBookPro.png) 􀄫 **Mac Book Pro**
 
 􀄵 Weight: 2000g | Value: 2400
 
 ![AirPods Max](Mini_Box_AirPodsMax.png) 􀄫 **AirPods Max**
 
 􀄵 Weight: 400g | Value: 550
 
 The goal is to find out the better combination of items and its quantities in order to make the container more profitable!
 
 Feel free to change the values bellow to try a better solution:
 ---
*/
//#-hidden-code
import PlaygroundSupport
import UIKit
import SwiftUI
import BookCore
//#-end-hidden-code
/*:
 **populationSize** 􀄫 The number of individuals in the population.
*/
var populationSize: Int = /*#-editable-code*/500/*#-end-editable-code*/
/*:
 **generationNumber** 􀄫 The number of genereations that the algorithm will run.
*/
var generationNumber: Int = /*#-editable-code*/50/*#-end-editable-code*/
/*:
 **executionSpeed** 􀄫 The time interval between showing each generation (Numbers between 0.1 and 1 are recomended).
*/
var executionSpeed: CGFloat = /*#-editable-code*/0.1/*#-end-editable-code*/
//#-hidden-code
let swiftUiView = Page3_SwiftUIView(numberOfExecutions: generationNumber, populationSize: populationSize, executionSpeed: executionSpeed)
var viewController = Page3_LiveViewController(view: swiftUiView)
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
/*:
 * Callout(Observation:):
 The algorithm would need much more work, details and optimization to give us a reliable solution.
*/
