from tensorflow.keras.models import load_model
import PySimpleGUI as sg
import sys
import os, io
from PIL import Image
import cv2
import numpy as np
import implement_model as my_model

def get_image_as_data(filename, width=500, height=300):
    im = Image.open(filename)
    if isinstance(width, int) and isinstance(height, int):
        im = im.resize((width, height))
    imBA = io.BytesIO()
    im.save(imBA, format="PNG")
    return imBA.getvalue()

def select_model(cell_type):
        model_matching = {'THw': 'D:/cell_count/my_modelThw_10.h5',
                         'THp': 'D:/cell_count/my_modelTHp_10.h5',
                         'CH': 'D:/cell_count/my_modelCH_10.h5',
                         'CH_1': 'D:/cell_count/my_modelCH_1_10.h5'}
        model  = load_model(model_matching[cell_type])
        return model

def crop(image_path, coords):
        image_obj = Image.open(values["photo_file"])
        cropped_image = image_obj.crop(coords)
        return cropped_image

if __name__ == "__main__":
    sg.theme('DarkAmber')   # Add a little color to your windows
    # All the stuff inside your window. This is the PSG magic code compactor...
    menu_def = [['&File', ['&Open', '&Save', 'E&xit', 'Properties']],
            ['&Edit', ['Paste', ['Special', 'Normal', ], 'Undo'], ],
            ['&Help', '&About...'], ]

    tab1_layout =  [
                    [sg.Text('Cell Detection result...',size=(58,1)) ]
                    
                ]    
    tab2_layout =  [
                    [sg.T('User : ',size=(15,1)),sg.InputText(key="user_id",size=(45,1))],
                    [sg.T('Date of Experiment : ',size=(15,1)),sg.InputText(key="experiment_id",size=(45,1))],
                    [sg.T('Save as file name : ',size=(15,1)),sg.InputText(key="output",size=(45,1))]
                ]    

    layout = [  
                [sg.Menu(menu_def, tearoff=True)],
                [
                    sg.Text('Open file'), 
                    sg.InputText(key="photo_file", size=(30,1)), 
                    sg.FileBrowse(target="photo_file",size=(5,1)),
                    sg.Text('Dilution'), 
                    sg.InputText(key="dilute",size=(14,1))
                ],
                [   
                    sg.Text('Mode of operation'),
                    sg.Radio('Mixed types', "RADIO1", key= 'event_type',size=(10,1)), 
                    sg.Radio('Single type', "RADIO1",key= 'event_type1',size=(10,1)),
                    sg.InputCombo(('THw','THp','CH','CH_1'),default_value= 'select cell type' , size=(20, 1), key= 'type')
                ],
                [
                    sg.Submit(size=(62,1))
                ],
                [   
                    sg.Text('Progress bar'),
                    sg.ProgressBar(1, orientation='h', size=(38, 10), key='progress')
                ],
                [
                    sg.Text('IMAGE VIEWER..')
                ],
                [ 
                    sg.Image(key="image", size=(500,300), data=get_image_as_data('D:\cell_count\CH004.png'))
                ],
                [
                    sg.TabGroup(
                        [[sg.Tab('Detection Result', tab1_layout), sg.Tab('Experiment Information', tab2_layout)]])
                ],
                [
                    sg.SimpleButton('Export File',size=(62,1))
                ]
             ]
    # Create the Window
    window = sg.Window('Input file', layout, default_element_size=(40, 1), grab_anywhere=False)
    progress_bar = window.FindElement('progress')
    while True:
        event, values = window.Read()
        if event == "Submit":
            event_type = values['event_type'] 
            file_type = values['type']  
            model = select_model(file_type)
            cell_cnt = 0
            time = 0
            img = cv2.imread(values["photo_file"])
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

            # Detect all object via opencv
            detected_circles = cv2.HoughCircles(gray,  
                                cv2.HOUGH_GRADIENT, 1, 40, param1 = 30, 
                        param2 = 30, minRadius = 10, maxRadius =30)
            
            if detected_circles is not None: 
            
                # Convert the circle parameters a, b and r to integers. 
                detected_circles = np.uint16(np.around(detected_circles)) 
                
                # Check if each circle is cell or not
                for pt in detected_circles[0, :]:
                    time = time + 1 
                    a, b, r = pt[0], pt[1], pt[2]
                    sample = crop(img, (a-30,b-30,a+30,b+30))
                    progress_bar.UpdateBar(time, len(detected_circles[0, :]))
                    cell = model.predict_classes(np.array(sample).reshape(-1,60, 60, 3))
                    if cell == [1]:
                        cell_cnt = cell_cnt + 1
                        cv2.circle(img, (a, b), r, (0, 255, 0), 2) 

            cv2.imwrite('detect_image.png', img)
            print(cell_cnt)
            
            if values["photo_file"] != "":
                #my_model.fit_model('D:\cell_count\CH004.png',file_type)
                if os.path.isfile(values["photo_file"]):
                    window.FindElement("image").Update(data=get_image_as_data('detect_image.png', width=500, height=300))
        if event is None :
            break
    
    window.close()
  
   