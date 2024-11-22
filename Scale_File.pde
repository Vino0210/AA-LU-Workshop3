import java.io.File;

int targetWidth = 800;  // Desired width
int targetHeight = 800; // Desired height
String inputFolder = "D:/AAstudy/Workshop3/7_LA_manuel-andujar-sexto-de-primaria-11-years-old_2023-11-19_1635/Elements/";  // Path to the folder with input images
String outputFolder = "D:/AAstudy/Workshop3/7_LA_manuel-andujar-sexto-de-primaria-11-years-old_2023-11-19_1635/ELements_resize/"; // Path to save the output images

void setup() {
  // Create the output folder if it doesn't exist
  File outputDir = new File(outputFolder);
  if (!outputDir.exists()) {
    outputDir.mkdirs();
  }

  // Get all files in the input folder
  File folder = new File(inputFolder);
  File[] files = folder.listFiles();
  if (files == null) {
    println("The input folder is empty or the path is incorrect!");
    exit();
  }

  // Process each file
  for (File file : files) {
    if (file.isFile() && isImage(file.getName())) {
      processImage(file);
    }
  }
  
  println("Image processing complete!");
  exit();
}

void processImage(File file) {
  PImage img = loadImage(file.getAbsolutePath());
  if (img == null) {
    println("Failed to load image: " + file.getName());
    return;
  }

  // Calculate the new dimensions to fit within the target size while preserving aspect ratio
  float aspectRatio = float(img.width) / img.height;
  int scaledWidth, scaledHeight;

  if (float(targetWidth) / targetHeight > aspectRatio) {
    scaledHeight = targetHeight;
    scaledWidth = int(targetHeight * aspectRatio);
  } else {
    scaledWidth = targetWidth;
    scaledHeight = int(targetWidth / aspectRatio);
  }

  // Resize the image to the new dimensions
  img.resize(scaledWidth, scaledHeight);

  // Create a new canvas with the target size and white background
  PGraphics canvas = createGraphics(targetWidth, targetHeight);
  canvas.beginDraw();
  canvas.background(255); // White background

  // Center the resized image on the canvas
  float offsetX = (targetWidth - scaledWidth) / 2.0;
  float offsetY = (targetHeight - scaledHeight) / 2.0;
  canvas.image(img, offsetX, offsetY);
  canvas.endDraw();

  // Save the output image
  String outputFilePath = outputFolder + "/" + file.getName();
  canvas.save(outputFilePath);
  println("Saved image: " + outputFilePath);
}

boolean isImage(String fileName) {
  String[] extensions = {"jpg", "jpeg", "png", "gif", "bmp"};
  String lowerCaseName = fileName.toLowerCase();
  for (String ext : extensions) {
    if (lowerCaseName.endsWith(ext)) {
      return true;
    }
  }
  return false;
}
