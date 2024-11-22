import java.io.File;

String inputFolder = "D:/AAstudy/Workshop3/Organize_data/after/";  // Path to the input folder containing images
String outputFolder = "D:/AAstudy/Workshop3/Organize_data/after_clip/"; // Path to save processed images

void setup() {
  // Create output folder if it doesn't exist
  createFolder(outputFolder);

  // Get all files from the input folder
  File folder = new File(inputFolder);
  File[] files = folder.listFiles();

  if (files == null) {
    println("Input folder is empty or path is incorrect.");
    exit();
  }

  // Process each image in the folder
  for (File file : files) {
    if (file.isFile() && isImage(file.getName())) {
      processImage(file);
    }
  }

  println("Processing completed. Check the output folder.");
  exit();
}

void processImage(File file) {
  PImage img = loadImage(file.getAbsolutePath());
  if (img == null) {
    println("Failed to load image: " + file.getName());
    return;
  }

  // Resize image to 1000x1415
  img.resize(1000, 1415);

  // Crop dimensions
  int cropTop = 150;
  int cropBottom = 100;
  int croppedHeight = img.height - cropTop - cropBottom;

  if (croppedHeight <= 0) {
    println("Image too small to crop after resizing: " + file.getName());
    return;
  }

  // Crop the image
  PImage croppedImg = img.get(0, cropTop, img.width, croppedHeight);

  // Save the processed image
  String outputFilePath = outputFolder + "/" + file.getName();
  croppedImg.save(outputFilePath);

  println("Processed and saved: " + file.getName());
}

boolean isImage(String fileName) {
  String[] extensions = { "jpg", "jpeg", "png" };
  String lowerCaseName = fileName.toLowerCase();
  for (String ext : extensions) {
    if (lowerCaseName.endsWith(ext)) {
      return true;
    }
  }
  return false;
}

void createFolder(String path) {
  File folder = new File(path);
  if (!folder.exists()) {
    folder.mkdirs();
  }
}
