function varargout = gui_mouse(varargin)
% GUI_MOUSE M-file for gui_mouse.fig
%	     GUI_MOUSE apo mono tou dimiourgei ena neo GUI_MOUSE h anebazei to yparxon singleton
%	     signleton = tonos tis notas.
%
%	     H = GUI_MOUSE kanei return to xirismo apo to neo GUI_MOUSE h ton xirismo apo to 
%      idi yparxon singleton.
%
%      GUI_MOUSE('CALLBACK',hObject,eventData,handles,...) kalei to local
%      function CALLBACK sto GUI_MOUSE.M
%
%	     GUI_MOUSE('Property','Value',...) dimiourgei ena neo GUI_MOUSE h h anebazei to 
%	     yparxon singleton. Arxizei apo aristera, opou to property value pairs
%	     (zeugos idiotitas) opou efarmozonte sto GUI prin to gui_mouse_OpeningFcn
%	     klithei. Ena mi anagnorismeno onoma idiotitas kanei etima na diakopsei tin 
%	     idiotita. Ola ta inputs pernoun mesa apo to gui_mouse_OpeningFcn 
%	     meso varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_mouse

% Last Modified by GUIDE v2.5 26-Apr-2022 19:15:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_mouse_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_mouse_OutputFcn, ...
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


% -- Executes just before gui_mouse is made visible.
function gui_mouse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    xirismos tou figure
% eventdata  reserved - kathorizete apo to MATLAB gia mellontika version
% handles    structure gia ton xirismo kai ta user data (GUIDATA)
% varargin   command line arguments to gui_mouse (VARARGIN)

% Epilogi gia default command line output gia to gui_mouse
handles.output = hObject;

% Update handles structure - Gia na ginei update o xirismos tous structures
guidata(hObject, handles);

% UIWAIT kanei to gui_mouse na perimenei ton xristi na kanei kati (UIRESUME)
% uiwait(handles.fig_mouse);


% -- Ta outputs apo auti tin sinartisi epistrefonte sto to command line.
function varargout = gui_mouse_OutputFcn(hObject, eventdata, handles) 
% varargout  ta stixia ton keliwn (cell array) epistrefoun ta output args (VARARGOUT);

% Pernei default command line output apo to xirismo tou structure
varargout{1} = handles.output;
global note
% -- Ektelite otan patisoume me to mouse mas panw sto figure, panw apo ena anenergo h
% -- adranes control (inactive control), h pano sto fonto tou background.
function fig_mouse_WindowButtonDownFcn(hObject, eventdata, handles)

pos = get(hObject, 'currentpoint');  % pernei to location tou mouse panw sto figure
x = pos(1); y = pos(2); % prosdiorizei ta locations tou x kai y tou mouse

fret = 25 - fix(x/50); % ypologizei to fret number apo ta aristera dierontas to x
			                 % location tou mouse apo to mikos 1 fret [50px]
			                 % ypologizei to fret number apo ta de3ia me aferesi
			                 % tou de3iou ari8mou fred apo ta 25 (25 epidi yparxoun 24 
			                 % fred stin ki8ara mas)
string = fix(y/50); % ypologizei to string dierontas tin thesi tou y
			              % tou mouse me tin apostasi meta3i twn 2 xordwn

Fs    = 50; % einai h sixnotita digmatolipsias (frequency) gia tin anaparagogi hxou
Ts    = 1/500; % xronos digmatolipsias (sampling period)
measure = str2num(get(handles.txtMesLen, 'string')); % pernei to metro(measure) 
                                                     %gia to opio tha pexti h ka8e nota 
t1    = [0:Ts:measure]; %full note
t2    = [0:Ts:measure/2]; %half note
t4    = [0:Ts:measure/4]; %quarter note

if ((rem(y,50)>=0)&&(rem(y,50)<=5))&&((y<=305)&&(y>=50))...
        &&((get(handles.chkNoteClk,'Value') == get(handles.chkNoteClk,'Max')))
	  % CONDITION 1
	  % O xristis kanei click se ena string, to apotelesma tis dieresis tis thesis y
	  % tou mouse me to mikos enos string tha einai apo 0 ws to 5 (to mikos kathe string
	  % einai 5px) 		--- exposed portion ---
    
    % CONDITION 2
	  % O xrisis kanei click stin perioxi tis ki8aras ara h y thesi tou pontikiou
	  % (mouse location) einai meta3i to 50 me 305.
    
    % CONDITION 3
	  % Otan epile3oume to playing a note on 'mouse click'
	  % an tirounte oi proipo8esis, tha akousoume tin nota
    note = NoteGen(t4, string, fret); 
    sound(note, Fs);
