class implement_model:

    def __init__(self, image_path, cell_type):
        from tensorflow.keras.models import load_model
        import cv2
        from PIL import Image
        import numpy as np
        self.image_path= image_path
        self.cell_type = cell_type

    def select_model(self,cell_type):
        model_matching = {'THw': 'D:/cell_count/my_modelThw_10.h5',
                         'THp': 'D:/cell_count/my_modelTHp_10.h5',
                         'CH': 'D:/cell_count/my_modelCH_10.h5',
                         'CH_1': 'D:/cell_count/my_modelCH_1_10.h5'}
        model  = load_model(model_matching[self.cell_type])
        return model

    def crop(self,image_path, coords):
        image_obj = Image.open(self.image_path)
        cropped_image = image_obj.crop(coords)
        return cropped_image

    def fit_model(self):
        model = select_model(self.cell_type)
        cell_cnt = 0
        img = cv2.imread(self.image_path)
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
                a, b, r = pt[0], pt[1], pt[2]
                sample = crop(img, (a-30,b-30,a+30,b+30))
                cell = model.predict_classes(np.array(sample).reshape(-1,60, 60, 3))
                if cell == [1]:
                    cell_cnt = cell_cnt + 1
                    cv2.circle(img, (a, b), r, (0, 255, 0), 2) 
                
        cv2.imshow("Detected Circle", img) 
        cv2.waitKey(0)
        cv2.destroyAllWindows()
        print(cell_cnt)
    
