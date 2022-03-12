//
//  ViewController.swift
//  IMC
//
//  Created by Alley Pereira on 12/03/22.
//

import UIKit

class ViewController: UIViewController {

	private var imcValue: Double = 0.0

	@IBOutlet weak var pesoTextField: UITextField!
	@IBOutlet weak var alturaTextField: UITextField!
	@IBOutlet weak var resultadoTitleLabel: UILabel!
	@IBOutlet weak var imcResultLabel: UILabel!

	@IBAction func calcularButton(_ sender: UIButton) {

		guard let height = alturaTextField.text?.replacingOccurrences(of: ",", with: ".") else { return }
		guard let weight = pesoTextField.text?.replacingOccurrences(of: ",", with: ".") else { return }
		guard let pesoEmDouble = Double(weight) else { return }
		guard let alturaEmDouble = Double(height) else { return }

		let imc = calculaIMC(peso: pesoEmDouble, altura: alturaEmDouble)
		guard let imcFormatted = formattedString(from: imc) else { return }
		let result = imcValuesResult(imcValue: imcFormatted)
		showIMC(result: result)
	}

	private func showIMC(result: String) {
		resultadoTitleLabel.text = "RESULTADO"
		imcResultLabel.text = result

		resultadoTitleLabel.isHidden = false
		imcResultLabel.isHidden = false
	}

	private func formattedString(from number: Double, with digits: Int = 2) -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.decimalSeparator = "."
		formatter.maximumFractionDigits = digits
		return formatter.string(for: number)
	}

	private func calculaIMC(peso: Double, altura: Double) -> Double {
		return peso / (altura * altura)
	}

	private func imcValuesResult(imcValue: String) -> String {

		switch Double(imcValue)! {
			case 0..<18.5:
				return "Seu IMC: \(imcValue)\n Você está abaixo do peso seu ideal"
			case 18.5..<24.9:
				return "Seu IMC: \(imcValue)\n Você está no seu peso ideal"
			case 25.0..<29.9:
				return "Seu IMC: \(imcValue)\n Você está com sobrepeso"
			case  30..<34.9:
				return "Seu IMC: \(imcValue)\n Você está com obesidade GRAU 1"
			case 35..<39.9:
				return "Seu IMC: \(imcValue)\n Você está com obesidade GRAU 2"
			case 40.0..<Double.greatestFiniteMagnitude:
				return "Seu IMC: \(imcValue)\n Você está com obesidade GRAU 3"
			default:
				return "Valor invalido"

		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		pesoTextField.delegate = self
		alturaTextField.delegate = self

		resultadoTitleLabel.isHidden = true
		imcResultLabel.isHidden = true
	}


}

extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pesoTextField.resignFirstResponder()
		alturaTextField.resignFirstResponder()
		return true
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}
