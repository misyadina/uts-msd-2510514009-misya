% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 2 —  Enkripsi Citra Logo Toko dengan Invers Matriks 3x3
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

% 1. Parameter dan Matriks Kunci A
a = 0; b = 9; N = 9;
A = [a+1, b,   2;
     1,   a+2, b;
     b,   1,   a+3];

disp('Matriks Kunci A:')
disp(A)

% 2. Perhitungan Determinan & Invers (Fungsi MATLAB)
det_A = det(A);
A_inv = inv(A);

fprintf('det(A) = %.2f\n', det_A)
disp('Matriks Invers A^-1:')
disp(A_inv)

% 3. Matriks Kofaktor & Adjoin (Cepat)
% Adjoin = inv(A) * det(A)
Adj_A = A_inv * det_A; 
C = Adj_A'; % Kofaktor adalah transpose dari Adjoin

disp('Matriks Adjoin Adj(A):')
disp(Adj_A)

% 4. Proses Enkripsi & Dekripsi
% Blok piksel P
P = [120,    50+N, 200;
     80,     a+2,  10+N;
     30+N,   90,   170];

% Enkripsi E = A * P
E = A * P;

% Dekripsi P' = A^-1 * E
P_dekripsi = A_inv * E;

disp('Blok Piksel Asli P:')
disp(P)
disp('Hasil Enkripsi E:')
disp(E)
disp('Hasil Dekripsi P (Dibulatkan):')
disp(round(P_dekripsi))

% 5. Verifikasi
err = norm(round(P_dekripsi) - P, 'fro');
fprintf('Selisih (Error Frobenius) = %.2e\n', err)
if err < 1e-8
    disp('VERIFIKASI: Dekripsi berhasil, P'' sama dengan P.')
end

% 6. Visualisasi
figure
subplot(1,2,1)
imshow(uint8(P), 'InitialMagnification', 'fit')
title('Piksel Asli P')

subplot(1,2,2)
% Gunakan mod 256 hanya untuk visualisasi agar masuk range warna 0-255
imshow(uint8(mod(E, 256)), 'InitialMagnification', 'fit')
title('Terenkripsi E (mod 256)')

sgtitle('Sistem Enkripsi Citra 3x3')
saveas(gcf, 'enkripsi_logo.png')