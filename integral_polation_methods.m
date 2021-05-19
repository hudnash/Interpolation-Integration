% Trapezoidal:
N=[10 40 80 160 320 1200];
vals = zeros(1,length(N));
for i=1:1:length(N)
    vals(i) = trap(@(x)sin(x),0,pi,N(i));
end
fprintf('trapezoidal\n');
fprintf('N          trap(sin(x),0,pi,N)');
fprintf('\n%f    %f\n',[N;vals]);

% Simpson's:
N=[10 40 80 160 320 1200];
vals = zeros(1,length(N));
for i=1:1:length(N)
    vals(i) = simpson(@(x)sin(x),0,pi,N(i));
end
fprintf('\n\nsimpsons\n');
fprintf('N          simpson(sin(x),0,pi,N)');
fprintf('\n%f    %f\n',[N;vals]);

% Romberg:
N=[10 40 80];
fprintf('\n\nromberg\n');
fprintf('N                                romberg(sin(x),0,pi,N)');
fprintf('\n%f,%f,%f    %f\n',N,romberg(@(x)sin(x),0,pi,N));
N=[40 80 160];
fprintf('\n%f,%f,%f    %f\n',N,romberg(@(x)sin(x),0,pi,N));

% Romberg versus Simpsons versus Trap:
N=[10 40 80; 40 80 160];
fprintf('\n\nromberg versus simpsons versus trap\n');
fprintf('N             romberg       simpson       trap       integral');
m = [sum(N(1,:)),sum(N(2,:)); 
     romberg(@(x)sin(x),0,pi,N(1,:)),romberg(@(x)sin(x),0,pi,N(2,:));
     simpson(@(x)sin(x),0,pi,sum(N(1,:))),simpson(@(x)sin(x),0,pi,sum(N(2,:)));
     trap(@(x)sin(x),0,pi,sum(N(1,:))),trap(@(x)sin(x),0,pi,sum(N(2,:)))
     integral(@(x)sin(x),0,pi), integral(@(x)sin(x),0,pi)];
fprintf('\n%f    %f    %f    %f      %f\n',m);
                              
%{
function printTable(headers,data)
% method code by Eitan T.
col_w = 11;  % # Fixed column width in characters
fr_n = 4;    % # Number of fraction digits
% # Print header
hdr_line = repmat(['+', char('-' * ones(1, col_w))], 1, size(X, 2));
hdr_fmt = ['|%', int2str(col_w - fr_n - 1)', '.0f', char(' ' * ones(1, fr_n + 1))];
fprintf('Iteration:\n%s\n', hdr_line)
fprintf(hdr_fmt, 0:size(X, 2) - 1)
fprintf('\n%s\n', hdr_line)
% # Print values
data_fmt = [repmat(['|%', int2str(col_w - 1), '.', int2str(fr_n), 'f '], 1, size(X, 2)), '\n'];
fprintf(data_fmt, X')
end
%}

function y = yAtx(X,Y,x)
i=1;
if x > X(end)
   while X(i) < x && i < length(X)
    i=i+1;
   end
elseif x < X(1)
    while X(i) > x && i < length(X)
        i=i+1;
    end
end
V = [1 X(i-2) X(i-2)^2; 1 X(i-1) X(i-1)^2; 1 X(i) X(i)^2];
F = [Y(i-2); Y(i-1); Y(i)];
A = V \ F;
y = [1 x x^2] * A;
y = sum(y(:,1));
end

function area = trap(func,a,b,N)
x = linspace(a,b,N);
dx=x(4)-x(3);
area=0.0;
for i=1:1:N-1
    area=area+dx/2.*(func(x(i))+func(x(i+1)));
end
end

function area = simpson(func,a,b,N)
% N must be an odd number! This is because we increment by 2 and must have
% 3 points in each iteration!
if mod(N,2) == 0
    N = N+1;
end
x = linspace(a,b,N);
dx = (b-a)/(N-1);
area = 0.;
for i=1:2:N-2
    area = area + dx/3*(func(x(i))+4.*func(x(i+1))+func(x(i+2)));
end
end

function area = romberg(func,a,b,N)
% N = [50 100 500] = ... some VECTOR OF ITERATION #'s.
n = length(N);
% x will be 1/N.
x = zeros(1,n); vals = zeros(1,n);
for i=1:1:n
    x(i) = 1./N(i);
    val(i) = trap(func,a,b,N(i));
end
area = yAtx(x,val,0.); % extrapolate to the point where 1/N = x = 0.
end