function figNumber = fuzzy_animinit(namestr)
%FUZZY_ANIMINIT Initializes a figure for Simulink animations.
%  

% Copyright 2023 The MathWorks, Inc.
  
if (nargin == 0)
  namestr = 'Simulink Animation';
end

figNumber = findobj('Type','figure','Name',namestr)';

if isempty(figNumber)
  % Now initialize the whole figure...
  position=get(0,'DefaultFigurePosition');
  position(3:4)=[400 300];
  figNumber=figure( ...
      'Name',namestr, ...
      'WindowStyle','normal', ...
      'NumberTitle','off', ...
      'Position',position, ...
      'MenuBar', 'none');
  axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.1 0.70 0.9], ...
      'XTick',[],'YTick',[], ...
      'Visible','off');

  %====================================
  % Information for all buttons
  bottom=0.05;
  left=0.80;
  btnWid=0.15;
  btnHt=0.10;
    
  %====================================
  % The CONSOLE frame
  frmBorder=0.02;
  yPos=0.05-frmBorder;
  frmPos=[left-frmBorder yPos btnWid+2*frmBorder 0.9+2*frmBorder];
  h=uicontrol( ...
      'Style','frame', ...
      'Units','normalized', ...
      'Position',frmPos, ...
      'BackgroundColor',[0.5 0.5 0.5]); %#ok<NASGU>
  
  %====================================
  % The CLOSE button
  labelStr='Close';
  callbackStr='close(gcf)';
  closeHndl=uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',[left bottom btnWid btnHt], ...
      'String',labelStr, ...
      'Callback',callbackStr); %#ok<NASGU>
else
    % bring figure to foreground
    figure(figNumber)
end