% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 6 — Optimasi Harga Produk Via Gradient Descent Manual
% ---------------------------------------------------
% Nama : Misya Adina
% NIM : 2510514009
% Parameter: N=9, a=0, b=9, K=10, theta0=45, alpha=0.01
% Tanggal: 2026-04-25
% =====================================================

clc; clear; close all;

% Parameter personalisasi
N = 9; a = 0; b = 9; K = 10;
theta0 = 45; % derajat
alpha_lr = 0.01;

%% 6(e)
% Parameter
a = 0; b = 9; K = 10; x0 = 1; 
alpha = 0.01; 
n_iter = 500;

% Fungsi Profit dan Turunannya
pi_f = @(x) -(a+1)*x.^3 + (b+5)*K*x.^2 + 100*x - (K^2 * 10);
pi_p = @(x) -3*(a+1)*x.^2 + 2*(b+5)*K*x + 100;

% Iterasi
x_curr = x0;
pi_history = zeros(n_iter, 1);

for k = 1:n_iter
    pi_history(k) = pi_f(x_curr);
    x_curr = x_curr + alpha * pi_p(x_curr);
end

% Output Angka
fprintf('--- HASIL 6.2 (e) ---\n');
fprintf('Titik Optimal x*: %.4f\n', x_curr);
fprintf('Profit Maksimum : %.2f\n', pi_f(x_curr));

% Plotting Figure e
figure('Name', '6.2e Konvergensi Profit');
plot(pi_history, 'LineWidth', 2, 'Color', [0 0.4470 0.7410]);
title('Grafik Konvergensi Profit \pi(x) - Soal 6.2(e)');
xlabel('Iterasi ke-k');
ylabel('Nilai Profit');
grid on;


%% 6(f)
% Definisikan 3 variasi Alpha
alpha_nom = 0.01;
alpha_big = 0.1;
alpha_sml = 0.001;

% Fungsi
pi_f = @(x) -(a+1)*x.^3 + (b+5)*K*x.^2 + 100*x - (K^2 * 10);
pi_p = @(x) -3*(a+1)*x.^2 + 2*(b+5)*K*x + 100;

% Inisialisasi wadah hasil
h_nom = zeros(n_iter, 1); h_big = zeros(n_iter, 1); h_sml = zeros(n_iter, 1);

% Jalankan 3 simulasi
x_n = x0; x_b = x0; x_s = x0;
for k = 1:n_iter
    h_nom(k) = pi_f(x_n); x_n = x_n + alpha_nom * pi_p(x_n);
    h_big(k) = pi_f(x_b); x_b = x_b + alpha_big * pi_p(x_b);
    h_sml(k) = pi_f(x_s); x_s = x_s + alpha_sml * pi_p(x_s);
end

% Plotting Figure f
figure('Name', '6.2f Perbandingan Alpha');
plot(h_nom, 'b', 'LineWidth', 1.5); hold on;
plot(h_big, 'r--', 'LineWidth', 1.5);
plot(h_sml, 'g-.', 'LineWidth', 1.5);

title('Analisis Sensitivitas Learning Rate - Soal 6.2(f)');
legend('\alpha = 0.01 (Normal)', '\alpha = 0.1 (Terlalu Besar)', '\alpha = 0.001 (Terlalu Kecil)');
xlabel('Iterasi');
ylabel('Profit');
grid on;

fprintf('--- HASIL 6.2 (f) ---\n');
fprintf('Grafik perbandingan alpha telah dibuat.\n');