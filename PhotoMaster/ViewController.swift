//
//  ViewController.swift
//  PhotoMaster
//
//  Created by まつはる on 2024/05/11.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTappedCameraButton() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            if let image = info[.originalImage] as? UIImage {
                let resizedImage = self.resizeImage(image: image, targetSize: CGSize(width: image.size.width / 8, height: image.size.height / 8))
                let finalImage = self.drawText(image: resizedImage)
                self.photoImageView.image = finalImage
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func drawText(image: UIImage) -> UIImage {
        let text = "HELLO"
        let textFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica-Bold", size: 120) ?? UIFont.boldSystemFont(ofSize: 120),
            .foregroundColor: UIColor.red
        ]
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        return renderer.image { context in
            image.draw(at: .zero)
            let textRect = CGRect(x: 5, y: 5, width: image.size.width - 10, height: image.size.height - 10)
            text.draw(in: textRect, withAttributes: textFontAttributes)
        }
    }
}



//import UIKit
//
//class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    
//    @IBOutlet var photoImageView: UIImageView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func onTappedCameraButton () {
//        presentPickerController(sourceType: .camera)
//    }
//    @IBAction func onTappedAlbumButton () {
//        presentPickerController(sourceType: .photoLibrary)
//        
//    }
//    
//    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
//        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
//            let picker = UIImagePickerController()
//            picker.sourceType = sourceType
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
//        
//        
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        self.dismiss(animated: true, completion: nil)
//
//        let image = info[.originalImage] as! UIImage
//        let size = CGSize(width: image.size.width / 8,  height: image.size.width / 8)
//        let resizedImage = UIGraphicsImageRenderer(size: size).image { _ in
//            image.draw(in: CGRect(origin: .zero, size: size))
//            photoImageView.image = image
//        }
//    }
//    
//    func drawText(image: UIImage) -> UIImage {
//        UIGraphicsBeginImageContext(image.size)
//        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        
//        let margin: CGFloat = 5.0
//        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
//        
//        text.draw(in: textRect, withAttributes: textFontAttributes)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        return newImage!
//
//        
//        let text = "HELLO"
//        let textFontAttributes = [
//            NSAttributedString.Key.font: UIFont(name: "PANDA", size: 120)!,
//            NSAttributedString.Key.foregroundColor: UIColor.red
//        ]
//    }
    
//}
