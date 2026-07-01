//
//  QuizViewController.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

final class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModel
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let skipButton = UIButton(type: .system)
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()
    private let containerView = UIView()
    private let questionLabel = UILabel()
    private let verticalStackView = UIStackView()
    private let image = UIImageView()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    // MARK: - Bindings
    
    private func bindViewModel(){
        viewModel.progressText.bind {[weak self] text in
            self?.progressLabel.text = text
        }
        
        viewModel.questionText.bind{ [weak self] text in
            self?.questionLabel.text = text
        }
        
        viewModel.answerOptions.bind{[weak self] options in
            self?.verticalStackView.arrangedSubviews.forEach{$0.removeFromSuperview()}
            for (index, option) in options.enumerated() {
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 20)
                button.setTitleColor(.darkBrown, for: .normal)
                button.backgroundColor = .white.withAlphaComponent(0.5)
                button.layer.cornerRadius = 15
                button.layer.borderWidth = 1.5
                button.layer.borderColor = UIColor.darkBrown.withAlphaComponent(0.25).cgColor
                button.contentHorizontalAlignment = .center
                button.tag = index
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                button.setTitle(option, for: .normal)
                button.addTarget(self, action: #selector(self?.buttonTapped), for: .touchUpInside)
                self?.verticalStackView.addArrangedSubview(button)
                
            }
        }
    }
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = UIColor(named: "beige")
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupSubviews() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.backgroundColor = .clear
        skipButton.setTitleColor(.darkBrown.withAlphaComponent(0.8), for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Medium", size: 16)
        skipButton.addTarget(self, action: #selector(skipQuestion), for: .touchUpInside)
        contentView.addSubview(skipButton)
        
        progressLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 16)
        progressLabel.textColor = .darkBrown.withAlphaComponent(0.7)
        progressLabel.textAlignment = .center
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressLabel)
        
        progressView.progressTintColor = .darkBrown
        progressView.trackTintColor = .darkBrown.withAlphaComponent(0.15)
        progressView.progress = 0.0
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressView)
        
        questionLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 28)
        questionLabel.textColor = .darkBrown
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)
        
        verticalStackView.spacing = 20
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(verticalStackView)
        
        image.image = UIImage(named: "page1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            skipButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            skipButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            progressLabel.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 24),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 14),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

            questionLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            verticalStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

            image.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 30),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 260),
            image.heightAnchor.constraint(equalToConstant: 240),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
    }
    //    MARK: - Actions
    @objc private func buttonTapped(_ sender:UIButton){
        let selectedIndex = sender.tag
        viewModel.selectAnswer(at: selectedIndex)
    }
    
    @objc private func skipQuestion(){
        viewModel.moveToAnotherQuestion()
    }
}

// MARK: - Extensions
