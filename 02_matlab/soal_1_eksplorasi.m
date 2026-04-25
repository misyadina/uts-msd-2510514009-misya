% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 1 — Eksplorasi Awal dan Profil Data Transaksi
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

% data toko
K = 10; a = 0; b = 9;

D = zeros(1,7);
for i = 1:7
    D(i) = 20 + (K*i) + mod(a*i, 7) - mod(b*i, 5);
end

disp('Data D:')
disp(D)

% rata-ratag
n = length(D);
total = 0;
for i = 1:n
    total = total + D(i);
end
rata2 = total / n;

% median
Ds = sort(D);
if mod(n,2) ~= 0
    med = Ds((n+1)/2);
else
    med = (Ds(n/2) + Ds(n/2+1)) / 2;
end

% standar deviasi populasi
jumlah_kuadrat = 0;
for i = 1:n
    jumlah_kuadrat = jumlah_kuadrat + (D(i) - rata2)^2;
end
std_pop = sqrt(jumlah_kuadrat / n);

range_val = max(D) - min(D);

fprintf('Mean = %.2f\n', rata2)
fprintf('Median = %.2f\n', med)
fprintf('Modus = tidak ada (semua nilai berbeda)\n')
fprintf('Range = %.2f\n', range_val)
fprintf('Std Dev (populasi) = %.4f\n', std_pop)

% verifikasi pakai fungsi matlab
fprintf('\nVerifikasi:\n')
fprintf('mean = %.2f\n', mean(D))
fprintf('median = %.2f\n', median(D))
fprintf('mode = %d\n', mode(D))
fprintf('range = %.2f\n', range(D))
fprintf('std(D,1) = %.4f\n', std(D,1))

% grafik
figure
bar(D)
hold on
yline(rata2, 'r--', 'LineWidth', 1.5)
xlabel('Toko')
ylabel('Penjualan (juta rupiah)')
title('Penjualan Per Toko - NIM 9')
xticks(1:7)
xticklabels({'Toko1','Toko2','Toko3','Toko4','Toko5','Toko6','Toko7'})
legend('Penjualan','Rata-rata')
grid on
hold off

saveas(gcf, 'grafik_penjualan.png')