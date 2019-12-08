//
//  DetalheLivroViewController.swift
//  DesafioApp
//
//  Created by humberto Lima on 08/12/19.
//  Copyright © 2019 humberto Lima. All rights reserved.
//

import UIKit
import Kingfisher

class DetalheLivroViewController: UIViewController {

    var livroSelecionado = ListaLivrosResults()
   
    @IBOutlet var fotoLivro: UIImageView!
    @IBOutlet var labelPreco: UILabel!
    @IBOutlet var labelAutor: UILabel!
    @IBOutlet var descricaoLivro: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDados()
    }
    
    @IBAction func voltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUpDados() {
        fotoLivro.kf.setImage(with: URL(string: livroSelecionado.artworkUrl100 ?? ""))
        labelAutor.text = "Autor: " + (livroSelecionado.artistName ?? "")
        labelPreco.text = "Preço: " + (livroSelecionado.formattedPrice ?? "0.0")
        descricaoLivro.attributedText = (livroSelecionado.description ?? "").htmlParaAttributedString
    }
    
    func alerta(title: String, mensagem:String){
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
       
    
    
    @IBAction func salvar(_ sender: UIButton) {
        let alertTemp = UIAlertController(title: "Aviso", message: "Deseja mesmo salvar este livro em sua lista de favoritos?", preferredStyle: UIAlertController.Style.alert)
        alertTemp.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.default, handler: nil))
        alertTemp.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.salvaLirvo()
        }))
        self.present(alertTemp, animated: true, completion: nil)
    }
    
    func salvaLirvo() {
        dados.salvaLivro(livroSalvar: livroSelecionado) { (ret, msg) in
            if ret {
                self.alerta(title: "Sucesso", mensagem: "Livro Salvo com sucesso")
            }else{
                print(msg)
            }
        }
    }
}
