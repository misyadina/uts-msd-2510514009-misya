% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 4 — Segmentasi Pelanggan dan komposisi fungsi harga
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

% definisi bilangan kompleks
z1 = (a+2) + (b+1)*1i;   % 2 + 10i
z2 = (b+1) - (a+2)*1i;   % 10 - 2i

fprintf('z1 = %.0f + %.0fi\n', real(z1), imag(z1))
fprintf('z2 = %.0f + (%.0f)i\n', real(z2), imag(z2))

%% bagian a - bentuk kutub r*cis(theta)
r1 = abs(z1);
r2 = abs(z2);
theta1_rad = angle(z1);
theta2_rad = angle(z2);
theta1_deg = rad2deg(theta1_rad);
theta2_deg = rad2deg(theta2_rad);

fprintf('\n=== Bentuk Kutub ===\n')
fprintf('z1: r = %.4f, theta = %.4f rad = %.4f deg\n', r1, theta1_rad, theta1_deg)
fprintf('z2: r = %.4f, theta = %.4f rad = %.4f deg\n', r2, theta2_rad, theta2_deg)

%% bagian b - operasi aritmatika
z_tambah = z1 + z2;
z_kali   = z1 * z2;
z_bagi   = z1 / z2;     % matlab otomatis rasionalisasi
z_selisih_abs = abs(z1 - z2);

fprintf('\n=== Operasi Aritmatika ===\n')
fprintf('z1 + z2 = %.4f + %.4fi\n', real(z_tambah), imag(z_tambah))
fprintf('z1 * z2 = %.4f + %.4fi\n', real(z_kali), imag(z_kali))
fprintf('z1 / z2 = %.4f + %.4fi\n', real(z_bagi), imag(z_bagi))
fprintf('|z1 - z2| = %.4f\n', z_selisih_abs)

%% bagian c - De Moivre: (z1)^4
% manual pakai bentuk kutub: r1^4 * cis(4*theta1)
r1_4       = r1^4;
theta1_4   = 4 * theta1_rad;
z1_4_manual = r1_4 * (cos(theta1_4) + 1i*sin(theta1_4));

% langsung
z1_4_langsung = z1 * z1 * z1 * z1;

fprintf('\n=== De Moivre (z1)^4 ===\n')
fprintf('Bentuk Kutub  : %.4f + %.4fi\n', real(z1_4_manual), imag(z1_4_manual))
fprintf('Bentuk Aljabar: %.4f + %.4fi\n', real(z1_4_langsung), imag(z1_4_langsung))
fprintf('Selisih       : %.2e (harus nol)\n', abs(z1_4_manual - z1_4_langsung))

%% bagian d - akar kubik dari w = 8*cis(theta0)
theta0_deg = 45;                   % Parameter theta0 kamu
r_w = 8;

fprintf('\n=== Akar Kubik w = 8*cis(%.0f deg) ===\n', theta0_deg)

% Inisialisasi array untuk menyimpan akar (bilangan kompleks)
akar = zeros(1,3);

for k = 0:2
    % Menghitung modulus akar (akar pangkat tiga dari 8 adalah 2)
    r_akar = r_w^(1/3);
    
    % Menghitung argumen (sudut) dalam derajat
    % Rumus: (theta0 + k*360) / 3
    theta_akar_deg = (theta0_deg + k*360) / 3;
    
    % Menghitung nilai kompleks menggunakan cosd dan sind (input derajat)
    akar(k+1) = r_akar * (cosd(theta_akar_deg) + 1i*sind(theta_akar_deg));
    
    % Menampilkan hasil
    fprintf('w%d = %.4f + %.4fi  |  %.0f * cis(%.1f deg)\n', ...
        k, real(akar(k+1)), imag(akar(k+1)), r_akar, theta_akar_deg)
end

%% bagian e - plot akar kubik di bidang Argand
figure
r_lingkaran = 2^(1/3) * 8^(1/3);   % = 2*8^(1/3) tapi soal bilang 2*8^0.5... 
% soal: jari-jari = 2*sqrt(8) = 2^(1/3)*... 
% pakai abs akar saja
r_plot = abs(akar(1));

theta_plot = linspace(0, 2*pi, 300);
plot(r_plot*cos(theta_plot), r_plot*sin(theta_plot), 'b--', 'LineWidth', 1)
hold on

% plot ketiga akar
warna = ['ro', 'gs', 'b^'];
label_akar = {'w_0','w_1','w_2'};
for k = 1:3
    plot(real(akar(k)), imag(akar(k)), warna(k*2-1:k*2), 'MarkerSize', 10, 'LineWidth', 2)
end

% hubungkan jadi segitiga
segitiga = [akar, akar(1)];
plot(real(segitiga), imag(segitiga), 'k-', 'LineWidth', 1.2)

legend('Lingkaran', 'w_0', 'w_1', 'w_2', 'Segitiga')
xlabel('Real')
ylabel('Imajiner')
title('Akar Kubik di Bidang Argand')
grid on
axis equal
hold off

saveas(gcf, 'argand_akar_kubik.png')

% verifikasi jarak antar akar (harus sama = segitiga sama sisi)
d01 = abs(akar(1) - akar(2));
d12 = abs(akar(2) - akar(3));
d02 = abs(akar(1) - akar(3));
fprintf('\nJarak antar akar:\n')
fprintf('|w0-w1| = %.4f\n', d01)
fprintf('|w1-w2| = %.4f\n', d12)
fprintf('|w0-w2| = %.4f\n', d02)
if abs(d01-d12) < 1e-10 && abs(d12-d02) < 1e-10
    disp('Terbukti segitiga sama sisi!')
end