function [Xdata,Ydata] = Export_Figure_Data(Current_Fig_Handle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Current_Fig_Handle = gcf; %current figure handle 


dataObjs = findobj(Current_Fig_Handle,'Type','line');

 if size( dataObjs, 1 ) > 1

    Xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
    Xdata = Xdata{ 2, 1};
    Ydata = get(dataObjs, 'YData');
    Ydata = Ydata{ 2, 1};
    
 else 
     
    Xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
    Ydata = get(dataObjs, 'YData');

 end
end

