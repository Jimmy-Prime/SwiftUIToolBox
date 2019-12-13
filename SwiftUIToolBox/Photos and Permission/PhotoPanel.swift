import Photos
import SwiftUI

struct PhotoPanel: View {
    @State var status = PHPhotoLibrary.authorizationStatus()

    var body: some View {
        Group {
            if status == .authorized {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(loadPhotos(), id: \.self) { photo in
                            Image(uiImage: photo)
                        }
                    }
                }
            } else if status == .notDetermined {
                Button(action: requestAuth) {
                    Text("Allow SwiftUIToolBox to access my photos.")
                }
            } else {
                Button(action: openSettings) {
                    Text("Open Settings.")
                }
            }
        }
    }

    func requestAuth() {
        PHPhotoLibrary.requestAuthorization { status in
            withAnimation {
                self.status = status
            }
        }
    }

    func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }

    func loadPhotos() -> [UIImage] {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let assets = PHAsset.fetchAssets(with: fetchOptions)

        var images: [UIImage] = []
        for index in 0 ..< assets.count {
            let asset = assets.object(at: index)
            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: requestOptions) { image, _ in
                if let image = image {
                    images.append(image)
                }
            }
        }

        return images
    }
}

struct PhotoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPanel()
    }
}
