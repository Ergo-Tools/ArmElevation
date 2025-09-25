function status=writeElevToWAV(filename, Elevation,info)
% writeElevToWAV Writes the supplied, evenly sampled Elevation angle data to a WAV file
% Date: 2020-01-13 12:41, (c) 2019, Pasan Hettiarachchi, Uppsala University
% Inputs:
%   Elevation: [N,1]: Elevation  data in degrees or radians (info.Scale should be set correctly)
%   filename: char/string: filename to be used in saving data including (*.wav) extention
%   info : structure containing Start-Stop times etc
% Outputs:
%    status: 'OK' if everything is fine, error message otherwise
% The function additionally stores:
%   * uses the 'artist' field to record information about the device.
%   * uses the 'title' field to record information on the session (id, start/end time)
%   * uses the 'comment' field to record file information
%

% Copyright (c) 2021, Pasan Hettiarachchi .
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without 
% modification, are permitted provided that the following conditions are met: 
% 1. Redistributions of source code must retain the above copyright notice, 
%    this list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright notice, 
%    this list of conditions and the following disclaimer in the documentation 
%    and/or other materials provided with the distribution.
% 3. Neither the name of the copyright holder nor the names of its contributors
%    may be used to endorse or promote products derived from this software without
%    specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.  

try
    % the scaling factor when converting ACC data to uint16
    scale=info.Scale; % the angles are 0 to 180 degrees
    
    % Check parameter validity
    if size(Elevation,2)~=1
        error('Parameter data must be a vector');
    end
    
   
   
    % Scale to 16-bit data and add auxilliary channel (typecast from unsigned 16-bit to signed 16-bit)
    data16 = int16(Elevation.*(32768 / scale));
    
    % Audio information structure
    ai = {};
    ai.SampleRate = info.Fs;
    
    %scale=sprintf('%d',scale);
    
    
    % Device information (stored to artist)
    % deviceInformation = struct('deviceType','AX3','deviceVersion',17,'deviceId',12345,'firmwareVersion',42);
    str = "Id: "+ info.deviceId;
    ai.Artist = str;
    
    
    % Subject information (stored to title)
    % subjectInformation = struct('sessionId',sessionId,'startTime',startTime,'stopTime',stopTime,'accelRate',accelRate,'accelSensitivity',accelSensitivity,'metadata','"' + metadata + '"');
    str = "Activity: "+ info.Activity +newline;
    str=str+"Start: "+ info.Start +newline;
    str=str+"Stop: "+info.Stop;
    ai.Title = str;
    
    
    % File information (stored to comment)
    str = "Time: " + info.Start +newline;
    str = str + "Channel-1: Elevation Angle"+newline;
    str = str + "Scale-1: "+scale;
    ai.Comment = str;
    
    
    % Write file
    audiowrite(filename, data16, ai.SampleRate, 'BitsPerSample',16, 'Artist',ai.Artist, 'Title',ai.Title, 'Comment',ai.Comment);
    status='OK';
catch ME
    
    status=ME.message;
    
    %rethrow(ME);
end