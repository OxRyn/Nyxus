local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==79) then v19=v0(v3(v30,1,1));return "";else local v87=v2(v0(v30,16));if v19 then local v97=v5(v87,v19);v19=nil;return v97;else return v87;end end end);local function v20(v31,v32,v33) if v33 then local v88=(v31/(2^(v32-1)))%(2^(((v33-1) -(v32-1)) + 1)) ;return v88-(v88%1) ;else local v89=2^(v32-1) ;return (((v31%(v89 + v89))>=v89) and 1) or 0 ;end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + 2 );v18=v18 + 2 ;return (v36 * 256) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + 4 ;return (v40 * 16777216) + (v39 * 65536) + (v38 * 256) + v37 ;end local function v24() local v41=v23();local v42=v23();local v43=1;local v44=(v20(v42,1,20) * (2^32)) + v41 ;local v45=v20(v42,21,31);local v46=((v20(v42,32)==1) and  -1) or 1 ;if (v45==0) then if (v44==0) then return v46 * 0 ;else v45=1;v43=0;end elseif (v45==2047) then return ((v44==0) and (v46 * (1/0))) or (v46 * NaN) ;end return v8(v46,v45-1023 ) * (v43 + (v44/(2^52))) ;end local function v25(v47) local v48;if  not v47 then v47=v23();if (v47==0) then return "";end end v48=v3(v16,v18,(v18 + v47) -1 );v18=v18 + v47 ;local v49={};for v63=1, #v48 do v49[v63]=v2(v1(v3(v48,v63,v63)));end return v6(v49);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v50={};local v51={};local v52={};local v53={v50,v51,nil,v52};local v54=v23();local v55={};for v65=1,v54 do local v66=v21();local v67;if (v66==1) then v67=v21()~=0 ;elseif (v66==2) then v67=v24();elseif (v66==3) then v67=v25();end v55[v65]=v67;end v53[3]=v21();for v69=1,v23() do local v70=v21();if (v20(v70,1,1)==0) then local v93=v20(v70,2,3);local v94=v20(v70,4,6);local v95={v22(),v22(),nil,nil};if (v93==0) then v95[3]=v22();v95[4]=v22();elseif (v93==1) then v95[3]=v23();elseif (v93==2) then v95[3]=v23() -(2^16) ;elseif (v93==3) then v95[3]=v23() -(2^16) ;v95[4]=v22();end if (v20(v94,1,1)==1) then v95[2]=v55[v95[2]];end if (v20(v94,2,2)==1) then v95[3]=v55[v95[3]];end if (v20(v94,3,3)==1) then v95[4]=v55[v95[4]];end v50[v69]=v95;end end for v71=1,v23() do v51[v71-1 ]=v28();end return v53;end local function v29(v57,v58,v59) local v60=v57[1];local v61=v57[2];local v62=v57[3];return function(...) local v73=v60;local v74=v61;local v75=v62;local v76=v27;local v77=1;local v78= -1;local v79={};local v80={...};local v81=v12("#",...) -1 ;local v82={};local v83={};for v90=0,v81 do if (v90>=v75) then v79[v90-v75 ]=v80[v90 + 1 ];else v83[v90]=v80[v90 + 1 ];end end local v84=(v81-v75) + 1 ;local v85;local v86;while true do v85=v73[v77];v86=v85[1];if (v86<=15) then if (v86<=7) then if (v86<=3) then if (v86<=1) then if (v86>0) then do return;end elseif (v83[v85[2]]==v83[v85[4]]) then v77=v77 + 1 ;else v77=v85[3];end elseif (v86==2) then local v114=v85[2];local v115=v83[v85[3]];v83[v114 + 1 ]=v115;v83[v114]=v115[v85[4]];else v83[v85[2]]=v59[v85[3]];end elseif (v86<=5) then if (v86==4) then v83[v85[2]][v85[3]]=v85[4];else v83[v85[2]]=v83[v85[3]][v83[v85[4]]];end elseif (v86==6) then v83[v85[2]]=v83[v85[3]];else v77=v85[3];end elseif (v86<=11) then if (v86<=9) then if (v86==8) then v83[v85[2]]=v83[v85[3]][v85[4]];else v83[v85[2]]=v85[3]~=0 ;end elseif (v86>10) then if (v83[v85[2]]==v83[v85[4]]) then v77=v77 + 1 ;else v77=v85[3];end else v83[v85[2]]=v83[v85[3]][v85[4]];end elseif (v86<=13) then if (v86==12) then local v133=v85[2];local v134=v85[4];local v135=v133 + 2 ;local v136={v83[v133](v83[v133 + 1 ],v83[v135])};for v172=1,v134 do v83[v135 + v172 ]=v136[v172];end local v137=v136[1];if v137 then v83[v135]=v137;v77=v85[3];else v77=v77 + 1 ;end else v77=v85[3];end elseif (v86==14) then v83[v85[2]]=v59[v85[3]];else do return;end end elseif (v86<=23) then if (v86<=19) then if (v86<=17) then if (v86==16) then v83[v85[2]]={};else local v142=v85[2];local v143={v83[v142](v83[v142 + 1 ])};local v144=0;for v175=v142,v85[4] do v144=v144 + 1 ;v83[v175]=v143[v144];end end elseif (v86>18) then v83[v85[2]]=v85[3];else local v147=v85[2];v83[v147](v13(v83,v147 + 1 ,v85[3]));end elseif (v86<=21) then if (v86==20) then v83[v85[2]]=v83[v85[3]][v83[v85[4]]];else local v150=v85[2];v83[v150](v13(v83,v150 + 1 ,v85[3]));end elseif (v86==22) then if  not v83[v85[2]] then v77=v77 + 1 ;else v77=v85[3];end elseif  not v83[v85[2]] then v77=v77 + 1 ;else v77=v85[3];end elseif (v86<=27) then if (v86<=25) then if (v86>24) then v83[v85[2]][v85[3]]=v85[4];else v83[v85[2]]=v83[v85[3]];end elseif (v86==26) then v83[v85[2]]=v85[3]~=0 ;else v83[v85[2]]={};end elseif (v86<=29) then if (v86==28) then v83[v85[2]]=v85[3];else local v159=v85[2];local v160=v85[4];local v161=v159 + 2 ;local v162={v83[v159](v83[v159 + 1 ],v83[v161])};for v178=1,v160 do v83[v161 + v178 ]=v162[v178];end local v163=v162[1];if v163 then v83[v161]=v163;v77=v85[3];else v77=v77 + 1 ;end end elseif (v86>30) then local v164=v85[2];local v165={v83[v164](v83[v164 + 1 ])};local v166=0;for v181=v164,v85[4] do v166=v166 + 1 ;v83[v181]=v165[v166];end else local v167=v85[2];local v168=v83[v85[3]];v83[v167 + 1 ]=v168;v83[v167]=v168[v85[4]];end v77=v77 + 1 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!1A3O00022O00E002A450E8412O01022O00309C128BF141023O005331A5B341022O0080BDC918F2410100024O00D9045341023O00E6702FA541022O0080204A60DC41022O00A0C4CFCBF141023O00C0298C6741022O0080888B65D241023O0054346F9D41022O00604A610CEE41023O000DBB0CD641022O00105897BFF341023O005426B3A741022O0030B9DE21F341023O004689EBC44103043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203063O0055736572496403053O00706169727303043O004B69636B032A3O00596F7520617265206E6F7420617574686F72697A656420746F207573652074686973207363726970742E002F4O001B5O00110030193O000100020030193O000300020030193O000400020030193O000500060030193O000700060030193O000800060030193O000900020030193O000A00020030193O000B00060030193O000C00020030193O000D00020030193O000E00020030193O000F00020030193O001000020030193O001100020030193O001200020030193O0013000200120E000100143O00200A00010001001500200A00010001001600200A0002000100172O000500033O000200120E000400184O001800056O001100040002000600040D3O0023000100120E000900143O00200A00090009001500200A00090009001600200A00090009001700060B000900230001000800040D3O002300012O001A000300013O00040D3O0025000100060C0004001B0001000200040D3O001B00010006160003002E0001000100040D3O002E000100120E000400143O00200A00040004001500200A00040004001600200200040004001900121C0006001A4O00150004000600012O00013O00014O00013O00017O00",v9(),...);