//
//  AddProductViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit
import Photos

class AddProductViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameProductTextField: UITextField!
    @IBOutlet weak var quantityProductTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addImageTapped: UIButton!
    @IBOutlet weak var saveTapped: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    //Выгружаем изображение из галереи
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        else {
            throwAlert("Ошибка загрузки фотографии")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //Открываем галерию
    @IBAction func addImageTapped(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization{ (newStatus) in
            DispatchQueue.main.async {
                if newStatus ==  PHAuthorizationStatus.authorized {
                    let image = UIImagePickerController()
                    image.delegate = self
                    image.sourceType = UIImagePickerController.SourceType.photoLibrary
                    image.allowsEditing = false
                    self.present(image, animated: true, completion: nil)
                }
            }
        }
    }
    
    //Вызывем Alert для показа сообщения пользователю
    func throwAlert(_ message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Extension

extension AddProductViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddProductViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

