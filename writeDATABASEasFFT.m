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
eles = {-45:15:90};
azis = {[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:15:360-1],[0:30:360-1],[0:60:360-1],[360]};
numazis = [24, 24, 24, 24, 24, 24, 24, 12, 6, 1];
%% load hrtf data from ircam listen database
participant = '1037';
data_filename = ['IRC_' participant filesep 'COMPENSATED/MAT/HRIR/IRC_' participant '_C_HRIR.mat'];
load(data_filename);

%% output cpp file with vectors storing the data as a structure object
fid = fopen ('pkmIRCAM_HRTF_DATABASE.cpp', 'w+');

fprintf(fid, 'const ircam_hrtf_filter_set_44 irc_1037 = \n{\n');
i = 1;
j = 1;
for a = 1 : 187
    l_eq_hrir_S.content_m(a,:) = abs(fft(l_eq_hrir_S.content_m(a,:)));
    r_eq_hrir_S.content_m(a,:) = abs(fft(r_eq_hrir_S.content_m(a,:)));
end

% 187 vectors
for k = 1 : 9
    ele = l_eq_hrir_S.elev_v(i);
    fprintf(fid, '\t{\t// elev %d\n', ele);
    for azi = 1 : numazis(j) - 1
        fprintf(fid, '\t\t{\t// azi %d\n', l_eq_hrir_S.azim_v(i));
        fprintf(fid, '\t\t\t{\t// left\n\t\t\t\t\t');
        for sample = 1 : 255
            fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
        end
        fprintf(fid, '%f\n', l_eq_hrir_S.content_m(i,256));
        fprintf(fid, '\t\t\t},\n');
        fprintf(fid, '\t\t\t{\t// right\n\t\t\t\t\t');
        for sample = 1 : 255
            fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
        end
        fprintf(fid, '%f\n', r_eq_hrir_S.content_m(i,256));
        fprintf(fid, '\t\t\t}\n');
        fprintf(fid, '\t\t},\n');
        i = i + 1;
    end
    
    fprintf(fid, '\t\t{\t// azi %d\n', l_eq_hrir_S.azim_v(i));
    fprintf(fid, '\t\t\t{\t// left\n\t\t\t\t\t');
    for sample = 1 : 255
        fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f\n', l_eq_hrir_S.content_m(i,256));
    fprintf(fid, '\t\t\t},\n');
    fprintf(fid, '\t\t\t{\t// right\n\t\t\t\t\t');
    for sample = 1 : 255
        fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f\n', r_eq_hrir_S.content_m(i,256));
    fprintf(fid, '\t\t\t}\n');
    fprintf(fid, '\t\t}\n');
    fprintf(fid, '\t},\n');
    
    i = i+1;
    j = j+1;
end

ele = l_eq_hrir_S.elev_v(i);
fprintf(fid, '\t{\t// elev %d\n', ele);
for azi = 1 : numazis(j) - 1
    fprintf(fid, '\t\t{\t// azi %d\n', l_eq_hrir_S.azim_v(i));
    fprintf(fid, '\t\t\t{\t// left\n\t\t\t\t\t');
    for sample = 1 : 255
        fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f\n', l_eq_hrir_S.content_m(i,256));
    fprintf(fid, '\t\t\t},\n');
    fprintf(fid, '\t\t\t{\t// right\n\t\t\t\t\t');
    for sample = 1 : 255
        fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
    end
    fprintf(fid, '%f\n', r_eq_hrir_S.content_m(i,256));
    fprintf(fid, '\t\t\t}\n');
    fprintf(fid, '\t\t},\n');
    i = i + 1;
end

fprintf(fid, '\t\t{\t// azi %d\n', l_eq_hrir_S.azim_v(i));
fprintf(fid, '\t\t\t{\t// left\n\t\t\t\t\t');
for sample = 1 : 255
    fprintf(fid, '%f, ', l_eq_hrir_S.content_m(i,sample));
end
fprintf(fid, '%f\n', l_eq_hrir_S.content_m(i,256));
fprintf(fid, '\t\t\t},\n');
fprintf(fid, '\t\t\t{\t// right\n\t\t\t\t\t');
for sample = 1 : 255
    fprintf(fid, '%f, ', r_eq_hrir_S.content_m(i,sample));
end
fprintf(fid, '%f\n', r_eq_hrir_S.content_m(i,256));
fprintf(fid, '\t\t\t}\n');
fprintf(fid, '\t\t}\n');
fprintf(fid, '\t}\n');
fprintf(fid, '};\n');
fclose(fid);
