function varargout = application_choose(varargin)
% APPLICATION_CHOOSE MATLAB code for application_choose.fig
%      APPLICATION_CHOOSE, by itself, creates a new APPLICATION_CHOOSE or raises the existing
%      singleton*.
%
%      H = APPLICATION_CHOOSE returns the handle to a new APPLICATION_CHOOSE or the handle to
%      the existing singleton*.
%
%      APPLICATION_CHOOSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPLICATION_CHOOSE.M with the given input arguments.
%
%      APPLICATION_CHOOSE('Property','Value',...) creates a new APPLICATION_CHOOSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before application_choose_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to application_choose_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help application_choose

% Last Modified by GUIDE v2.5 26-May-2019 14:49:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @application_choose_OpeningFcn, ...
                   'gui_OutputFcn',  @application_choose_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before application_choose is made visible.
function application_choose_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to application_choose (see VARARGIN)

% Choose default command line output for application_choose
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes application_choose wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = application_choose_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RhD_choose.
function RhD_choose_Callback(hObject, eventdata, handles)
% hObject    handle to RhD_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
channel_select = 2;
handles.channel_select = 2;
control_choose(channel_select);
guidata(hObject, handles);



% --- Executes on button press in Mia_choose.
function Mia_choose_Callback(hObject, eventdata, handles)
% hObject    handle to Mia_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
channel_select = 1;
handles.channel_select = 1;
control_choose(channel_select);
guidata(hObject, handles);


% --- Executes on button press in RhD_Mia_choose.
function RhD_Mia_choose_Callback(hObject, eventdata, handles)
% hObject    handle to RhD_Mia_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
channel_select = 4;
handles.channel_select = 4;
control_choose(channel_select);
guidata(hObject, handles);


% --- Executes on button press in RhD_subtype.
function RhD_subtype_Callback(hObject, eventdata, handles)
% hObject    handle to RhD_subtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
channel_select = 3;
handles.channel_select = 3;
control_choose(channel_select);
guidata(hObject, handles);
