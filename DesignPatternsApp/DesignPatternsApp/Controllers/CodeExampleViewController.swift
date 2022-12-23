//
//  CodeExampleViewController.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 22.12.2022.
//

import WebKit

class CodeExampleViewController: UIViewController {
    
    private let keywordsRegex = /import\b|protocol\b|class\b|struct\b|enum\b|case\b|func\b|get\b|set\b|static\b|var\b|let\b|lazy\b|init\b|weak\b|self\b|extension\b|return\b|false\b|true\b|throws\b|throw\b|guard\b|if\b|else\b|switch\b|try\b|async\b|await\b|do\b|catch\b|private\b|final\b|required\b|override\b|Self\b|\bType\b/
    private let typesRegex = /\b[A-Z].\w*/
    private let stringsRegex = /".*"/
    private let commentsRegex = /\/{2,}.*/
    
    private let keywordsColor = UIColor(red: 252/255, green:  95/255, blue: 163/255, alpha: 1)
    private let typesColor    = UIColor(red:  93/255, green: 216/255, blue: 255/255, alpha: 1)
    private let stringsColor  = UIColor(red: 252/255, green: 106/255, blue:  93/255, alpha: 1)
    private let commentsColor = UIColor(red: 108/255, green: 121/255, blue: 134/255, alpha: 1)
    
    private var codeExampleText: String!

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var codeExampleURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Font size: \(Int(codeLabel.font.pointSize))pt"

        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        loadCodeExampleText { [ weak self ] string in
            guard let self = self else { return }
            
            self.codeExampleText = string
            
            var attributedString = NSMutableAttributedString(string: self.codeExampleText)
            
            // paint keywords
            self.addAttribute(to: &attributedString, regex: self.keywordsRegex, color: self.keywordsColor)
            self.addAttribute(to: &attributedString, regex: self.typesRegex,    color: self.typesColor)
            self.addAttribute(to: &attributedString, regex: self.stringsRegex,  color: self.stringsColor)
            self.addAttribute(to: &attributedString, regex: self.commentsRegex, color: self.commentsColor)
            
            self.codeLabel.attributedText = attributedString
            
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func smallerFontSizeButtonTapped(_ sender: UIBarButtonItem) {
        codeLabel.font = codeLabel.font.withSize(codeLabel.font.pointSize - 1)
        title = "Font size: \(Int(codeLabel.font.pointSize))pt"
    }
    
    @IBAction func largerFontSizeButtonTapped(_ sender: UIBarButtonItem) {
        codeLabel.font = codeLabel.font.withSize(codeLabel.font.pointSize + 1)
        title = "Font size: \(Int(codeLabel.font.pointSize))pt"
    }
    
    // MARK: - Private methods
    
    private func loadCodeExampleText(_ completion: @escaping (String) -> Void) {
        
        let url = URL(string: codeExampleURL)!
        
        DispatchQueue.global().async {
            
            if let string = try? String(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(string)
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(title: "Something went wrong", message: nil)
                }
            }
        }
    }
    
    private func addAttribute(to attributedString: inout NSMutableAttributedString, regex: Regex<Substring>, color: UIColor) {
        
        let ranges = codeExampleText.ranges(of: regex)

        for stringRange in ranges {

            let range = NSRange(stringRange, in: codeExampleText)

            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
    
    private func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
