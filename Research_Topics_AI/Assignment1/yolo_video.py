from numpy.core.fromnumeric import size
import cv2
import numpy as np
import imutils
from imutils.video import FPS
from keras.models import load_model

INPUT = 'demo.mp4'
OUTPUT = 'output.avi'
LABEL = 'yolov3.txt'
CONFIG = 'yolo3.cfg'
WEIGHT  = 'yolo3.weights'

model = load_model('C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI/Research_Topics_AI/object-detection-opencv/saved_model')

vs = cv2.VideoCapture(INPUT)
writer = None
fps = FPS().start()

Width = None
Height = None

writer = cv2.VideoWriter(OUTPUT,cv2.VideoWriter_fourcc(*'MJPG'),25,(800,600),1)

def get_output_layers(net):
    
    layer_names = net.getLayerNames()
    
    layer_names = [layer_names[i[0] - 1] for i in net.getUnconnectedOutLayers()]

    return layer_names


def draw_prediction(img, class_id, confidence, x, y, x_plus_w, y_plus_h):

    #label = str(classes[class_id])

    color = COLORS[class_id]

    cv2.rectangle(img, (x,y), (x_plus_w,y_plus_h), color, 2)

    #cv2.putText(img, label, (x,y-5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

    pred = model.predict(img)
    ans = pred.argmax(axis = -1)
    if ans[0] == 0:
        cv2.putText(img, 'sedan', (x,y-5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)
    else:
        cv2.putText(img, 'suv', (x,y-5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)
        

classes = None

with open(LABEL, 'r') as f:
    classes = [line.strip() for line in f.readlines()]

COLORS = np.random.uniform(0, 255, size=(len(classes), 3))

net = cv2.dnn.readNet("yolov3.weights","yolov3.cfg")
  




while True:
    try:
        (grabbed,frame) = vs.read()#
    except:
        break

    if not grabbed:
        break
    blob = cv2.dnn.blobFromImage(frame, 1/255.0, (416,416), (0,0,0), True, crop=False)
    net.setInput(blob)

    if Width is None or Height is None:
        Height,Width = frame.shape[:2]
    outs = net.forward(get_output_layers(net))


    class_ids = []
    confidences = []
    boxes = []
    conf_threshold = 0.5
    nms_threshold = 0.4


    for out in outs:
        for detection in out:

            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]

            if confidence > 0.5:
                box = detection[0:4] * np.array([Width,Height,Width,Height])
                (center_x,center_y,w,h) = box.astype("int")

                x = center_x - w / 2
                y = center_y - h / 2

                class_ids.append(class_id)
                confidences.append(float(confidence))
                boxes.append([x, y, int(w), int(h)])


    indices = cv2.dnn.NMSBoxes(boxes, confidences, conf_threshold, nms_threshold)

    for i in indices:
        i = i[0]
        box = boxes[i]
        x = box[0]
        y = box[1]
        w = box[2]
        h = box[3]        

        draw_prediction(frame, class_ids[i], confidences[i], round(x), round(y), round(x+w), round(y+h))

    cv2.imshow("output",cv2.resize(frame,(800,600)))
    fps.update()
    writer.write(cv2.resize(frame,(800,600)))
    if cv2.waitKey(1) & 0xFF == ord('s'): 
        break
fps.stop()

cv2.destroyAllWindows()
writer.release()
vs.release()