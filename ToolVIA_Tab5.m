function varargout = ToolVIA_Tab5(varargin)
% TOOLVIA_TAB5 MATLAB code for ToolVIA_Tab5.fig
%      TOOLVIA_TAB5, by itself, creates a new TOOLVIA_TAB5 or raises the existing
%      singleton*.
%
%      H = TOOLVIA_TAB5 returns the handle to a new TOOLVIA_TAB5 or the handle to
%      the existing singleton*.
%
%      TOOLVIA_TAB5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOOLVIA_TAB5.M with the given input arguments.
%
%      TOOLVIA_TAB5('Property','Value',...) creates a new TOOLVIA_TAB5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ToolVIA_Tab5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ToolVIA_Tab5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ToolVIA_Tab5

% Last Modified by GUIDE v2.5 18-Feb-2019 17:58:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ToolVIA_Tab5_OpeningFcn, ...
                   'gui_OutputFcn',  @ToolVIA_Tab5_OutputFcn, ...
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


% --- Executes just before ToolVIA_Tab5 is made visible.
function ToolVIA_Tab5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ToolVIA_Tab5 (see VARARGIN)

% % Choose default command line output for ToolVIA_Tab5
% handles.output = hObject;

% Choose default command line output for TabManagerExample
handles.output = hObject;

% Initialise tabs
handles.tabManager = TabManager( hObject );

% Set-up a selection changed function on the create tab groups
tabGroups = handles.tabManager.TabGroups;
for tgi=1:length(tabGroups)
    set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
end

handles.figure1.Name = mfilename; % force to change the name of the GUI; 'gui_Name' -> mfilename,

arrow_Img = imread('arrow_Img_gray_border.png');

set(handles.Axes_Arrow,'Units','pixels');
axes(handles.Axes_Arrow);
imshow(arrow_Img);
set(handles.Axes_Arrow,'Units','normalized');

% set( handles.txtStaticText, 'ForegroundColor', 'green' );
set( handles.txtStaticText, 'String', 'Welcome! First, add the Frame Step (ms), then load the file' );

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ToolVIA_Tab5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% Called when a user clicks on a tab
function tabChangedCB(src, eventdata)

disp(['Changing tab from ' eventdata.OldValue.Title ' to ' eventdata.NewValue.Title ] );


% --- Outputs from this function are returned to the command line.
function varargout = ToolVIA_Tab5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_load_TagA.
function btn_load_TagA_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_TagA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA02LoadData;



% --- Executes on button press in btn_Visualization_TagA.
function btn_Visualization_TagA_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Visualization_TagA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA02LoadData;

% --- Executes on button press in btn_PreProcessing_TagA.
function btn_PreProcessing_TagA_Callback(hObject, eventdata, handles)
% hObject    handle to btn_PreProcessing_TagA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA03PreProcessing;

% --- Executes on button press in btn_Analysis_TagA.
function btn_Analysis_TagA_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Analysis_TagA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA04Analysis;


function edtFrameStep_Callback(hObject, eventdata, handles)
% hObject    handle to edtFrameStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtFrameStep as text
%        str2double(get(hObject,'String')) returns contents of edtFrameStep as a double


% --- Executes during object creation, after setting all properties.
function edtFrameStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtFrameStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Load.
function btn_Load_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 % Make sure that user added info in frame steps
  
 FrameStep = str2double(get( handles.edtFrameStep, 'String' ));
 
if FrameStep * 1 == 0 % Confirm that the 'Add Frame Step' was filled 
    
    set( handles.txtStaticText, 'String', '!!!! Please, add first the Frame Step (ms), then load the file' );
    drawnow
    return
    
end

% Import microscope tiff stack and associated parameters

set( handles.txtStaticText, 'String', 'ToolVIA is Busy' );
drawnow


 [filename,PathName] = uigetfile('*.mat; *.tif; *.tiff', 'Select a File');
 handles.filename = filename;
 handles.PathName = PathName;
 
 handles =  Load_file(filename, PathName, handles);
 
