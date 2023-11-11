function varargout = loadsample(varargin)
% LOADSAMPLE MATLAB code for loadsample.fig
%      LOADSAMPLE, by itself, creates a new LOADSAMPLE or raises the existing
%      singleton*.
%
%      H = LOADSAMPLE returns the handle to a new LOADSAMPLE or the handle to
%      the existing singleton*.
%
%      LOADSAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADSAMPLE.M with the given input arguments.
%
%      LOADSAMPLE('Property','Value',...) creates a new LOADSAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before loadsample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to loadsample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help loadsample

% Last Modified by GUIDE v2.5 26-May-2019 11:11:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @loadsample_OpeningFcn, ...
                   'gui_OutputFcn',  @loadsample_OutputFcn, ...
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


% --- Executes just before loadsample is made visible.
function loadsample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to loadsample (see VARARGIN)
global ch area_p area_n area_DP area_DN area_MP area_MN xa_DN xa_MN
% Choose default command line output for loadsample
handles.output = hObject;
handles.ch = varargin{1};
ch = handles.ch;
handles.file_p = varargin{2};
area_p = handles.file_p;
handles.file_n = varargin{3};
area_n = handles.file_n;
handles.file_DP = varargin{4};
area_DP = handles.file_DP;
handles.file_DN = varargin{5};
area_DN = handles.file_DN;
handles.file_MP = varargin{6};
area_MP = handles.file_MP;
handles.file_MN = varargin{7};
area_MN = handles.file_MN;
handles.DN = varargin{8};
xa_DN = handles.DN;
handles.MN = varargin{9};
xa_MN = handles.MN;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes loadsample wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = loadsample_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadsample.
function loadsample_Callback(hObject, eventdata, handles)
% hObject    handle to loadsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename_s
[FileName_s,PathName_s] = uigetfile('*.tdms','Select rHealth file');
filename_s =  fullfile(PathName_s,FileName_s);
set(handles.load, 'String', filename_s);



function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load as text
%        str2double(get(hObject,'String')) returns contents of load as a double


% --- Executes during object creation, after setting all properties.
function load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analysis.
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch area_p area_n filename_s area_DP area_MP area_DN area_MN xa_DN xa_MN
if ch< 4
    f = waitbar(0.10,'loading...');
     sample = tdms_read(filename_s);
     [  area_peak_s, median_area_s, mean_area_s, count_s, CV_s ] = switch_channel(sample, ch );
     waitbar(0.90,f,'loading...');
     [type] = dianose( mean_area_s, count_s, ch );
    handles.area_p = area_p;
    handles.area_n = area_n;
    area_peak_s2 = [];
    median_area_s2 = [];
    mean_area_s2 = [];
    count_s2 = [];
    CV_s2 = [];
    type2 = [];
    result(ch,area_p,area_n,area_peak_s,area_peak_s2,median_area_s,median_area_s2,mean_area_s, mean_area_s2, count_s,count_s2, CV_s,CV_s2, filename_s, type, type2);
    waitbar(1,f,'finish');
    pause(1)
    close(f)
elseif ch == 4
    f = waitbar(0.10,'loading...');
     sample = tdms_read(filename_s);
     [  area_peak_s, median_area_s, mean_area_s, count_s, CV_s,xa_news1,xb_news1  ] = switch_channel(sample, 1 );
      waitbar(0.60,f,'loading...');
     [  area_peak_s2, median_area_s2, mean_area_s2, count_s2, CV_s2,xa_news2,xb_news2  ] = switch_channel(sample, 2 );
     waitbar(0.90,f,'loading...');
    s1_area = [];
    s2_area = [];
        for i = 1: length(xa_news2)
            for j = 1: length(xa_news1)
                if xa_news1(j) > xa_news2(i) & xa_news1(j) < xa_news2(i)+ 500
                    s1_area = [s1_area area_peak_s(j)];
                    s2_area = [s2_area area_peak_s2(i)];
                end
            end
        end
        
        for i = 1: length(xa_news1)
            for j = 1: length(xa_news2)
                if xa_news2(j) > xa_news1(i) & xa_news2(j) < xa_news1(i)+ 500
                    s1_area = [s1_area area_peak_s(i)];
                    s2_area = [s2_area area_peak_s2(j)];
                end
            end
        end
        
    c1_area = [];
    c2_area = [];
        for i = 1: length(xa_DN)
            for j = 1: length(xa_MN)
                if xa_MN(j) > xa_DN(i) & xa_MN(j) < xa_DN(i)+ 500
                    c1_area = [c1_area area_MN(j)];
                    c2_area = [c2_area area_DN(i)];
                end
            end
        end
        
        for i = 1: length(xa_MN)
            for j = 1: length(xa_DN)
                if xa_DN(j) > xa_MN(i) & xa_DN(j) < xa_MN(i)+ 500
                    c1_area = [c1_area area_MN(i)];
                    c2_area = [c2_area area_DN(j)];
                end
            end
        end
    handles.area_p = area_p;
    handles.area_n = area_n;
    resulttwochannel(ch,area_p,area_n,s2_area,s1_area,area_DP,area_MP,c1_area,c2_area,CV_s,CV_s2, filename_s);
    waitbar(1,f,'finish');
    pause(1)
    close(f)
end
