//
//  ExtensionString.swift
//  testeProjeto
//
//  Created by humberto Lima on 22/06/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit

extension String {
    
    func isEmailValido() -> Bool {
        if self != "" {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: self)
        }else{
            return false
        }
    }
    
    // define qual tipo de separador terá na string - ou /
    // string no formato Dia / Mes / anos 00/00/0000
    func isDataValida(separador: String) -> Bool {
        let dataSeparada = self.components(separatedBy: separador)
        
        let diaInt: Int = Int(dataSeparada[0])!
        let mesInt: Int = Int(dataSeparada[1])!
        let anoInt: Int = Int(dataSeparada[2])!
        
        let date = NSDate()
        let calendar = NSCalendar.current
        // retorna a data de hoje para ser a data final da busca
        let anoAtual = calendar.component(.year, from: date as Date)
        
        if diaInt > 31 || mesInt > 12 || anoInt < 1900 || diaInt == 00 || mesInt == 00 || (anoAtual - anoInt) < 18 || anoInt >= anoAtual {
            return false
        }else if mesInt == 2 && diaInt > 29 {
            return false
        }else if ( mesInt % 2 ) == 0 && mesInt != 2 && diaInt == 31 {
            return false
        }else{
            return true
        }
    }
    
    func isSenhaValida() -> (Bool, String) {
        guard self != "" else { return (false, "Senha vazia") }
        
        guard self.count >= 8 && self.count <= 15 else { return (false, "A senha deve conter entre 8 e 15 caracteres") }
        
        let decimalCharacters = CharacterSet.decimalDigits
        guard (self.rangeOfCharacter(from: decimalCharacters) != nil) else { return (false, "A senha deve conter ao menos um número")}
        
        let letraMai = CharacterSet.uppercaseLetters
        guard (self.rangeOfCharacter(from: letraMai) != nil) else {return (false, "A senha deve conter ao menos uma letra maiúscula")}
        
        let letraMin = CharacterSet.lowercaseLetters
        guard (self.rangeOfCharacter(from: letraMin) != nil) else {return (false, "A senha deve conter ao menos uma letra minúscula")}
        
        return (true, "Senha válida")
    }
    
    var isCPFValido: Bool {
        let cpf = self.onlyNumbers()
        guard cpf.count == 11 else { return false }
        
        let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
        let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
        let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
        let d1 = Int(cpf[i1..<i2])
        let d2 = Int(cpf[i2..<i3])
        
        var temp1 = 0, temp2 = 0
        
        for i in 0...8 {
            let start = cpf.index(cpf.startIndex, offsetBy: i)
            let end = cpf.index(cpf.startIndex, offsetBy: i+1)
            let char = Int(cpf[start..<end])
            
            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }
        
        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2
        
        return temp1 == d1 && temp2 == d2
    }
    
    func onlyNumbers() -> String {
        guard !isEmpty else { return "" }
        return replacingOccurrences(of: "\\D",with: "", options: .regularExpression, range: startIndex..<endIndex)
        
    }
    
    // usado para quando está tratando horas como string adicionando um 0 a esquerda quando forem números menores que 10
    func trataHora() -> String {
        if self != "" {
            var stringCortada = self.components(separatedBy: ":")
            if stringCortada[0].count == 1 {
                stringCortada[0] = "0\(stringCortada[0])"
            }
            return "\(stringCortada[0]):\(stringCortada[1])"
        }else{
            return ""
        }
    }
    
    
    var htmlParaAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
}