set( handles.txtStaticText, 'String', 'Done');

% Memory Space
 handles = Memory_Space(handles);

% Update Listbox - Listbox is the window were the workflow is updated

 action = filename;

 handles.workflow = { 'Workflow'; action };
 
 set(handles.listbox1,'string', handles.workflow );
 
 
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btn_Reload.
function btn_Reload_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Reload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

if ~isfield(handles,'PathName') && ~isfield(handles,'filename')
     
    set( handles.txtStaticText, 'String', 'Please load file first' );
    
else  
    
    set( handles.txtStaticText, 'String', 'ToolVIA is Reloading' );
    drawnow
        
    filename = handles.filename;
    
    handles =  Load_file(filename, handles);
  
    set( handles.txtStaticText, 'String', 'Done Reloading');
 
end

% Memory Space
 handles = Memory_Space(handles);

 % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in btn_Visualize_FramebyFrame.
function btn_Visualize_FramebyFrame_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Visualize_FramebyFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Please Wait');
drawnow

Visualize_Tiff_Stack( handles.Img )

set( handles.txtStaticText, 'String', 'Done');

% Update Workflow

 action = 'Visualize Tiff Stack'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Memory Space
 handles = Memory_Space(handles);
 
 % Update handles structure
guidata(hObject, handles);



% --- Executes on button press in btn_Implay.
function btn_Implay_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Implay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Please Wait' );
 drawnow

 cm = implay( handles.Img ); % cm - colormap

% setting size of implay window and colormap
     
    cm.Parent.Position = [450 250 600 350];
    cm.Visual.ColorMap.Map = jet(256);
    cm.Visual.setPropertyValue('DataRangeMin', min( handles.Img(:) ));
    cm.Visual.setPropertyValue('DataRangeMax', max( handles.Img(:) ));
    cm.Visual.ColorMap.UserRange = 1;
    
     set( handles.txtStaticText, 'String', 'Done' );
     
     % Update Workflow

 action = 'Visualize as Movie'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_Avrg_Img.
function btn_Avrg_Img_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Avrg_Img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Avrg_Img = mean( handles.Img, 3 );

figure('Name', 'Average Fluorescence' ,'NumberTitle','off')

imshow( Avrg_Img, [], 'InitialMagnification', 'fit' );

% Update Workflow

 action = 'Visualize Average Image'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
  % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_MIP.
function btn_MIP_Callback(hObject, eventdata, handles)
% hObject    handle to btn_MIP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Generating MIP');
 drawnow

 MIP( handles.Img );

 set( handles.txtStaticText, 'String', 'MIP Done');
 
% Update listbox
 handles.workflow = get( handles.listbox1,'String' );
 
 action = 'Visualize MIP'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_PlotVsignal.
function btn_PlotVsignal_Callback(hObject, eventdata, handles)
% hObject    handle to btn_PlotVsignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 plot_Esignal( handles )
 
 % Update Workflow

 action = 'Plot V signal'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_Normalize_DFoF.
function btn_Normalize_DFoF_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Normalize_DFoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% DF/F0 = ( F(t) - F(t0) ) / F(t0)
% F(t)  := recorded fluorescence intensity at a given time
% F(t0) := fluorescence intensity at a resting membrane potencial (resting fluorescence) 
% Fbase, or F(t0) is calculated either from the first several frames
% (10-20) frames of the experiment for evoked activity, or from the median

Img_F_norm = Normalize_DFoF0_2( handles );

handles.F_norm = Img_F_norm;

% Update Workflow

 action = 'Normalized DF/F0 '; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
  % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_MIP_DFoF.
function btn_MIP_DFoF_Callback(hObject, eventdata, handles)
% hObject    handle to btn_MIP_DFoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MIP( handles.F_norm );

% Update Workflow

 action = 'MIP DF/F0'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btn_SaveVideo_DFoF.
