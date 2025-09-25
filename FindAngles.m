function  [normAcc,Inc,U,filtAcc,vmAcc] = FindAngles(Acc,SF,Fc)

% Find quasi-static angles wth respect to gravity from triaxial acceleratio data  
% Inputs:
%   Acc: [N x 3] triaxial accleleration data
%   SF: the sample frequency
%   Fc: the cutoff frequency for low pass filter
% Outputs:
%   vmAcc[N x 1]: the vector magnitude of acceleration
%   normAcc[N x 3] : The normalized filtered triaxial acceleration data
%   Inc: [N x 1] the angle of accelerometer x-axis  with respect to gravity
%   U: [N x 1] the angle of accelerometer z-axis  with respect to gravity

% Copyright (c) 2022, Pasan Hettiarachchi .
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
   
     
   [Blp,Alp] = butter(6,Fc/(SF/2)); %6th order butterworth filter at Fc
   % filter Acc signal
   filtAcc = filter(Blp,Alp,-Acc); % -Acc is correction for axivity accelerometers (x-axis is -1 when it's pointing downwards)
   % find the vector magnitude of acceleration signals
   vmAcc = sqrt(filtAcc(:,1).^2 + filtAcc(:,2).^2 + filtAcc(:,3).^2);
   % normalize triaxial-acc data by dividing it by vector-magnitude
   normAcc = filtAcc./repmat(vmAcc,1,3);
   % find the angle between accelerometer x-axis and gravity
   Inc = acosd(normAcc(:,1));
   % find the angle between accelerometer z-axis and gravity
   U = -asind(normAcc(:,3));
   
   