local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==79) then v19=v0(v3(v30,1,1));return "";else local v87=v2(v0(v30,16));if v19 then local v97=v5(v87,v19);v19=nil;return v97;else return v87;end end end);local function v20(v31,v32,v33) if v33 then local v88=(v31/(2^(v32-1)))%(2^(((v33-1) -(v32-1)) + 1)) ;return v88-(v88%1) ;else local v89=2^(v32-1) ;return (((v31%(v89 + v89))>=v89) and 1) or 0 ;end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + 2 );v18=v18 + 2 ;return (v36 * 256) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + 4 ;return (v40 * 16777216) + (v39 * 65536) + (v38 * 256) + v37 ;end local function v24() local v41=v23();local v42=v23();local v43=1;local v44=(v20(v42,1,20) * (2^32)) + v41 ;local v45=v20(v42,21,31);local v46=((v20(v42,32)==1) and  -1) or 1 ;if (v45==0) then if (v44==0) then return v46 * 0 ;else v45=1;v43=0;end elseif (v45==2047) then return ((v44==0) and (v46 * (1/0))) or (v46 * NaN) ;end return v8(v46,v45-1023 ) * (v43 + (v44/(2^52))) ;end local function v25(v47) local v48;if  not v47 then v47=v23();if (v47==0) then return "";end end v48=v3(v16,v18,(v18 + v47) -1 );v18=v18 + v47 ;local v49={};for v63=1, #v48 do v49[v63]=v2(v1(v3(v48,v63,v63)));end return v6(v49);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v50={};local v51={};local v52={};local v53={v50,v51,nil,v52};local v54=v23();local v55={};for v65=1,v54 do local v66=v21();local v67;if (v66==1) then v67=v21()~=0 ;elseif (v66==2) then v67=v24();elseif (v66==3) then v67=v25();end v55[v65]=v67;end v53[3]=v21();for v69=1,v23() do local v70=v21();if (v20(v70,1,1)==0) then local v93=v20(v70,2,3);local v94=v20(v70,4,6);local v95={v22(),v22(),nil,nil};if (v93==0) then v95[3]=v22();v95[4]=v22();elseif (v93==1) then v95[3]=v23();elseif (v93==2) then v95[3]=v23() -(2^16) ;elseif (v93==3) then v95[3]=v23() -(2^16) ;v95[4]=v22();end if (v20(v94,1,1)==1) then v95[2]=v55[v95[2]];end if (v20(v94,2,2)==1) then v95[3]=v55[v95[3]];end if (v20(v94,3,3)==1) then v95[4]=v55[v95[4]];end v50[v69]=v95;end end for v71=1,v23() do v51[v71-1 ]=v28();end return v53;end local function v29(v57,v58,v59) local v60=v57[1];local v61=v57[2];local v62=v57[3];return function(...) local v73=v60;local v74=v61;local v75=v62;local v76=v27;local v77=1;local v78= -1;local v79={};local v80={...};local v81=v12("#",...) -1 ;local v82={};local v83={};for v90=0,v81 do if (v90>=v75) then v79[v90-v75 ]=v80[v90 + 1 ];else v83[v90]=v80[v90 + 1 ];end end local v84=(v81-v75) + 1 ;local v85;local v86;while true do v85=v73[v77];v86=v85[1];if (v86<=5) then if (v86<=2) then if (v86<=0) then v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v83[v85[4]]];v77=v77 + 1 ;v85=v73[v77];do return v83[v85[2]];end v77=v77 + 1 ;v85=v73[v77];do return;end elseif (v86==1) then v83[v85[2]]={};else do return v83[v85[2]];end end elseif (v86<=3) then v83[v85[2]][v85[3]]=v85[4];elseif (v86==4) then v83[v85[2]]=v83[v85[3]][v83[v85[4]]];else v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];end elseif (v86<=8) then if (v86<=6) then v83[v85[2]]=v59[v85[3]];elseif (v86==7) then local v133=v85[2];do return v13(v83,v133,v133 + v85[3] );end else do return;end end elseif (v86<=9) then v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];elseif (v86==10) then v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];else v83[v85[2]]=v83[v85[3]][v85[4]];end v77=v77 + 1 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!293O00022O0020523102F4410100022O00F0806298F2412O01022O004054AB54DA41022O00F0CE2B02F441023O008FA98CD741023O00244005AC41022O006092D670EA41022O00802F229CC541023O00D72449CA41022O0040796B6ADA41022O00C0AEDA14D541022O00E09D3C33E741022O00802F3D92D641022O002043C859EA41022O0080EF7B01D141022O00E069E36AE841023O00548607F441023O0040A5687641022O00E002A450E841022O00309C128BF141023O005331A5B341022O0080BDC918F241024O00D9045341023O00E6702FA541022O0080204A60DC41022O00A0C4CFCBF141023O00C0298C6741022O0080888B65D241023O0054346F9D41022O00604A610CEE41023O000DBB0CD641022O00105897BFF341023O005426B3A741022O0030B9DE21F341023O004689EBC44103043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203063O00557365724964002B4O00055O001900304O0001000200304O0003000400304O0005000400304O0006000200304O0007000400304O0008000400304O0009000400304O000A000400304O000B00040030093O000C000400304O000D000400304O000E000400304O000F000400304O0010000400304O0011000400304O0012000400304O0013000400304O0014000200304O001500040030093O0016000400304O0017000400304O0018000200304O0019000200304O001A000200304O001B000400304O001C000400304O001D000200304O001E000400304O001F00040030033O002000040030033O002100040030033O0022000400304O0023000400304O0024000400304O0025000400122O000100263O00202O00010001002700202O00010001002800202O0001000100294O00023O00014O000200028O00017O00",v9(),...);