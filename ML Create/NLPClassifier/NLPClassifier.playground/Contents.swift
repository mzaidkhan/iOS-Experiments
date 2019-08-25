import Foundation
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/mzaidkhan/Documents/SwiftApps/ML Create/NLPClassifier/spam.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let nlpClassifier = try MLTextClassifier(trainingData: trainingData,
                                               textColumn: "v2",
                                               labelColumn: "v1")

// Training accuracy as a percentage
let trainingAccuracy = (1.0 - nlpClassifier.trainingMetrics.classificationError) * 100

// Validation accuracy as a percentage
let validationAccuracy = (1.0 - nlpClassifier.validationMetrics.classificationError) * 100

let evaluationMetrics = nlpClassifier.evaluation(on: testingData)

// Evaluation accuracy as a percentage
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Mohamed Zaid Khan",
                               shortDescription: "A model trained to classify movie review sentiment",
                               version: "1.0")

try nlpClassifier.write(to: URL(fileURLWithPath: "/Users/mzaidkhan/Documents/SwiftApps/ML Create/NLPClassifier/NLPClassifier.mlmodel"),
                              metadata: metadata)
