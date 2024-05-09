import UIKit
import PDFKit


class ImageConverter: UIViewController {
    let pdfURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/mediyoga-patient.appspot.com/o/chat%2FFcidT3auJX2Wdwtxhgem%2Fpdf%2F1715231622282.pdf?alt=media&token=50a76447-8cd8-4dc8-a619-a649b358dad5")
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = pdfURL {
            if let img = drawPDFfromURL(url: url) {
                print("Image drawn successfully")
                print(img)
                imgView.image = img
            } else {
                print("Failed to draw PDF as image.")
            }
        } else {
            print("Invalid URL")
        }
    }

    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else {
            print("Failed to load PDF document.")
            return nil
        }
        
        guard let page = document.page(at: 1) else {
            print("Failed to load PDF page.")
            return nil
        }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
}