function btn_SaveVideo_DFoF_Callback(hObject, eventdata, handles)
% hObject    handle to btn_SaveVideo_DFoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Save_video( handles.F_norm, handles.edtFrameStep  );

 action = 'Saved Video DF/F0'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_TimeDerivative.
function btn_TimeDerivative_Callback(hObject, eventdata, handles)
% hObject    handle to btn_TimeDerivative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D_dt  = Time_derivative( handles );


function edt_GF_Sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edt_GF_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_GF_Sigma as text
%        str2double(get(hObject,'String')) returns contents of edt_GF_Sigma as a double


% --- Executes during object creation, after setting all properties.
function edt_GF_Sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_GF_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_GFApplyCorrection.
function btn_GFApplyCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to btn_GFApplyCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if isfield( handles, 'temp_Img' )
        
    handles.Img = handles.temp_Img;
    
    clear handles.temp_Img
    
    Visualize_Tiff_Stack( handles.Img )
    
    sigma = str2double( get( handles.edt_GF_Sigma, 'String' ) );
    fig = gcf; % current figure handle
    fig.Name = [ 'Gaussian Filter; sigma = ', num2str(sigma) ]; % figure that comes from the preview
    
else

    sigma = str2double( get( handles.edt_GF_Sigma, 'String' ) );
%     kernel = fspecial( 'gaussian', ceil( 3*sigma ) , sigma);

[ handles ] = Gaussian_Filter( handles, sigma ); 

fig = gcf; % current figure handle
fig.Name = [ 'Gaussian Filter; sigma = ', num2str(sigma) ];

set( handles.txtStaticText, 'String', 'Done');

end  
 
% Update Workflow

 action = [ 'Gaussian Filter; sigma = ', get( handles.edt_GF_Sigma, 'String' )]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_GFPreview.
function btn_GFPreview_Callback(hObject, eventdata, handles)
% hObject    handle to btn_GFPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = str2double( get( handles.edt_GF_Sigma, 'String' ) );

%Message panel
 set( handles.txtStaticText, 'String', ['Preparing preview of Gaussian Filter, Sigma = ' num2str(sigma)] );
 drawnow

[ handles ] = Gaussian_Filter( handles, sigma ); 
 
% Change figure title
fig = gcf; % current figure handle
fig.Name = [ 'Preview Gaussian Filter; sigma = ', num2str(sigma) ];

set( handles.txtStaticText, 'String', 'Done');

% Update Workflow

 action = [ 'Preview Gaussian Filter; sigma = ', get( handles.edt_GF_Sigma, 'String' )]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_ApplyBinning.
function btn_ApplyBinning_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ApplyBinning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Performing Binning' )
drawnow

[ handles, ppmBinning_value ] = Binning( handles );

 action = [ 'Binning -> ', num2str(ppmBinning_value)]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
% Update handles structure
 guidata(hObject, handles);


% --- Executes on selection change in ppmBinning.
function ppmBinning_Callback(hObject, eventdata, handles)
% hObject    handle to ppmBinning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppmBinning contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppmBinning




% --- Executes during object creation, after setting all properties.
function ppmBinning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppmBinning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_FApplyCorrection.
function btn_FApplyCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to btn_FApplyCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 set( handles.txtStaticText, 'String', 'Applying Correction' );
 drawnow
 
 handles.timeStamps = ( 0 : size( handles.Img, 3 ) -1 ) * str2double( get(handles.edtFrameStep, 'String' ));
 
 handles.Img = Photobleaching_Correction( handles.Img, handles.timeStamps );

 set( handles.txtStaticText, 'String', 'Photobleach Corrected' );
  
 % Update Workflow

 action = 'Phtobleach Corrected'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_FProfile.
