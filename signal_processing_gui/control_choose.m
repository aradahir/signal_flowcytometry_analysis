function varargout = control_choose(varargin)
% CONTROL_CHOOSE MATLAB code for control_choose.fig
%      CONTROL_CHOOSE, by itself, creates a new CONTROL_CHOOSE or raises the existing
%      singleton*.
%
%      H = CONTROL_CHOOSE returns the handle to a new CONTROL_CHOOSE or the handle to
%      the existing singleton*.
%
%      CONTROL_CHOOSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROL_CHOOSE.M with the given input arguments.
%
%      CONTROL_CHOOSE('Property','Value',...) creates a new CONTROL_CHOOSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before control_choose_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to control_choose_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help control_choose

% Last Modified by GUIDE v2.5 26-May-2019 16:02:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @control_choose_OpeningFcn, ...
                   'gui_OutputFcn',  @control_choose_OutputFcn, ...
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


% --- Executes just before control_choose is made visible.
function control_choose_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to control_choose (see VARARGIN)
global ch
% Choose default command line output for control_choose
handles.output = hObject;
handles.channel_select = varargin{1}
ch = handles.channel_select
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes control_choose wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = control_choose_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global template
mytag = get(hObject,'tag');
switch mytag
    case 'old'
        template =  1;
    case 'new'
        template =  2;
end
display(mytag)
guidata(hObject, handles);



% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch template
if template == 1
    switch ch
        case 1
            filename_p = 'H:\16052019\mia+320-1.tdms';
            filename_n = 'H:\16052019\mia-320.tdms';
        case 2
            filename_p = 'D:\sisp\rHealth Data\04012019\4012019\Rh+test2.tdms';
            filename_n = 'D:\sisp\rHealth Data\04012019\4012019\Rh- test 50.tdms';
        case 3
            filename_p = 'E:\25042019\D+2 G.tdms';
            filename_n = 'E:\25042019\D-2 H.tdms';
        case 4
            filename_MP = 'H:\16052019\mia+320-1.tdms';
            filename_MN = 'H:\16052019\mia-320.tdms';
            filename_DP = 'D:\sisp\rHealth Data\04012019\4012019\Rh+test2.tdms';
            filename_DN = 'D:\sisp\rHealth Data\04012019\4012019\Rh- test 50.tdms';
    end
     f = waitbar(0.10,'loading...');
     if ch < 4 
         positive = tdms_read(filename_p);
         [  area_p, median_area_p, mean_area_p, count_p, CV_p ] = switch_channel(positive, ch );
         waitbar(0.63,f,'loading...');
         negative = tdms_read(filename_n);
         [  area_n, median_area_n, mean_area_n, count_n, CV_n ] = switch_channel(negative, ch );
         waitbar(0.90,f,'loading...');
        handles.area_peak_p = area_p;
        handles.area_peak_n = area_n;
        area_peak_DP = [];
        area_peak_DN = [];
        area_peak_MP = [];
        area_peak_MN = [];
        loadsample(ch,area_p, area_n, area_peak_DP,area_peak_DN,area_peak_MP,area_peak_MN)
        waitbar(1,f,'finish');
        pause(1)
        close(f)
     elseif ch == 4
         DP = tdms_read(filename_DP);
         [  area_peak_DP, median_area_DP, mean_area_DP, count_DP, CV_DP ] = switch_channel(DP, 1 );
          waitbar(0.33,f,'loading...');
         DN = tdms_read(filename_DN);
         [  area_peak_DN, median_area_DN, mean_area_DN, count_DN, CV_DN ] = switch_channel(DN, 1 );
         waitbar(0.63,f,'loading...');
         MN = tdms_read(filename_MP);
         [  area_peak_MP, median_area_MP, mean_area_MP, count_MP, CV_MP ] = switch_channel(MN, 2 );
         waitbar(0.79,f,'loading...');
          MN = tdms_read(filename_MN);
         [  area_peak_MN, median_area_MN, mean_area_MN, count_MN, CV_MN ] = switch_channel(MN, 2 );
         waitbar(0.90,f,'loading...');
        handles.area_peak_DP = area_peak_DP;
        handles.area_peak_DN = area_peak_DN;
        handles.area_peak_MP = area_peak_MP;
        handles.area_peak_MN = area_peak_MN;
        area_p = [];
        area_n = [];
       loadsample(ch,area_p, area_n, area_peak_DP,area_peak_DN,area_peak_MP,area_peak_MN)
        waitbar(1,f,'finish');
        pause(1)
        close(f)
     end
elseif template == 2
    if ch <4
        run_new_controls(ch);
    elseif ch == 4
        run_new_controls_duplex(ch);
    end
end
guidata(hObject, handles);
