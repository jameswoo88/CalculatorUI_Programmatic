//
//  ViewController.swift
//  CalculatorUI_Programmatic
//
//  Created by James Chun on 5/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var detailString: String = ""
    var numberString: String = ""

    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        //add views and contraints
        addAllSubviews()
        addLabelsToDisplayView()
        configureContainerView()
        setupNumberPadButtons()
        constrainTopLabel()
        constrainDisplayView()
        constrainNumberLabel()
        constrainDetailLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style views
        self.view.backgroundColor = Colors.customYellow
        displayView.backgroundColor = Colors.customWhite
        displayView.addCornerRadius()
    }
    
    //MARK: - UIViews
    let containerView: UIView = {
        let view = UIView()
                
        return view
    }()
    
    let topLabel: PrimaryLabel = {
       let label = PrimaryLabel()
        label.awakeFromNib()
        label.text = "CALCULATOR"
        label.font = UIFont(name: FontNames.digital, size: 30)
        
        return label
    }()
    
    let displayView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let detailLabel: SecondaryLabel = {
        let label = SecondaryLabel()
        label.awakeFromNib()
        label.text = "0.0"
        label.numberOfLines = 0
        label.textAlignment = .right
        
        return label
    }()
    
    let numberLabel: PrimaryLabel = {
        let label = PrimaryLabel()
        label.awakeFromNib()
        label.text = "0.0"
        label.font = UIFont(name: FontNames.digital, size: 60)
        label.textAlignment = .right
        
        return label
    }()
    
    private func setupNumberPadButtons() {
        let buttonSize: CGFloat = containerView.frame.width / 5
        let buttonBuffer: CGFloat = containerView.frame.width / 18
        let leadPadding: CGFloat = buttonSize + buttonBuffer
        let plusButtonHeight: CGFloat = (buttonSize * 2) + buttonBuffer
        
        let plusButton = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: plusButtonHeight))
        plusButton.setTitle("+", for: .normal)
        plusButton.awakeFromNib()
        plusButton.titleLabel?.font = UIFont(name: FontNames.digitalMono, size: 35)
        plusButton.tag = 10

        containerView.addSubview(plusButton)
        
        plusButton.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: (buttonSize + buttonBuffer)*3, paddingTrailing: 0, width: buttonSize, height: plusButtonHeight)
        
        plusButton.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        
        let bottomRow = ["0", ".", "="]
        for x in 0..<bottomRow.count {
            let button1 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
           
            if x == 1 {
                button1.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            }
            
            button1.setTitle(bottomRow[x], for: .normal)
            button1.awakeFromNib()
            
            
            switch x {
            case 0:
                button1.tag = 0
            case 1:
                button1.tag = 14
            case 2:
                button1.tag = 15
            default:
                print("unkown button iteration")
            }
            
            containerView.addSubview(button1)
            
            button1.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: leadPadding * CGFloat(x), paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            button1.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0...2 {
            let button2 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            if x == 0 {
                button2.titleEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
            }
            
            button2.setTitle("\(x+1)", for: .normal)
            button2.awakeFromNib()
            button2.tag = x+1
            
            containerView.addSubview(button2)
            
            button2.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -(buttonSize + buttonBuffer), paddingLeading: leadPadding * CGFloat(x), paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            button2.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0...2 {
            let button3 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            button3.setTitle("\(x+4)", for: .normal)
            button3.awakeFromNib()
            button3.tag = x+4
            
            containerView.addSubview(button3)
            
            button3.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -(buttonSize + buttonBuffer)*2, paddingLeading: leadPadding * CGFloat(x), paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            button3.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        }
        
        for x in 0...2 {
            let button4 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            button4.setTitle("\(x+7)", for: .normal)
            button4.awakeFromNib()
            button4.tag = x+7
            
            containerView.addSubview(button4)
            
            button4.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -(buttonSize + buttonBuffer)*3, paddingLeading: leadPadding * CGFloat(x), paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            button4.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        }
        
        let topRow = ["C", "%", "√"]
        for x in 0..<topRow.count {
            let button5 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            button5.setTitle(topRow[x], for: .normal)
            button5.awakeFromNib()
            button5.tag = x+16
            
            containerView.addSubview(button5)
            
            button5.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -(buttonSize + buttonBuffer)*4, paddingLeading: leadPadding * CGFloat(x), paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            if x == 0 {
                button5.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
            }
        }
        
        let trailingColumn = ["-", "X", "÷"]
        for x in 0..<trailingColumn.count {
            let button6 = Button(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            
            button6.setTitle(trailingColumn[x], for: .normal)
            button6.awakeFromNib()
            button6.tag = x+11
            
            containerView.addSubview(button6)
            
            button6.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -(plusButtonHeight + buttonBuffer) - ((buttonSize + buttonBuffer) * CGFloat(x)), paddingLeading: (buttonSize + buttonBuffer)*3, paddingTrailing: 0, width: buttonSize, height: buttonSize)
            
            button6.addTarget(self, action: #selector(ButtonPressed(_:)), for: .touchUpInside)
        }
        
    }//end of func

    //MARK: - Helper Methods
    func addAllSubviews() {
        self.view.addSubview(containerView)
        self.view.addSubview(topLabel)
        self.view.addSubview(displayView)
    }
    
    func addLabelsToDisplayView() {
        self.displayView.addSubview(detailLabel)
        self.displayView.addSubview(numberLabel)
    }
    
    
    //MARK: - Constraints
    func configureContainerView() {
        containerView.frame = CGRect(x: SpacingConstants.outerHorizontalPadding, y: SpacingConstants.outerTopPadding, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.85)
        
        containerView.anchor(top: self.view.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: SpacingConstants.outerTopPadding, paddingBottom: 0, paddingLeading: SpacingConstants.outerHorizontalPadding, paddingTrailing: SpacingConstants.outerHorizontalPadding, width: nil, height: self.view.frame.height * 0.85)
    }
    
    func constrainTopLabel() {
        
        topLabel.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: (self.view.frame.width - 200) / 2, paddingTrailing: (self.view.frame.width - 200) / 2, width: 132, height: 36)
    }
    
    func constrainDisplayView() {
        displayView.anchor(top: topLabel.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: SpacingConstants.innerPaddingLarge, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: containerView.frame.width, height: self.view.frame.height/4.6)
    }
    
    func constrainNumberLabel() {
        numberLabel.frame = CGRect(x: 0, y: 0, width: containerView.frame.width * 0.9, height: 72)
        
        numberLabel.anchor(top: nil, bottom: displayView.bottomAnchor, leading: nil, trailing: displayView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: SpacingConstants.innerPaddingLarge, width: containerView.frame.width * 0.9, height: 72)
    }
    
    func constrainDetailLabel() {
        detailLabel.anchor(top: nil, bottom: numberLabel.topAnchor, leading: nil, trailing: displayView.trailingAnchor, paddingTop: 0, paddingBottom: SpacingConstants.innerPaddingSmall, paddingLeading: 0, paddingTrailing: SpacingConstants.innerPaddingLarge, width: containerView.frame.width * 0.9, height: nil)
    }
    
    //MARK: - Functions
    func resetViews() {
        detailLabel.text = "0.0"
        numberLabel.text = "0.0"
    
        detailString = ""
        numberString = ""
    }

    @objc func ButtonPressed(_ sender: UIButton) {
        guard let mathOperator = sender.titleLabel?.text else { return }
        
        if detailString == "RESULT" {
            detailString = ""
            numberString = ""
        }

        switch sender.tag {
        case 0...9:
            // Numbers

            detailString.append(String(sender.tag))
            numberString.append(String(sender.tag))
            numberLabel.text = numberString
        case 10:
            // Add
            if detailLabel.text != "0.0" && !detailString.isEmpty {
                detailString.append(mathOperator)
                numberString = ""
                numberLabel.text = "0.0"
            }
        case 11:
            // Subtract
            if detailLabel.text != "0.0" && !detailString.isEmpty {
                detailString.append(mathOperator)
                numberString = ""
                numberLabel.text = "0.0"
            }
        case 12:
            // Multiply
            if detailLabel.text != "0.0" && !detailString.isEmpty {
                detailString.append("*") //need to use asterisk for muliplication
                numberString = ""
                numberLabel.text = "0.0"
            }
        case 13:
            // Divide
            if detailLabel.text != "0.0" && !detailString.isEmpty {
                detailString.append("/") //need to use backslash for division
                numberString = ""
                numberLabel.text = "0.0"
            }
        case 14:
            // Decimal
            if detailLabel.text != "0.0" && !detailString.isEmpty {
                detailString.append(mathOperator)
                numberString.append(mathOperator)
            } else {
                detailString = "0."
                numberString = "0."
                numberLabel.text = numberString
            }
        case 15:
            // Perform calculation
            //var expression: NSExpression?
            let expression = NSExpression(format: detailString)
            let result = expression.expressionValue(with: nil, context: nil) ?? "ERROR"
            detailString = "RESULT"
            numberLabel.text = "\(result)"
        default:
            fatalError("Unknown button tag")
        }
        detailLabel.text = detailString.isEmpty ? "0.0" : detailString
    }
    
    @objc func clearButtonTapped(_ sender: UIButton) {
        resetViews()
    }

}//End of class

