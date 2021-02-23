//
//  ProductDetailsViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit
import Photos
import RealmSwift

protocol ProductDetailsUI: class {
    func dataChanged()
    func showLoading(_ isLoading: Bool)
    func throwAlert(_ message: String)
    func dismiss()
}

class ProductDetailsViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProductDetailsUI {
    
    var presenter: ProductDetailsPresenterProtocol!
    
    @IBOutlet weak var nameProductTextField: UITextField!
    @IBOutlet weak var quantityProductTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBAction func removeAction(_ sender: Any) {
        presenter.remove()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if presenter.canEdit {
            presenter.edit(
                name: nameProductTextField.text ?? "",
                count: quantityProductTextField.text ?? "",
                price: priceTextField.text ?? "",
                image: imageView.image
            )
        } else {
            presenter.create(
                name: nameProductTextField.text ?? "",
                count: quantityProductTextField.text ?? "",
                price: priceTextField.text ?? "",
                image: imageView.image
            )
        }
    }
    
    private let loadingIndicator = LoadingIndicatorView()
    
    //MARK: - Toolbar
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    @objc func doneAction () {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        loadingIndicator.isHidden = true
        navigationController?.view.addSubview(self.loadingIndicator)
        
        self.hideKeyboardWhenTappedAround()
        
        presenter.load(ui: self)
        
        toolbar.sizeToFit()
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        nameProductTextField.inputAccessoryView = toolbar
        quantityProductTextField.inputAccessoryView = toolbar
        priceTextField.inputAccessoryView = toolbar
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingIndicator.center = view.center
    }
    
    // MARK: - ProductDetailsUI
    func dataChanged() {
        removeButton.isHidden = !presenter.canEdit
        if let product = presenter.existingProduct {
            nameProductTextField.text = product.name
            quantityProductTextField.text = "\(product.count)"
            priceTextField.text = "\(product.price)"
            imageView.image = product.image
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        loadingIndicator.isHidden = !isLoading
    }
        
    func dismiss() {
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    func throwAlert(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
}

//MARK: - Extension

extension ProductDetailsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ProductDetailsViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