function btn_FProfile_Callback(hObject, eventdata, handles)
% hObject    handle to btn_FProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 set( handles.txtStaticText, 'String', 'Drawing Profile' );
 drawnow
 
 handles.timeStamps = ( 0 : size( handles.Img, 3 ) -1 ) * str2double( get(handles.edtFrameStep, 'String' ));
 
 Fluorescence_Profile( handles.Img, handles.timeStamps  );
 
 set( handles.txtStaticText, 'String', 'Fluorescence Profile Done' );
 
 assignin('base', 'timeStamps', handles.timeStamps); % test to see how to export to a variable to the workspace of matlab
 
 % Update Workflow

 action = 'Fluorescent Profile'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_F_ApplyCorrection_Threshold.
function btn_F_ApplyCorrection_Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to btn_F_ApplyCorrection_Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Applying Correction' );
 drawnow
 
 handles.timeStamps = ( 0 : size( handles.Img, 3 ) -1 ) * str2double( get(handles.edtFrameStep, 'String' ));
 
 handles.time_profile_Img = squeeze(mean( mean( handles.Img) ))';
  
 figure ('Name', 'Fluorescence Profile - Photobleach' ,'NumberTitle','off')
 plot( handles.timeStamps, handles.time_profile_Img, 'b' );
 xlabel( 'Time [ms]' );
 ylabel( 'Intensity [a.u.]' );
 title( 'Please select threshold level (to exclude activity from the fit)' );
 
 % Get threshold
 [~,threshold] = ginput(1);
 weights = ones( size( handles.time_profile_Img ) );
 weights( handles.time_profile_Img > threshold ) = 0; 
 
 handles.Img = Photobleaching_Correction( handles.Img, handles.timeStamps, weights );
 
 set( handles.txtStaticText, 'String', 'Photobleach Corrected' );
 
% Update Workflow

 action = 'Photobleach Corrected w/Threshold'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_F_LoadTrial.
function btn_F_LoadTrial_Callback(hObject, eventdata, handles)
% hObject    handle to btn_F_LoadTrial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'ToolVIA is Busy' );
drawnow

[filename,PathName] = uigetfile('*.tif;*.tiff;*.mat','Select the file');

% Code to open files from Marco Canepari

 [pathstr,name, ext] = fileparts(filename);
        
if ext == '.mat'
    
    load( filename );
    handles.Nframes_trial = size(Y, 3);

     if size(Y, 1) >= 80
         
         handles.Img_trial = Y;
        
     elseif size( Y, 1 ) == 26
      
         handles.Img_trial = Y( :, 1:26, :);
    
     else
         
         handles.Img_trial = Y( :, 27:end, : );
        
     end
    
 else

    % Code to import tiff stacks     
     
    % IMPORTAR USANDO FUNCOES MAIS RECENTES [PAULO]
    [Img, SizeX, SizeY, Nstacks, Nframes, z_step , frame_step, px2um] = Import_Microscope_Tiff_Stack( [PathName, filename] );

    % [Img, SizeX, SizeY, Nframes ] = New_Import_Tiff_Stack( [PathName, filename] );

    handles.filename = filename;
    handles.PathName = PathName;

    handles.Img_trial = squeeze( Img );
    handles.SizeX_trial = SizeX;
    handles.SizeY_trial = SizeY;
    handles.Nstacks_trial = Nstacks;
    handles.Nframes_trial = Nframes;
    handles.z_step_trial = z_step;
    handles.frame_step_trial = frame_step;
    handles.px2um_trial = px2um;


end

set( handles.txtStaticText, 'String', 'Done');

% Memory Space

[handles.user, handles.sys] = memory;

handles.MEMUsedMATLAB = num2str( round(handles.user.MemUsedMATLAB/1000000) ); 
handles.PhysicalMemoryAvailable = num2str( round(handles.sys.PhysicalMemory.Available/1000000) );

handles.memory = sprintf(['Free Memory\n'  handles.PhysicalMemoryAvailable ' MB\n ' 'Used by ToolVIA\n' handles.MEMUsedMATLAB ' MB']);
set( handles.txtMemorySpace, 'String', handles.memory);

% Update Workflow

 action = 'Loaded Photobleach Trial'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_F_ApplyCorrection_Trial.
