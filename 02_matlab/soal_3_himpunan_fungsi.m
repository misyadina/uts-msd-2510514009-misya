% =====================================================
% UTS Matematika Sains Data — Semester Genap 2025/2026
% Soal 3 — Segmentasi Pelanggan dan komposisi fungsi harga 
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
% parameter
K = 10; a = 0; b = 9; N = 9;

% definisi himpunan
U = N : N+20;   % universe, 21 elemen

A = [N, N+2, N+4, N+7, N+10, N+13, N+15];
B = [N+3, N+5, N+7, N+10, N+12, N+18];
C = [N+1, N+7, N+10, N+11, N+17, N+20];

fprintf('U = '); disp(U)
fprintf('A = '); disp(A)
fprintf('B = '); disp(B)
fprintf('C = '); disp(C)

%% bagian b - operasi himpunan

AuBuC      = union(union(A, B), C);
AiBiC      = intersect(intersect(A, B), C);
AuB        = union(A, B);
AuB_irC    = setdiff(AuB, C);          % (A u B) n C'
AbsSymDiff = setdiff(AuB, intersect(A,B));  % A xor B = (AuB) - (AnB)

fprintf('\n|A u B u C| = %d\n', numel(AuBuC))
fprintf('A u B u C = '); disp(AuBuC)

fprintf('|A n B n C| = %d\n', numel(AiBiC))
fprintf('A n B n C = '); disp(AiBiC)

fprintf('|(A u B) n C''| = %d\n', numel(AuB_irC))
fprintf('(A u B) n C'' = '); disp(AuB_irC)

fprintf('|A xor B| = %d\n', numel(AbsSymDiff))
fprintf('A xor B = '); disp(AbsSymDiff)

%% bagian c - komposisi fungsi
% f(x) = K*x + (a+b) = 10x + 9
% g(x) = x^2/(b+1) + a = x^2/10

syms x

f = K*x + (a + b);       % 10x + 9
g = x^2 / (b+1) + a;     % x^2/10

fog = simplify(subs(f, x, g));   % f(g(x))
gof = simplify(subs(g, x, f));   % g(f(x))

fprintf('\nf(x) = '); disp(f)
fprintf('g(x) = '); disp(g)
fprintf('(f o g)(x) = '); disp(fog)
fprintf('(g o f)(x) = '); disp(gof)

% cek komutatif di x = b+2 = 11
x_val = b + 2;
fog_val = double(subs(fog, x, x_val));
gof_val = double(subs(gof, x, x_val));
fprintf('\nPada x = %d:\n', x_val)
fprintf('(f o g)(%d) = %.4f\n', x_val, fog_val)
fprintf('(g o f)(%d) = %.4f\n', x_val, gof_val)

if abs(fog_val - gof_val) < 1e-10
    disp('Komposisi KOMUTATIF pada x ini')
else
    disp('Komposisi TIDAK komutatif (f o g =/= g o f)')
end

%% bagian d - invers f
% f(x) = 10x + 9
% pendapatan = K*100 + a + b = 1009
pendapatan = K*100 + a + b;
fprintf('\nPendapatan target = Rp %d ribu\n', pendapatan)

% invers manual: y = 10x+9 => x = (y-9)/10
f_inv = (x - (a+b)) / K;
fprintf('f^-1(x) = '); disp(f_inv)

x_hasil = double(subs(f_inv, x, pendapatan));
fprintf('Volume pembelian x = %.2f\n', x_hasil)

% verifikasi dengan solve
sol = solve(f == pendapatan, x);
fprintf('Verifikasi solve: x = %s\n', char(sol))

% verifikasi dengan subs
cek = double(subs(f, x, sol));
fprintf('Substitusi balik f(%.2f) = %.2f\n', double(sol), cek)

%% bagian e - klasifikasi f dan g
fprintf('\n=== Klasifikasi Fungsi ===\n')
fprintf('f(x) = 10x + 9\n')
fprintf('- Injektif : Ya, fungsi linear dengan gradien != 0\n')
fprintf('- Surjektif: Ya, kodomain R tercakup semua\n')
fprintf('- Bijektif : Ya (injektif + surjektif)\n')

fprintf('\ng(x) = x^2/10\n')
fprintf('- Injektif : Tidak, g(-x) = g(x) untuk x != 0\n')
fprintf('- Surjektif: Tidak, g(x) >= 0 sehingga nilai negatif tidak tercakup\n')
fprintf('- Bijektif : Tidak\n')