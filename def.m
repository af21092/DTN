
%変数の定義を行う
syms i;
%バンドル集約について
%独立変数
k= 24;
L_bundle = 40*10^3;
l = 152;
L_datalink_header = 10;
%従属変数
L_block = k*L_bundle;
N_seg = L_block/l;
N = ceil(N_seg);%T_LRの計算のため
L_seg = l + L_datalink_header;


%ビットエラー率
P_e = 10^-4; %ex1での独立変数
P_seg = 1-(1-P_e)^(8*L_seg);

%送信時間
tei = log(N_seg)/log(P_seg);
m = ceil(-tei);
T_break = 0;
T_p = 600;%秒
R_data = 1*10^6;%bps
R_RS = R_data*(1/100);
L_RS = 70;
S_m = N_seg*(P_seg)^(m-1);
T_LR = S_m*(1/N_seg)*symsum(i*l/R_data,i,0,N)+T_p;
if m>1
T_m = symsum(N_seg*(P_seg)^(i-1),i,1,m-1)*(l/R_data)+(m-1)*(L_RS/R_RS+2*T_p);
end
T_ser = T_m + T_LR + T_break;

%平均キュー
r=0.002; %到着率
E = (r/k)*T_ser+((r^2)/k)*T_ser^2/2*(1-(r/k)*T_ser);

