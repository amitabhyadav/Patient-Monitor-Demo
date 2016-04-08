function varargout = phm(varargin)
% PHM MATLAB code for phm.fig
%      PHM, by itself, creates a new PHM or raises the existing
%      singleton*.
%
%      H = PHM returns the handle to a new PHM or the handle to
%      the existing singleton*.
%
%      PHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHM.M with the given input arguments.
%
%      PHM('Property','Value',...) creates a new PHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stopphm.  All inputs are passed to phm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phm

% Last Modified by GUIDE v2.5 04-Apr-2016 14:12:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phm_OpeningFcn, ...
                   'gui_OutputFcn',  @phm_OutputFcn, ...
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


% --- Executes just before phm is made visible.
function phm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phm (see VARARGIN)

% Choose default command line output for phm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = phm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startphm.
function startphm_Callback(hObject, eventdata, handles)
% hObject    handle to startphm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = zeros(1,3);
n=0;
identityvar = 0;
s=serial('COM12','Baudrate',9600,'Databits',8);
fopen(s);
set(handles.connstat,'String','Connected','ForegroundColor','g');
while n<100
    idt=fgets(s);
    var = str2num(idt);
    if var==1
        set(handles.identity,'String','Patient1');
        m(1,1)= 1;
        identityvar=1;
    elseif var==2
        set(handles.identity,'String','Patient2');
        m(1,1)=2;
        identityvar=2;
    end  
    beats=fgets(s);
    beatsnum = str2num(beats);
    m(1,2)=beatsnum;
    set(handles.bpm,'String',beatsnum);
    if identityvar==1
        subplot(2,1,1);
        title('Patient 1');
        plot(n,beatsnum,'--rx','LineWidth',2,'Marker','s','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',5);
        hold on; drawnow();
    elseif identityvar==2
        subplot(2,1,2);
        title('Patient 2');
        plot(n,beatsnum,'--rx','LineWidth',2,'Marker','s','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',5);
        hold on; drawnow();
    end
    loca=fgets(s);
    locanum = str2num(loca);
    m(1,3)=locanum;
    if locanum==1
        set(handles.location,'String','Ward1');
    elseif locanum==2
        set(handles.location,'String','Ward2');
    end
    n=n+1;
    if identityvar==1
        dlmwrite('Patient1.csv',m,'delimiter',',','-append','newline','pc')
    elseif identityvar==2
        dlmwrite('Patient2.csv',m,'delimiter',',','-append','newline','pc')
    end
end
hold off;
subplot(2,1,1);
hold off;
    fclose(s);
    set(handles.disppanel,'String','Reconnect.');
    set(handles.connstat,'String','Disconnected','ForegroundColor','r');

% --- Executes on button press in stopphm.
function stopphm_Callback(hObject, eventdata, handles)
% hObject    handle to stopphm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.connstat,'String','Disconnected','ForegroundColor','r');


function connstat_Callback(hObject, eventdata, handles)
% hObject    handle to connstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of connstat as text
%        str2double(get(hObject,'String')) returns contents of connstat as a double


% --- Executes during object creation, after setting all properties.
function connstat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to connstat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop1.
function pop1_Callback(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop1


% --- Executes during object creation, after setting all properties.
function pop1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bpm_Callback(hObject, eventdata, handles)
% hObject    handle to bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bpm as text
%        str2double(get(hObject,'String')) returns contents of bpm as a double


% --- Executes during object creation, after setting all properties.
function bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function identity_Callback(hObject, eventdata, handles)
% hObject    handle to identity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of identity as text
%        str2double(get(hObject,'String')) returns contents of identity as a double


% --- Executes during object creation, after setting all properties.
function identity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to identity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gobutton1.
function gobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to gobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
!C:\Program Files\MATLAB\R2013a\bin\Patient1.csv

function location_Callback(hObject, eventdata, handles)
% hObject    handle to location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of location as text
%        str2double(get(hObject,'String')) returns contents of location as a double


% --- Executes during object creation, after setting all properties.
function location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disppanel_Callback(hObject, eventdata, handles)
% hObject    handle to disppanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disppanel as text
%        str2double(get(hObject,'String')) returns contents of disppanel as a double


% --- Executes during object creation, after setting all properties.
function disppanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disppanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gobutton2.
function gobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to gobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
!C:\Program Files\MATLAB\R2013a\bin\Patient2.csv