function btn_F_ApplyCorrection_Trial_Callback(hObject, eventdata, handles)
% hObject    handle to btn_F_ApplyCorrection_Trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ Img_Corrected ] = Photobleaching_Trial_Subtraction( handles.Img_trial, handles.Img, handles.timeStamps );

handles.Img = Img_Corrected;

% Update Workflow

 action = 'Photobleach Corrected w/Trial'; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_F_ApplyCorretionPxbyPx.
function btn_F_ApplyCorretionPxbyPx_Callback(hObject, eventdata, handles)
% hObject    handle to btn_F_ApplyCorretionPxbyPx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.txtStaticText, 'String', 'Applying Correction Pixel by Pixel' );
 drawnow
 
 handles.timeStamps = ( 0 : size( handles.Img, 3 ) -1 ) * str2double( get(handles.edtFrameStep, 'String' ));
 
handles.Img = Photobleaching_Correction_PxbyPx( handles.Img, handles.timeStamps );

Info = 'Photobleach corrected Pixel by Pixel'; % to use with the load function; distinguish to other .mat files
  
Y = handles.Img; % *the load function looks for the Y variable in .mat files 

 % Ask user to save photbleach corrected video
choice = questdlg('Do you want to save the photobleach corrected file?', ...
	'Save', 'Yes', 'No', 'Yes');

% Handle response
switch choice
    case 'Yes'
        prompt = {'Enter filename'};
        dlg_title = 'Input';
        num_lines = 1;
        defaultans = {handles.filename};
        new_name = inputdlg(prompt,dlg_title,num_lines,defaultans);
        new_name = [handles.PathName new_name{:}];
        save( new_name, 'Y', 'Info', '-v7.3' );
        
    case 'No'
        clear Info;
end
 
 set( handles.txtStaticText, 'String', 'Photobleach Corrected' );
  
 % Update handles structure
 guidata(hObject, handles);


% --- Executes on selection change in ppmMedianFilter.
function ppmMedianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to ppmMedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppmMedianFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppmMedianFilter


% --- Executes during object creation, after setting all properties.
function ppmMedianFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppmMedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_MedianFilter.
function btn_MedianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to btn_MedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 set( handles.txtStaticText, 'String', 'Applying Median Filter' )
drawnow

% Import n from ppmMedianFilter
 contents = get(handles.ppmMedianFilter,'String'); 
 ppmMedianFilter_value = contents{get(handles.ppmMedianFilter,'Value')};
 
 if ppmMedianFilter_value == '3'    
     n = 3;     
 else     
     n = 5;     
 end

 nframes = size( handles.Img, 3);

% Apply a median filter with a kernel of size n x n to every frame
 for f = 1:nframes
    handles.Img(:,:,f) = medfilt2( handles.Img(:,:,f), [n, n], 'symmetric' );
 end

 set( handles.txtStaticText, 'String', 'Done' );
 
 % Update Workflow

 action = [ 'Median Filter; n = ', num2str( n ) ]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 

 % Update handles structure
 guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Axes_Arrow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Axes_Arrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Axes_Arrow


% --- Executes on button press in btn_DrawROI.
function btn_DrawROI_Callback(hObject, eventdata, handles)
% hObject    handle to btn_DrawROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles = DrawROI( handles );
 
 % Update Workflow
 b = get( handles.btnGroupROIShape ); % get properties of btnGroupROIShape
 a = get( handles.btnGroupChooseImg ); % get properties of btnGroupChooseImg
 action = [ a.SelectedObject.String, ';', b.SelectedObject.String ]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );


% Update handles structure
 guidata(hObject, handles);



% --- Executes on button press in btn_AddROI.
function btn_AddROI_Callback(hObject, eventdata, handles)
% hObject    handle to btn_AddROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles = Draw_AnotherROI( handles );
   
     % Update Workflow

 b = get( handles.btnGroupROIShape ); % get properties of btnGroupROIShape
 a = get( handles.btnGroupChooseImg ); % get properties of btnGroupChooseImg
 action = [ a.SelectedObject.String, ';', b.SelectedObject.String ]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

    
     % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_SaveROI.
