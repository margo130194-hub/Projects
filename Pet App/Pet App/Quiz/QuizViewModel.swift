//
//  QuizViewModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import Foundation

final class QuizViewModel{
    
    weak var coordinator: Coordinator?
    
    let progressText = Bindable<String>("")
    var currentQuestion = 0
    let answerOptions = Bindable<[String]>([])
    var questions: [Questions] = []
    let questionText = Bindable<String>("")
    var userAnswers:[Int] = []
    
  
    
    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
        resetQuiz()
        loadQuizData()
    }
    
     func resetQuiz() {
        currentQuestion = 0
        userAnswers.removeAll()
        UserDefaults.standard.removeObject(forKey: "userAnswers")
    }
    
    func updateQuestion(){
        guard !questions.isEmpty else {return}
        let currentDataQuestion = questions[currentQuestion]
        progressText.value = "Question \(currentQuestion + 1) of \(questions.count)"
        questionText.value = currentDataQuestion.text
        answerOptions.value = currentDataQuestion.options
    }
       
    func selectAnswer(at index: Int){
        userAnswers.append(index)
        print("Current answers:", userAnswers)
        moveToAnotherQuestion()
    }
    
    func loadQuizData(){
        do{
            self.questions = try JsonService.shared.fetchData(fileName: "questions")
            updateQuestion()
        }
        catch{
            assertionFailure("Failed to decode questions: \(error)")
        }
    }
    
    func moveToAnotherQuestion(){
        guard currentQuestion < (questions.count - 1) else {
            UserDefaults.standard.set(userAnswers, forKey: "userAnswers")
            print("Final answers:", userAnswers)
            if let quizCoordinator = coordinator as? QuizCoordinatorProtocol{
                quizCoordinator.goToResultPage()
            }
            return
        }
        currentQuestion += 1
        updateQuestion()
    }
}
