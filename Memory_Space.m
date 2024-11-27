function handles = Memory_Space(handles)
%Calculates de free memory space and the amount o memory used by ToolVIA
%   Detailed explanation goes here

[handles.user, handles.sys] = memory;

handles.MEMUsedMATLAB = num2str( round(handles.user.MemUsedMATLAB/1000000) ); 
handles.PhysicalMemoryAvailable = num2str( round(handles.sys.PhysicalMemory.Available/1000000) );

handles.memory = sprintf(['Free Memory - '  handles.PhysicalMemoryAvailable ' MB\n ' 'Used by ToolVIA - ' handles.MEMUsedMATLAB ' MB']);
set( handles.txtMemorySpace, 'String', handles.memory);

end

