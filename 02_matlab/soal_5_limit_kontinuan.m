% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 5 — Konvergensi Customer Lifetime Value dan Kekontinuan Biaya
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

% 1. Definisikan variabel simbolik untuk perhitungan limit
syms x K a b positive 

% 2. Masukkan nilai parameter sesuai permintaan
K_val = 10; 
a_val = 0;
b_val = 9;

% 3. Hitung Limit secara simbolik sesuai rumus di soal
L1_sym = limit((x^2 - K^2)/(x - K), x, K);
L2_sym = limit((sqrt(x + (K+1)^2) - (K+1))/x, x, 0);
L3_sym = limit(((a+2)*x^3 + b*x + 7)/(x^3 - x + K), x, inf);

% 4. Substitusi (Ganti huruf jadi angka)
% Mengganti K, a, dan b dengan nilai yang sudah ditentukan
L1_num = double(subs(L1_sym, K, K_val));
L2_num = double(subs(L2_sym, K, K_val));
L3_num = double(subs(L3_sym, {a, b, K}, {a_val, b_val, K_val}));

% 5. Hitung p dan q untuk kekontinuan (Soal 5.4)
p = 2 * K_val;
q = p - a_val * K_val;

% output
fprintf('Hasil L1 : %.2f\n', L1_num);
fprintf('Hasil L2 : %.4f\n', L2_num);
fprintf('Hasil L3 : %.2f\n', L3_num);
fprintf('Nilai p  : %d\n', p);
fprintf('Nilai q  : %d\n', q);

% figure
f1 = @(x) (x.^2 - K_val^2)./(x - K_val);
f2 = @(x) a_val*x + q;

figure(5);
fplot(f1, [0, K_val], 'b', 'LineWidth', 2); hold on;
fplot(f2, [K_val, 2*K_val], 'r', 'LineWidth', 2);
line([K_val K_val], [0, p+5], 'Color', 'k', 'LineStyle', '--');
grid on; 
title('Visualisasi Fungsi Biaya Kontinu C(x)');
legend('Bagian Kiri (x < K)', 'Bagian Kanan (x > K)');