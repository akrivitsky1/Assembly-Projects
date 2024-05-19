states =              {q0,q1,q2,q3,q4,q5,qr}
input_alphabet =      {0,1}
tape_alphabet_extra = {X,Y,_}
start_state =         q0
accept_state =        q5
reject_state =        qr
num_tapes =           1
delta =
    q0, 0 -> q2, X, R;
    q0, 1 -> q1, X, R;
    q0, Y -> q0, Y, R;
    q0, _ -> q5, _, R;
    q1, 1 -> q1, 1, R;
    q1, Y -> q1, Y, R;
    q1, 0 -> q3, Y, L;
    q2, Y -> q2, Y, R;
    q2, 0 -> q2, 0, R;
    q2, 1 -> q4, Y, L;
    q3, Y -> q3, Y, L;
    q3, 0 -> q3, 0, L;
    q3, 1 -> q3, 1, L;
    q3, X -> q0, X, R;
    q4, Y -> q4, Y, L;
    q4, 0 -> q4, 0, L;
    q4, 1 -> q4, 1, L;
    q4, X -> q0, X, R;
    