end


% -- Ektelite me tin kinisi tou mouse panw apo tin eikona twn xordwn
function fig_mouse_WindowButtonMotionFcn(hObject, eventdata, handles)
global note
pos = get(hObject, 'currentpoint'); % pernei to location tou mouse panw sto figure
x = pos(1); y = pos(2); % prosdiorismos tou x kai y tou mouse

fret = 25 - fix(x/50); % ypologizei to fret number apo ta aristera dierontas tin 8esi tou x
			                 % location tou mouse apo to mikos 1 fret [50px]
			                 % ypologizei to fret number apo ta de3ia me aferesi
			                 % tou de3iou ari8mou fred apo ta 25 (25 epidi yparxoun 24 
			                 % fred stin ki8ara mas
string = fix(y/50); % ypologizei to string number dierontas tin thesi tou y
			              % tou mouse me tin apostasi meta3i twn 2 xordwn [50px]

Fs    = 8000; %sampling frequency for audio playback
Ts    = 1/Fs; %sampling period
measure = str2num(get(handles.txtMesLen, 'string')); % pernei to metro(measure) 
% gia to opio tha pexti h ka8e nota
t1    = [0:Ts:measure]; %full note
t2    = [0:Ts:measure/2]; %half note
t4    = [0:Ts:measure/4]; %quarter note

if ((rem(y,50)>=0)&&(rem(y,50)<=5))&&((y<=305)&&(y>=50))
	  % CONDITION 1
	  % O xristis kanei click se ena string, to apotelesma tis dieresis tis thesis y
	  % tou mouse me to mikos enos string tha einai apo 0 ws to 5 (to mikos kathe string
	  % einai 5px) 		--- exposed portion ---
    
    % CONDITION 2
	  % O xrisis kanei click stin perioxi tis ki8aras ara h y thesi tou pontikiou
	  % (mouse location) einai meta3i to 50 me 305.
    if ((get(handles.chkNoteMouse,'Value') == get(handles.chkNoteMouse,'Max')))
	  % An o xristis epile3ei to kouti playing a note when
    %the mouse 'moves', tha pe3ei tin antistixi nota
        note = NoteGen(t4, string, fret); 
        sound(note, Fs);
    end
    switch string 	% Briskei to string pou antistixei sto string number
			              % sindiazontas to me ton fret number kai ton dixnei 
			              % stin panw de3ia gonia 
        case 6;
            str = 'Low E';
        case 5;
            str = 'A';
        case 4;
            str = 'd';
        case 3;
            str = 'g';
        case 2;
            str = 'b';
        case 1;
            str = 'High e';
    end
    set(handles.txtNotePos, 'string', ['string: ' str ' & fret: ' num2str(fret)]);
else
    set(handles.txtNotePos, 'string', ['--------']);
end

function txtMesLen_Callback(hObject, eventdata, handles)
% hObject    xirismos tou txtMesLen (GCBO)

% Hints: get(hObject,'String') kanei return ta content tou txtMesLen san text
%        str2double(get(hObject,'String')) kanei reutrn ta content tou txtMesLen san double

% -- Kanei execute kata tin diarkia pou dimiourgite kapio object, otan oristoun oles oi idiotites tou
function txtMesLen_CreateFcn(hObject, eventdata, handles)
% hObject    xirismos tou txtMesLen (GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - den dimiourgite handles mexri na kalesei ola ta CreateFcns

%UI
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -- Kanei execute otan patame to koumpi sto chkNoteClk.
function chkNoteClk_Callback(hObject, eventdata, handles)

% Hint: pernei (hObject,'Value') epistrefei tin katastasi enalagis tis chkNoteClk

% -- Ektelite otan patame to koumpi chkNoteMouse.
function chkNoteMouse_Callback(hObject, eventdata, handles)

% Hint: pernei (hObject,'Value') epistrefei tin katastasi enalagis tis chkNoteMouse


% -- Ektelite otan patame to koumpi pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
close all;


function edit2_Callback(hObject, eventdata, handles)
% hObject    xirismos tis edit2 

% Hints: pernei (hObject,'String') epistrefei to periexomeno edit2 san text
%        str2double(get(hObject,'String')) epistrefei to periexomeno edit2 san double


% --- Ektelite kata tin dimiourgia kapiou object.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Ektelite otan patame to pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    xirismos tou pushbutton5

global note
audiowrite('SoundGuitar5.wav',note,8000) % gia na kanoume export to hxitiko arxio
                                         % dinoume onoma
