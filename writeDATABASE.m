% Ele	Azi   Points
% -45	 15	    24
% -30	 15	    24
% -15	 15	    24
% 0	     15	    24
% 15	 15	    24
% 30	 15	    24
% 45	 15	    24
% 60	 30	    12
% 75	 60	     6
% 90	360	     1


% l_eq_hrir_S = 
% 
%          elev_v: [187x1 double]
%          azim_v: [187x1 double]
%          type_s: 'FIR'
%     sampling_hz: 44100
%       content_m: [187x512 double]


% const ircam_hrtf_filter_set_44 irc_1037 = 
% {
% 	{	// elev -45
% 		{	// 000
% 			{	// left
% 				
% 			},
% 			{	// right
% 
% 			}
% 		},
% 		{	// 015

%
%% structure of data set
clear l_eq_hrir_S
clear r_eq_hrir_S
eles = {-45:15:90};
azis = {[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:30:360-1],[0:60:360-1],[360]};
numazis = [24, 24, 24, 24, 24, 24, 24, 12, 6, 1];
%% load hrtf data from ircam listen database
participant = '1037';
data_filename = ['IRC_' participant filesep 'COMPENSATED/MAT/HRIR/IRC_' participant '_C_HRIR.mat'];
load(data_filename);

%% output cpp file with vectors storing the data as a structure object
fid = fopen ('pkmIRCAM_HRTF_DATABASE.cpp', 'w+');

% get the fft of the HRIR so we don't have to keep computing it during
% run-time
i = 1;
j = 1;

len = 512;

% output each of the 187 L/R vectors
fprintf(fid, 'const ircam_hrtf_filter_set irc_%s = \n{\n', participant);
for i = 1 : 186
    ele = l_eq_hrir_S.elev_v(i);
    azi = l_eq_hrir_S.azim_v(i);
    fprintf(fid, '\t// elev %d azi %d\n', ele, azi);
    fprintf(fid, '\t{\n');
    fprintf(fid, '\t\t{');
    for sample = 1 : len-1
        fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f},\n', l_eq_hrir_S.content_m(i,len));
    fprintf(fid, '\t\t{');
    for sample = 1 : len-1
        fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f}\n', r_eq_hrir_S.content_m(i,len));
    fprintf(fid, '\t},\n');
end
i = 187;
ele = l_eq_hrir_S.elev_v(i);
azi = l_eq_hrir_S.azim_v(i);
fprintf(fid, '\t// elev %d azi %d\n', ele, azi);
fprintf(fid, '\t{\n');
fprintf(fid, '\t\t{');
for sample = 1 : len-1
    fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
end
fprintf(fid, '%f},\n', l_eq_hrir_S.content_m(i,len));
fprintf(fid, '\t\t{');
for sample = 1 : len-1
    fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
end
fprintf(fid, '%f}\n', r_eq_hrir_S.content_m(i,len));
fprintf(fid, '\t}\n');
fprintf(fid, '};\n\n');

% keep an index of the positions for kNN
fprintf(fid, 'const float positions[][] = {\n');
for i = 1 : 186
    rad = 1.95;
    theta = pi/2.0 - deg2rad(l_eq_hrir_S.elev_v(i));
    phi = deg2rad(l_eq_hrir_S.azim_v(i));
    
    x = rad*sin(theta)*cos(phi);
    y = rad*sin(theta)*sin(phi);
    z = rad*cos(theta);
    
    fprintf(fid, '\t{%f,%f,%f},\n', x, y, z);
end
i = 187;
rad = 1.95;
theta = pi/2.0 - deg2rad(l_eq_hrir_S.elev_v(i));
phi = deg2rad(l_eq_hrir_S.azim_v(i));

x = rad*sin(theta)*cos(phi);
y = rad*sin(theta)*sin(phi);
z = rad*cos(theta);

fprintf(fid, '\t{%f,%f,%f}\n', x, y, z);
fprintf(fid, '};\n');
fclose(fid);