function btn_SaveROI_Callback(hObject, eventdata, handles)
% hObject    handle to btn_SaveROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles = Save_ROI( handles );


 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_LoadROI.
function btn_LoadROI_Callback(hObject, eventdata, handles)
% hObject    handle to btn_LoadROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open a saved ROI and add it to the handles.ROI to be used in the ROI Analysis
 handles = Load_ROI( handles );

 % Update handles structure
 guidata(hObject, handles);


function edtFrameNumber_Callback(hObject, eventdata, handles)
% hObject    handle to edtFrameNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtFrameNumber as text
%        str2double(get(hObject,'String')) returns contents of edtFrameNumber as a double


% --- Executes during object creation, after setting all properties.
function edtFrameNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtFrameNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_AutomaticSegmentation.
function btn_AutomaticSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to btn_AutomaticSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 Img_MIP = max( handles.Img, [], 3 );
 Img_MIP = Img_MIP / max( Img_MIP( : ));

 figure
 imagesc( Img_MIP )
 axis 'image'

% BW = im2bw( Img_MIP, graythresh( Img_MIP ) );
 BW = imbinarize( Img_MIP, 'adaptive' );

% BW = bwareaopen( BW, 50 );
% BW = bwmorph( BW, 'close' );
% BW = bwlabel( BW, 4 );

 figure
 subplot(2,1,1)
 imagesc( Img_MIP )
 axis 'image'
 subplot(2,1,2)
 imagesc( BW )
 axis 'image'

 % Update handles structure
 guidata(hObject, handles);


% --- Executes on button press in btn_ImageSegmenter.
function btn_ImageSegmenter_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ImageSegmenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Img_MIP = max( handles.Img, [], 3 );
% Comando/app muito interessante - a experimentar!:
imageSegmenter( Img_MIP )

% Update handles structure
 guidata(hObject, handles);
 

% --- Executes on button press in btn_Calibrate.
function btn_Calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_ROI_NormalizeDFoF.
function btn_ROI_NormalizeDFoF_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ROI_NormalizeDFoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles.timeStamps = (0: handles.Nframes - 1) * str2double( get(handles.edtFrameStep, 'String')); %in case that was not calculated before  

 [ handles ] = ROI_Normalize_DFoF0( handles );

 
        % Update handles structure
 guidata(hObject, handles);
 

% --- Executes on button press in btn_ROI_TimeDerivative.
function btn_ROI_TimeDerivative_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ROI_TimeDerivative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time_profile_Img = squeeze( mean( handles.ROI_F_norm ) );

time_profile_Img_sm = smooth( time_profile_Img, 'sgolay', 2 );

D_dt = ( diff( time_profile_Img_sm ) ./ diff( handles.timeStamps ) );

% Label ROI
     if isfield(handles, 'load_ROI')
         label = 'Loaded';
%          handles = rmfield(handles, 'load_ROI'); % removes the field, so nest time this function analysis drawn ROIs
     else
         label = num2str(handles.n); % add number of ROI to figure title
     end
% ROI_Number = num2str(handles.n);
figure( 'Name',[ 'Time derivative of ROI Nº ' label],'NumberTitle','off' )
subplot( 2, 1, 1)
plot( handles.timeStamps, time_profile_Img, 'b', handles.timeStamps, time_profile_Img_sm, 'r' ); 
title( 'Smooth - Savitzky-Golay filter' );
xlabel( 'Time [ms]' );
ylabel( 'Intensity [a.u.]' );
legend('raw signal', 'smooth - sgolay', 'Orientation', 'horizontal', 'Location', 'best');

subplot( 2, 1, 2)
plot ( handles.timeStamps(2:end), D_dt );
title( 'Time derivative' );
xlabel( 'Time [ms]' );
ylabel( 'Intensity [a.u.]' );


