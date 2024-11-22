import java.io.File;

String inputFolder = "D:/AAstudy/Workshop3/workshop3_images/input_images/"; // Path to input folder
String beforeFolder = "D:/AAstudy/Workshop3/workshop3_images/before"; // Path to save the left parts
String afterFolder = "D:/AAstudy/Workshop3/workshop3_images/after";  // Path to save the right parts

void setup() {
  // Create output folders if they don't exist
  createFolder(beforeFolder);
  createFolder(afterFolder);

  // Process images in the input folder
  File folder = new File(inputFolder);
  File[] files = folder.listFiles();

  if (files == null) {
    println("Input folder is empty or path is incorrect.");
    exit();
  }

  for (File file : files) {
    if (file.isFile() && isImage(file.getName())) {
      processImage(file);
    }
  }

  println("Processing completed. Check the 'before' and 'after' folders.");
  exit();
}

void processImage(File file) {
  PImage img = loadImage(file.getAbsolutePath());
  if (img == null) {
    println("Failed to load image: " + file.getName());
    return;
  }

  // Ensure the image is saved in PNG format
  String baseName = getBaseName(file.getName());
  String beforeFilePath = beforeFolder + "/" + baseName + "_left.png";
  String afterFilePath = afterFolder + "/" + baseName + "_right.png";

  // Split the image into left and right halves
  int midWidth = img.width / 2;

  // Extract left and right halves
  PImage leftHalf = img.get(0, 0, midWidth, img.height);
  PImage rightHalf = img.get(midWidth, 0, midWidth, img.height);

  // Save the halves as PNG
  leftHalf.save(beforeFilePath);
  rightHalf.save(afterFilePath);

  println("Processed: " + file.getName());
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

String getBaseName(String fileName) {
  int dotIndex = fileName.lastIndexOf('.');
  return dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
}
