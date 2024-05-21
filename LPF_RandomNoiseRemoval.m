%% 
clearvars
clc
close all

[InAud,Fs] = audioread('InputAudio.wav');

L = length(InAud);          %length of the input sequence
T = 1/Fs;
t = (0:L-1)*T;   %time in seconds
A1 = 0.02;       %Amplitude of Random noise
A2 = 0.05;

Tr_InAud = transpose(InAud);
%Noisy audio is created by adding random noise to the main input audio
NoisyAud_1 = Tr_InAud + A1*randn(1,length(Tr_InAud));
NoisyAud_2 = Tr_InAud + A2*randn(1,length(Tr_InAud));

audiowrite("NoisyAudio_1.wav",NoisyAud_1,Fs);
audiowrite("NoisyAudio_2.wav",NoisyAud_2,Fs);


% Coefficients of the designed filter are loaded 
load("Num.mat");
%Num = Num;

%Noisy audio is filtered
FilteredAud_1 = filter(Num,1,NoisyAud_1);
FilteredAud_2 = filter(Num,1,NoisyAud_2);

audiowrite("OutputAudio_1.wav",FilteredAud_1,Fs);
audiowrite("OutputAudio_2.wav",FilteredAud_2,Fs);

Order = filtord(Num);      %order of the filter
 
%% 
%Figures

%Time domain plots
%figure 1
figure
subplot(3,2,1)
plot(t, InAud);
title('Input signal: Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');
grid on
subplot(3,2,3)
plot(t, NoisyAud_1, 'r');
title('Noisy signal (A=0.02): Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');
grid on
subplot(3,2,5)
plot(t, FilteredAud_1, 'g');
title("Output signal: Time-domain");
xlabel('time(seconds)');
ylabel('Amplitude');
grid on

subplot(3,2,2)
plot(t, InAud);
title('Input signal: Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');
grid on
subplot(3,2,4)
plot(t, NoisyAud_2, 'r');
title('Noisy signal (A=0.05): Time-domain');
xlabel('time(seconds)');
ylabel('Amplitude');
grid on
subplot(3,2,6)
plot(t, FilteredAud_2, 'g');
title("Output signal: Time-domain");
xlabel('time(seconds)');
ylabel('Amplitude');
grid on
%% 

%Magnitude spectrum plots
%figure 2

figure
Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,1)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
plot(f,mag);
title('Magnitude spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(NoisyAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,3)
FFT_NoisyAud_1 = fft(NoisyAud_1); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_1(1:Length_audio/2+1));
plot(f,mag, 'r');
title('Magnitude spectrum of Noisy Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(FilteredAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,5)
FFT_FilteredAud_1 = fft(FilteredAud_1); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_1(1:Length_audio/2+1));
plot(f,mag, 'g');
title('Magnitude spectrum of Output Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,2)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
plot(f,mag);
title('Magnitude spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(NoisyAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,4)
FFT_NoisyAud_2 = fft(NoisyAud_2); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_2(1:Length_audio/2+1));
plot(f,mag, 'r');
title('Magnitude spectrum of Noisy Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(FilteredAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,6)
FFT_FilteredAud_2 = fft(FilteredAud_2); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_2(1:Length_audio/2+1));
plot(f,mag, 'g');
title('Magnitude spectrum of Output Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

%% Log scale Magnitude Spectrum plots
%figure 3
figure
Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,1)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag);
title('Log Scale Magnitude spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude (dB)');
grid on

Length_audio = length(NoisyAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,3)
FFT_NoisyAud_1 = fft(NoisyAud_1); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_1(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag, 'r');
title('Log Scale Magnitude spectrum of Noisy Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude(dB)');
grid on

Length_audio = length(FilteredAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,5)
FFT_FilteredAud_1 = fft(FilteredAud_1); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_1(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag, 'g');
title('Log Scale Magnitude spectrum of Output Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude (dB)');
grid on

Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,2)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag);
title('Log Scale Magnitude spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude (dB)');
grid on

Length_audio = length(NoisyAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,4)
FFT_NoisyAud_2 = fft(NoisyAud_2); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_2(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag, 'r');
title('Log Scale Magnitude spectrum of Noisy Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude (dB)');
grid on

Length_audio = length(FilteredAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,6)
FFT_FilteredAud_2 = fft(FilteredAud_2); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_2(1:Length_audio/2+1));
logMag = 20*log10(mag);
plot(f,logMag, 'g');
title('Log Scale Magnitude spectrum of Output Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude (dB)');
grid on

%% Power Spectrum Plots
figure
Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,1)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
power = mag.^2;
plot(f,power);
title('Power spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(NoisyAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,3)
FFT_NoisyAud_1 = fft(NoisyAud_1); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_1(1:Length_audio/2+1));
power = mag.^2;
plot(f,power, 'r');
title('Power spectrum of Noisy Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(FilteredAud_1);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,5)
FFT_FilteredAud_1 = fft(FilteredAud_1); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_1(1:Length_audio/2+1));
power = mag.^2;
plot(f,power, 'g');
title('Power spectrum of Output Audio 1');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(InAud);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,2)
FFT_InAud = fft(InAud); %calculating fft of Input audio
mag = abs(FFT_InAud(1:Length_audio/2+1));
power = mag.^2;
plot(f,power);
title('Power spectrum of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Magnitude');

Length_audio = length(NoisyAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,4)
FFT_NoisyAud_2 = fft(NoisyAud_2); %calculating fft of Noisy audio
mag = abs(FFT_NoisyAud_2(1:Length_audio/2+1));
plot(f,mag);
power = mag.^2;
plot(f,power, 'r');
title('Power spectrum of Noisy Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

Length_audio = length(FilteredAud_2);
f = linspace(0,Fs/2,Length_audio/2+1); %Frequency Spectrum: 0 to fs/2
subplot(3,2,6)
FFT_FilteredAud_2 = fft(FilteredAud_2); %calculating fft of Input audio
mag = abs(FFT_FilteredAud_2(1:Length_audio/2+1));
power = mag.^2;
plot(f,power, 'g');
title('Power spectrum of Output Audio 2');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on


%% 
figure
zplane(Num,1);
title('Pole-zero Plot');

figure
freqz(Num,1,L);
title('Frequency Response');

figure
impz(Num,1);
title('Impulse Response');

%% 
%Playing Audio
sound(InAud,Fs)
pause

sound(NoisyAud_1,Fs)
pause

sound(FilteredAud_1,Fs) 
pause

sound(NoisyAud_2,Fs)
pause

sound(FilteredAud_2,Fs)
