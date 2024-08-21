import 'package:image/image.dart' as img;

class ImageProcessinsService {
    static img.Image
    preprocessImage(img.Image image) {
        
        //Implement your preprocessing logic here
        return img.copyResize(image,widthg: 224, height: 224);
    }
}