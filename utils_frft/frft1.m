function Faf = frft1(f, a)
% The fast Fractional Fourier Transform
% input: f = samples of the signal
%        a = fractional power
% output: Faf = fast Fractional Fourier transform

% H.M. Ozaktas, M.A. Kutay, and G. Bozdagi.
% [i]Digital computation of the fractional Fourier transform.[/i]
% IEEE Trans. Sig. Proc., 44:2141--2150, 1996.

error(nargchk(2, 2, nargin));
f = f(:);
N = length(f);
shft = rem((0:N-1)+fix(N/2),N)+1;
sN = sqrt(N);
a = mod(a,4);
% do special cases
if (a==0), Faf = f; return; end;
if (a==2), Faf = flipud(f); return; end;
if (a==1), Faf(shft,1) = fft(f(shft))/sN; return; end 
if (a==3), Faf(shft,1) = ifft(f(shft))*sN; return; end
% reduce to interval 0.5 < a < 1.5
if (a>2.0), a = a-2; f = flipud(f); end
if (a>1.5), a = a-1; f(shft,1) = fft(f(shft))/sN; end
if (a<0.5), a = a+1; f(shft,1) = ifft(f(shft))*sN; end
% the general case for 0.5 < a < 1.5
alpha = a*pi/2;
tana2 = tan(alpha/2);
sina = sin(alpha);
f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)];
% chirp premultiplication
chrp = exp(-i*pi/N*tana2/4*(-2*N+2:2*N-2)'.^2);
f = chrp.*f;
% chirp convolution
c = pi/N/sina/4;
Faf = fconv(exp(i*c*(-(4*N-4):4*N-4)'.^2),f);
Faf = Faf(4*N-3:8*N-7)*sqrt(c/pi);
% chirp post multiplication
Faf = chrp.*Faf;
% normalizing constant
Faf = exp(-i*(1-a)*pi/4)*Faf(N:2:end-N+1);


% function Faf = frft1(f, a)
%     % Fast Fractional Fourier Transform
%     N = length(f);
%     shft = rem((0:N-1)+fix(N/2),N)+1;
%     sN = sqrt(N);
%     a = mod(a,4);
%     if a == 0
%         Faf = f;
%         return;
%     elseif a == 2
%         Faf = flipud(f);
%         return;
%     elseif a == 1
%         Faf(shft,1) = fft(f(shft))/sN;
%         return;
%     elseif a == 3
%         Faf(shft,1) = ifft(f(shft))*sN;
%         return;
%     end
% 
%     if a > 2.0
%         a = a-2; f = flipud(f);
%     end
%     if a > 1.5
%         a = a-1; f(shft,1) = fft(f(shft))/sN;
%     end
%     if a < 0.5
%         a = a+1; f(shft,1) = ifft(f(shft))*sN;
%     end
% 
%     alpha = a*pi/2;
%     tana2 = tan(alpha/2);
%     sina = sin(alpha);
%     f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)];
% 
%     chrp = exp(-1i*pi/N*tana2/4*(-2*N+2:2*N-2)'.^2);
%     f = chrp.*f;
% 
%     c = pi/N/sina/4;
%     Faf = fconv(exp(1i*c*(-(4*N-4):4*N-4)'.^2),f);
%     Faf = Faf(4*N-3:8*N-7)*sqrt(c/pi);
% 
%     Faf = chrp.*Faf;
%     Faf = exp(-1i*(1-a)*pi/4)*Faf(N:2:end-N+1);
% end




% function Faf = frft1(f, a)
%     % The fast Fractional Fourier Transform
%     % input: f = samples of the signal
%     %        a = fractional power
%     % output: Faf = fast Fractional Fourier transform
% 
%     f = f(:);  % Column vector
%     N = length(f);
%     a = mod(a, 4);
% 
%     % Handle special cases
%     if a == 0
%         Faf = f;
%         return;
%     elseif a == 2
%         Faf = flipud(f);
%         return;
%     elseif a == 1
%         Faf = fft(f);
%         return;
%     elseif a == 3
%         Faf = ifft(f);
%         return;
%     end
% 
%     % General case for 0.5 < a < 1.5
%     alpha = a * pi / 2;
%     tana2 = tan(alpha / 2);
%     sina = sin(alpha);
% 
%     % Chirp premultiplication
%     x = (0:N-1)' - (N-1)/2;
%     chrp = exp(-1i * pi / N * tana2 * x.^2);
%     f = chrp .* f;
% 
%     % Chirp convolution
%     c = pi / N / sina;
%     Faf = ifft(fft(f) .* fft(exp(1i * c * x.^2)));
% 
%     % Normalize
%     Faf = Faf * sqrt(c / pi);
% 
%     % Chirp postmultiplication
%     Faf = chrp .* Faf;
%     Faf = exp(-1i * (1-a) * pi / 4) * Faf;
% end