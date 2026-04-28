%% SOAL 7: VERIFIKASI SIGMA & FORECASTING
clear; clc;

% Parameter
a = 0; b = 9; K = 10;
n = 1:12;

% Model Penjualan
Sn = 50 + (K*n) + (-1).^n * (a+1);

% 7.2 Operasi Sigma
T1 = sum(Sn);
T2 = sum(Sn.^2);
fprintf('T1 (Sum Sn): %.2f\n', T1);
fprintf('T2 (Sum Sn^2): %.2f\n', T2);

% 7.4 Forecasting
p_coeff = polyfit(n, Sn, 1);
slope = p_coeff(1);
intercept = p_coeff(2);
fprintf('Slope: %.4f, Intercept: %.4f\n', slope, intercept);

% Prediksi 1-18
n_pred = 1:18;
S_fit = polyval(p_coeff, n_pred);
MAE = mean(abs(Sn - polyval(p_coeff, n)));
fprintf('MAE: %.4f\n', MAE);

figure(7);
plot(n, Sn, 'bo', 'MarkerFaceColor', 'b'); hold on;
plot(n_pred, S_fit, 'r--', 'LineWidth', 1.5);
plot(13:18, S_fit(13:18), 'g^', 'MarkerFaceColor', 'g');
grid on; title('Soal 7.4: Penjualan & Forecast');
legend('Data Historis', 'Garis Tren', 'Prediksi 6 Bulan');