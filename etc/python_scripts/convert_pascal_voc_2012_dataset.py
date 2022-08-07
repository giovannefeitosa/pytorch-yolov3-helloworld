import xml.etree.ElementTree as ET
import os
import glob

# variables
HERE=os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT=os.path.abspath(os.path.join(HERE, '../..'))
VOC2012_DIR=os.path.join(PROJECT_ROOT, 'data/VOC2012')
VOC2012_XML_DIR=os.path.join(VOC2012_DIR, 'Annotations')
VOC2012_LABELS_DIR=os.path.join(VOC2012_DIR, 'labels')
VOC2012_NAMES_FILE=os.path.join(VOC2012_DIR, 'voc2012.names')

# create a new directory for the converted dataset
if os.path.exists(VOC2012_LABELS_DIR):
  os.system(f'rm -rf "{VOC2012_LABELS_DIR}"')
os.mkdir(VOC2012_LABELS_DIR)

# get all the xml files in the VOC2012 directory
xml_files = glob.glob(os.path.join(VOC2012_XML_DIR, '*.xml'))
class_names = []

# loop through all the xml files
for xml_file in xml_files:
  tree = ET.parse(xml_file)
  root = tree.getroot()
  label_file = os.path.basename(xml_file).replace('.xml', '.txt')
  width=root.find('size').find('width').text
  height=root.find('size').find('height').text
  channels=root.find('size').find('depth').text
  # for each annotated object
  for object in root.iter('object'):
    # get xml variables
    class_name=object.find('name').text
    xmax=object.find('bndbox').find('xmax').text
    ymax=object.find('bndbox').find('ymax').text
    xmin=object.find('bndbox').find('xmin').text
    ymin=object.find('bndbox').find('ymin').text
    # class_name
    if class_name not in class_names:
      class_names.append(class_name)
    class_id = class_names.index(class_name)
    # convert to yolo
    x_center = (float(xmax) + float(xmin)) / 2
    y_center = (float(ymax) + float(ymin)) / 2
    width = float(xmax) - float(xmin)
    height = float(ymax) - float(ymin)
    # write to file
    with open(os.path.join(VOC2012_LABELS_DIR, label_file), 'a') as f:
      f.write(f"{class_id} {x_center} {y_center} {width} {height}\n")
  # print(f'Created data/VOC2012/labels/{label_file}')

# write class names to file
with open(VOC2012_NAMES_FILE, 'w') as f:
  for class_name in class_names:
    f.write(f"{class_name}\n")

# output
print('')
print(f'Created {len(class_names)} classes')
print(f'Labels are in data/VOC2012/labels')
print(f'Names are in data/VOC2012/VOC2012.names')
print(f'Data file is in config/VOC2012.data')
print('')
