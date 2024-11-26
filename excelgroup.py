import os
from openpyxl import Workbook
from openpyxl.drawing.image import Image

# 设置图片和文本文件夹路径
image_folder = r"D:\AAstudy\Workshop3\Organized_data\after_clip"  # 替换为你的图片文件夹路径
text_folder = r"D:\AAstudy\Workshop3\Organized_data\after_cap"    # 替换为你的文本文件夹路径
output_file = r"D:\AAstudy\Workshop3\Organized_data\output_with_images_and_texts.xlsx"  # 输出Excel文件路径

# 获取图片文件列表
image_files = [f for f in os.listdir(image_folder) if f.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp', '.gif'))]
image_paths = [os.path.join(image_folder, f) for f in image_files]

# 获取文本文件内容
text_contents = []
text_files = [f for f in os.listdir(text_folder) if f.lower().endswith('.txt')]
for text_file in text_files:
    with open(os.path.join(text_folder, text_file), 'r', encoding='utf-8') as file:
        text_contents.append(file.read())

# 填充列表以确保长度一致
max_length = max(len(image_paths), len(text_contents))
image_paths += [""] * (max_length - len(image_paths))
text_contents += [""] * (max_length - len(text_contents))

# 创建Excel
wb = Workbook()
ws = wb.active
ws.title = "Images and Texts"

# 写入标题
ws.append(["Image", "Text"])

# 插入图片和文本
row = 2  # 从第2行开始，因为第1行为标题
for img_path, text in zip(image_paths, text_contents):
    # 插入图片
    if img_path:
        img = Image(img_path)
        img.width, img.height = 100, 100  # 调整图片大小
        ws.add_image(img, f"A{row}")
    # 插入文本
    ws.cell(row=row, column=2, value=text)
    row += 1  # 移动到下一行

# 保存Excel文件
wb.save(output_file)
print(f"Excel文件已成功创建，并包含图片和文本：{output_file}")
