% Código extraido de: https://www.youtube.com/watch?v=S8xeaVSde5c
clearvars;  clc;

% PROBLEMA MAXENTE 
E = 4;   % resultado esperado de una tirada de dado (1,000011 < E < 5,999999)
epsilon = 1:20;  % todos los resultados posibles de una tirada de dado

% BÚSQUEDA DE RAÍCES
myfun = @(x) maxentroot(x, E, epsilon);
x0 = rand(1);
options = optimset( 'Display', 'notify', ...
                    'MaxFunEvals', 5000, ...
                    'Tolfun', 1e-20, ...
                    'TolX',1e-10);
[x, fx, xfl] = fzero(myfun, x0, options); % x = exp(alpha)
if xfl < 0, error("Did not converge!");
elseif x < 0, warning("Invalid solution!"); end

% PRIMALES, VARIABLES DOBLES
p = (x.^epsilon)./(sum(x.^epsilon));
alpha = log(x); lambda = 1 - log(sum(x.^epsilon));

% SOLUCIÓN DE IMPRESIÓN
% Asegúrese de que la solución sea válida 
fprintf("--------------------------- OUTPUT ---------------------------\n");
fprintf("> Verificar if E == SUM:\n");             % E == SUM
fprintf(">    E = %5.4f,   SUM = %5.4f\n", E, sum(p.*epsilon)); 
fprintf("> raíz y valor de la función en la raíz:\n");
fprintf(">    x = %10.6f, f(x) = %10.8f\n", x, fx);
fprintf("> Variables duales (multiplicadores de Lagrange):\n"); % lambda, alpha
fprintf(">    lambda = %10.7f,    alpha = %10.7f\n", lambda, alpha); 
fprintf("> Variable primaria (probabilidades):\n");
% Print probabilities in vector p 
fprintf(">    p = [ "); 
for i = 1:numel(p)
    fprintf("%6.5f ",p(i)); 
end
fprintf("]\n");
fprintf("--------------------------------------------------------------\n");

% FUNCIÓN UTILIZADA EN LA BÚSQUEDA DE RAÍCES
function y = maxentroot(x, E, epsilon)
x(x < 1e-5) = 1e-5;
y = sum((E - epsilon).*(x.^epsilon));
end

