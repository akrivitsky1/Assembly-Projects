states = {q0, qLoadX, qLoadY, qMoveX, qMoveY,qMoveZ, qMultiply, qAddX, qShiftY,qShiftX, qHalt, qR, qAdd,qLoadZ,qskip,qmodZ2,qloadz2,qanswer,copymoveY,copyloadY,qanswer2,qMoveA,movetapesfront,ztolast} 
input_alphabet = {0, 1, :, ^, L, M, x, y,A} 
tape_alphabet_extra = {#, _} 
start_state = q0
accept_state = qHalt
reject_state = qR
num_tapes = 5
delta = 
 // Initial setup loading into Z
 q0, ^____ -> q0, ^____, RSSSS ;
 q0, L____ -> qLoadZ, L#___, RRSSS ;
 qLoadZ, 1???? -> qLoadZ, 11???, RRSSS ;
 qLoadZ, 0???? -> qLoadZ, 00???, RRSSS;
 qLoadZ, :???? -> qLoadZ, :????, RLSSS;
  
  //movingn z bakc
  qLoadZ, L???? -> qmodZ2, L????, RLSSS;
  //move 2nd tape back to start
 qmodZ2, ?0??? -> qmodZ2, ?0???, SLSSS;
 qmodZ2, ?1??? -> qmodZ2, ?1???, SLSSS;
  //replace L in Z
 qmodZ2, ?#??? -> qloadz2, ?#???, SRSSS;
 qloadz2, 1???? -> qloadz2, 11???, RRSSS;
  qloadz2, 0???? -> qloadz2, 00???, RRSSS;
 qloadz2, :___? -> qLoadZ, :___?, SRSSS;
 
//go back to beggining to accept
qLoadZ, ____? -> qanswer, _____, SSSSS;
qanswer, _____ -> qanswer, _____, SLLLS;
  //move all tapes back
 qanswer, _0??? -> qanswer, _0???, SLLLS;
  qanswer, _1??? -> qanswer, _1???, SLLLS;
  qanswer, _#??? -> copymoveY, _#???, SRRRR;

 // Loading into x or y
 qLoadZ, M???? -> qMoveZ, M????, RSSSS;
 qMoveZ, x???? -> qMoveX, x?#??, RLRSS;
 qMoveZ, y???? -> qMoveY, y??#?, RLSRS;
 qLoadZ, A???? -> qAdd, A???#, RLLLR;
 
 qAdd, ??00_ -> qAdd, ?000_, SLLLS;
 
 qAdd, ??10_ -> qAdd, ?110_, SLLLR;
  qAdd, ??01_ -> qAdd, ?101_, SLLLR;
  qAdd, ??11_ -> qAdd, ?0111, SLLLS;
  qAdd, ??011 -> qAdd, ?0011, SLLLS;
  qAdd, ??111 -> qAdd, ?1111, SLLLS;
  qAdd, ??001 -> qAdd, ?1001, SLLLR;
  qAdd, ?###? -> movetapesfront,?###?, SRRRS;
 qAdd, ??101 -> qAdd,?0101, SLLLS;
 
 //move 2nd tape
 qMoveX, ?0??? -> qMoveX, ?0???, SLSSS;
 qMoveX, ?1??? -> qMoveX, ?1???, SLSSS;
 //transfer x
  qMoveX, ?#??? -> qLoadX, ?#???, SRSSS;
 qLoadX, ?1??? -> qLoadX, ?11??, SRRSS;
  qLoadX, ?0??? -> qLoadX, ?00??, SRRSS;
 qLoadX, :___? -> qLoadZ, :___?, SRSSS;
 
 //traansfer y
 //move 2nd tape
 qMoveY, ?0??? -> qMoveY, ?0???, SLSSS;
qMoveY, ?1??? -> qMoveY, ?1???, SLSSS;
 //transfer y
 qMoveY, ?#??? -> qLoadY, ?#???, SRSSS;
qLoadY, ?1??? -> qLoadY, ?1?1?, SRSRS;
  qLoadY, ?0??? -> qLoadY, ?0?0?, SRSRS;
 qLoadY, :___? -> qLoadZ, :___?, SRSSS;
 // accept if done 
 qMoveX, :???? -> qLoadZ, :____, RRSSS;
 qMoveY, :???? -> qLoadZ, :____, SRSSS;
 
 //transfer z to y 5
 copymoveY, _0??? -> copymoveY, _0?00, SRRRR;
 copymoveY, _1??? -> copymoveY, _1?11, SRRRR;
  copymoveY, _____ -> qanswer2, _____, SLLLL;

//movetapesfront
movetapesfront, ?0??? -> movetapesfront, ?0???, SRRRR;
 movetapesfront, ?1??? -> movetapesfront, ?1???, SRRRR;
 movetapesfront, ?___? -> qLoadZ, ?___?, SRSSS;
 // movetapesfront, _#??? -> qHalt, _#???, SRRRR;
 
 //move all tapes back
 qanswer2, _0??? -> qanswer2, _0???, SLLLL;
 qanswer2, _1??? -> qanswer2, _1???, SLLLL;
  qanswer2, _#??? -> qHalt, _#???, SRRRR;
  
  
 