% Update Workflow

 action = [ 'Time derivative - ROI Nº ' label]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );
 
  % Update handles structure
 guidata(hObject, handles);

% --- Executes on button press in btn_ROI_FProfile.
function btn_ROI_FProfile_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ROI_FProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles.timeStamps = (0: handles.Nframes - 1) * str2double( get(handles.edtFrameStep, 'String')); %in case that was not calculated before 

[ handles ] = ROI_FProfile( handles ); 
        
  % Update handles structure
 guidata(hObject, handles);

% --- Executes on button press in btn_GetSpikeEvents.
function btn_GetSpikeEvents_Callback(hObject, eventdata, handles)
% hObject    handle to btn_GetSpikeEvents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ SE ] = GetSpikeEvents_IVConversion( handles );

  % Update handles structure
 guidata(hObject, handles);

% --- Executes on button press in btn_ROI_EstimateFiringRate.
function btn_ROI_EstimateFiringRate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ROI_EstimateFiringRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edt_SD_Sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edt_SD_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_SD_Sigma as text
%        str2double(get(hObject,'String')) returns contents of edt_SD_Sigma as a double


% --- Executes during object creation, after setting all properties.
function edt_SD_Sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_SD_Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Export_Graph_Data.
function btn_Export_Graph_Data_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Export_Graph_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 mydlg = warndlg('First choose the graph and then click OK');
 waitfor(mydlg);

 Current_Fig_Handle = gcf; %current figure handle

[Xdata,Ydata] = Export_Figure_Data(Current_Fig_Handle);

assignin('base', 'Xdata', Xdata); %ssigns the value val to the variable var in the workspace 'base'
assignin('base', 'Ydata', Ydata);


% --- Executes on button press in btn_PA_SignalParameters.
function btn_PA_SignalParameters_Callback(hObject, eventdata, handles)
% hObject    handle to btn_PA_SignalParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [signalprops] = FitSignalParameters( handles );
  % Update Listbox - Signal parameters

%  action = filename;

    amplitude = num2str(signalprops.amplitude);
    t_decay = num2str(signalprops.t_decay);

  SignalParameters = sprintf(['Amplitude = ' amplitude '\n' 'T_decay = ' t_decay ]);
  set(handles.lb_PA_SignalParameters,'string', SignalParameters );
 
    

  % Update handles structure
 guidata(hObject, handles);

% --- Executes on button press in btn_PA_GrangerCausality.
function btn_PA_GrangerCausality_Callback(hObject, eventdata, handles)
% hObject    handle to btn_PA_GrangerCausality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 [GC_test] = Calculate_Granger_Causality( handles );
 
 f = warndlg('', 'result' );

  % Update handles structure
 guidata(hObject, handles);

% --- Executes on button press in btn_PA_PropagationVelocity.
function btn_PA_PropagationVelocity_Callback(hObject, eventdata, handles)
% hObject    handle to btn_PA_PropagationVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


  % Update handles structure
 guidata(hObject, handles);



function edt_PA_SignificanceLevel_Callback(hObject, eventdata, handles)
% hObject    handle to edt_PA_SignificanceLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_PA_SignificanceLevel as text
%        str2double(get(hObject,'String')) returns contents of edt_PA_SignificanceLevel as a double


% --- Executes during object creation, after setting all properties.
function edt_PA_SignificanceLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_PA_SignificanceLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_PA_MaxDelay_Callback(hObject, eventdata, handles)
% hObject    handle to edt_PA_MaxDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_PA_MaxDelay as text
%        str2double(get(hObject,'String')) returns contents of edt_PA_MaxDelay as a double


% --- Executes during object creation, after setting all properties.
function edt_PA_MaxDelay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_PA_MaxDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_PA_SignalParameters.
function lb_PA_SignalParameters_Callback(hObject, eventdata, handles)
% hObject    handle to lb_PA_SignalParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_PA_SignalParameters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_PA_SignalParameters


% --- Executes during object creation, after setting all properties.
function lb_PA_SignalParameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_PA_SignalParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
