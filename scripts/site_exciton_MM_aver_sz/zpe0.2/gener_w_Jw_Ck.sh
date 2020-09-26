awk '{print $1, $2, $2}' w_k_out.dat > w_Jw_Ck_1
awk '{print $1, 0, 0}' w_k_out.dat >> w_Jw_Ck_1
awk '{print $1, 0, 0}' w_k_out.dat > w_Jw_Ck_2
awk '{print $1, $2, $2}' w_k_out.dat >> w_Jw_Ck_2

