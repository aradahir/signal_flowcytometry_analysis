import PySimpleGUI as sg
import sys
import os, io
from PIL import Image
import cv2

def get_image_as_data(filename, width=800, height=500):
    im = Image.open(filename)
    if isinstance(width, int) and isinstance(height, int):
        im = im.resize((width, height))
    imBA = io.BytesIO()
    im.save(imBA, format="PNG")
    return imBA.getvalue()


if __name__ == "__main__":
    sg.theme('DarkAmber')   # Add a little color to your windows
    # All the stuff inside your window. This is the PSG magic code compactor...
    menu_def = [['&File', ['&Open', '&Save', 'E&xit', 'Properties']],
            ['&Edit', ['Paste', ['Special', 'Normal', ], 'Undo'], ],
            ['&Help', '&About...'], ]
    layout = [  
                [sg.Menu(menu_def, tearoff=True)],
                [
                    sg.Text('open file'), 
                    sg.InputText(key="photo_file"), 
                    sg.FileBrowse(target="photo_file"),
                    sg.Text('open blank file'), 
                    sg.InputText(key="blank_file"), 
                    sg.FileBrowse(target="blank_file")
                ],
                [   
                    sg.Text('Mode of operation'),
                    sg.Radio('Automatic', "RADIO1"), 
                    sg.Radio('Manual', "RADIO1"),
                    sg.InputCombo(('Cell type: THw','Cell type: THp','Cell type: CH'),default_value= 'select cell type' , size=(20, 1)),
                    sg.Text('dilution'), 
                    sg.InputText(key="dilute"),
                    sg.Submit()
                ],
                [   sg.Text('Result')],
                [ 
                    sg.Image(key="image", size=(800,500), data=get_image_as_data('D:\cell_count\CH004.png'))
                ]
             ]
    # Create the Window
    window = sg.Window('Input file', layout, default_element_size=(40, 1), grab_anywhere=False)
    while True:
        event, values = window.Read()
        if event == "Submit":
            if values["photo_file"] != "":
                if os.path.isfile(values["photo_file"]):
                   window.FindElement("image").Update(data=get_image_as_data(values["photo_file"], 800, 500))
        if event is None :
            break
    
    window.close()
  
   