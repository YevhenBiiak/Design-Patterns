import Foundation

protocol Downloader {
    func download(url: String, completion: (Data) -> Void)
}

class ImageDownloader: Downloader {
    
    func download(url: String, completion: (Data) -> Void) {
        print("Loading data...")
        let data = Data()
        completion(data)
    }
}

class CachingImageDownloader: Downloader {
    
    private let imageDownloader: Downloader
    
    init(imageDownloader: Downloader) {
        self.imageDownloader = imageDownloader
    }
    
    func download(url: String, completion: (Data) -> Void) {
        
        imageDownloader.download(url: url) { data in
            print("Saving image to cach...")
            completion(data)
        }
    }
}

let imageURL = "https://google.com/image1"

let imageDownloader = ImageDownloader()

imageDownloader.download(url: imageURL) { data in
    print("Image was downloaded!\n")
}

let cachingImageDownloader = CachingImageDownloader(imageDownloader: imageDownloader)

cachingImageDownloader.download(url: imageURL) { data in
    print("Image was downloaded and cached")
}

// prints

// Loading data...
// Image was downloaded!

// Loading data...
// Saving image to cach...
// Image was downloaded and cached
