function [ handles ] = Save_ROI( handles )
% First asks the user which ROI will be saved 
% Saves the selected ROI

% Ask user to define which ROI will be saved
 number_ROI = num2str(handles.n);
 prompt = {['Write number of ROI to be saved. From 1 to ' number_ROI]};
 dlg_title = 'Saving ROI';
 num_lines = 1;
 defaultans = {'1'};
 answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
 n = str2double( answer );
 
 if n > numel(handles.h)
     warndlg('That ROI does not exist. Press "Save ROI" again','Warning')
     return
 end
 
 BW = handles.BW(:,:,n);
 uisave('BW', 'ROI');

 action = [ 'Saved ROI = ', number_ROI ]; % this will be the new string in the listbox
 
 handles.workflow = vertcat( handles.workflow, action );
 
 set(handles.listbox1,'string', handles.workflow );

 
 end
