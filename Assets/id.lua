local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then v19=v0(v3(v30,1,1));return "";else local v87=v2(v0(v30,16));if v19 then local v97=v5(v87,v19);v19=nil;return v97;else return v87;end end end);local function v20(v31,v32,v33) if v33 then local v88=(v31/(2^(v32-1)))%(2^(((v33-1) -(v32-1)) + 1)) ;return v88-(v88%1) ;else local v89=2^(v32-1) ;return (((v31%(v89 + v89))>=v89) and 1) or 0 ;end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + 2 );v18=v18 + 2 ;return (v36 * 256) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + 4 ;return (v40 * 16777216) + (v39 * 65536) + (v38 * 256) + v37 ;end local function v24() local v41=v23();local v42=v23();local v43=1;local v44=(v20(v42,1,20) * (2^32)) + v41 ;local v45=v20(v42,21,31);local v46=((v20(v42,32)==1) and  -1) or 1 ;if (v45==0) then if (v44==0) then return v46 * 0 ;else v45=1;v43=0;end elseif (v45==2047) then return ((v44==0) and (v46 * (1/0))) or (v46 * NaN) ;end return v8(v46,v45-1023 ) * (v43 + (v44/(2^52))) ;end local function v25(v47) local v48;if  not v47 then v47=v23();if (v47==0) then return "";end end v48=v3(v16,v18,(v18 + v47) -1 );v18=v18 + v47 ;local v49={};for v63=1, #v48 do v49[v63]=v2(v1(v3(v48,v63,v63)));end return v6(v49);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v50={};local v51={};local v52={};local v53={v50,v51,nil,v52};local v54=v23();local v55={};for v65=1,v54 do local v66=v21();local v67;if (v66==1) then v67=v21()~=0 ;elseif (v66==2) then v67=v24();elseif (v66==3) then v67=v25();end v55[v65]=v67;end v53[3]=v21();for v69=1,v23() do local v70=v21();if (v20(v70,1,1)==0) then local v93=v20(v70,2,3);local v94=v20(v70,4,6);local v95={v22(),v22(),nil,nil};if (v93==0) then v95[3]=v22();v95[4]=v22();elseif (v93==1) then v95[3]=v23();elseif (v93==2) then v95[3]=v23() -(2^16) ;elseif (v93==3) then v95[3]=v23() -(2^16) ;v95[4]=v22();end if (v20(v94,1,1)==1) then v95[2]=v55[v95[2]];end if (v20(v94,2,2)==1) then v95[3]=v55[v95[3]];end if (v20(v94,3,3)==1) then v95[4]=v55[v95[4]];end v50[v69]=v95;end end for v71=1,v23() do v51[v71-1 ]=v28();end return v53;end local function v29(v57,v58,v59) local v60=v57[1];local v61=v57[2];local v62=v57[3];return function(...) local v73=v60;local v74=v61;local v75=v62;local v76=v27;local v77=1;local v78= -1;local v79={};local v80={...};local v81=v12("#",...) -1 ;local v82={};local v83={};for v90=0,v81 do if (v90>=v75) then v79[v90-v75 ]=v80[v90 + 1 ];else v83[v90]=v80[v90 + 1 ];end end local v84=(v81-v75) + 1 ;local v85;local v86;while true do v85=v73[v77];v86=v85[1];if (v86<=6) then if (v86<=2) then if (v86<=0) then local v111=v85[2];do return v13(v83,v111,v111 + v85[3] );end elseif (v86>1) then do return v83[v85[2]];end else v83[v85[2]]=v83[v85[3]][v85[4]];end elseif (v86<=4) then if (v86==3) then v83[v85[2]]=v83[v85[3]][v83[v85[4]]];else v83[v85[2]][v85[3]]=v85[4];end elseif (v86>5) then v83[v85[2]]={};else do return;end end elseif (v86<=10) then if (v86<=8) then if (v86>7) then v83[v85[2]]=v83[v85[3]][v83[v85[4]]];else v83[v85[2]][v85[3]]=v85[4];end elseif (v86==9) then do return;end else v83[v85[2]]=v59[v85[3]];end elseif (v86<=12) then if (v86>11) then do return v83[v85[2]];end else v83[v85[2]]=v83[v85[3]][v85[4]];end elseif (v86==13) then v83[v85[2]]=v59[v85[3]];else v83[v85[2]]={};end v77=v77 + 1 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!8B3Q00022Q00E0B45873E6412Q01022Q009004322CFC41022Q00D08A6430FC41022Q0040D29317FC41022Q00A0679817FC41022Q005001BDD6FB41022Q00401FC1D6FB41022Q00E0FFC1D6FB41022Q00A0617ADFFA41022Q0090567ED6FB41022Q00B0E4C2D6FB41022Q007002F609F741023Q00E7EFC1D741022Q0040BCE4DED941022Q0090899A9CF141022Q004098439EDD41022Q00A04D2DA3E441022Q0080646953E9410100023Q0023DDFFDB41022Q002068C431F441022Q0020FC73F4E141024Q0090B3F740023Q00076109B441022Q0040162001D041022Q00603E8A41EC41022Q00C0A693B7E541025Q00289340022Q0060E03ABDE741023Q00204369BB41022Q00601C432EE241022Q0080569D00EE41022Q00C0CCEB12F041022Q00808B5AE4F341022Q002089E9BEEC41022Q00C0B617ECDC41022Q00C04CB755D141023Q00E96467B241023Q00A3582BB141022Q004091574AD841022Q00F0DBF52CFC41022Q0080C1F42CFC41022Q007036E52CFC41022Q00C010E62CFC41022Q00C0CBA1DBF441022Q0080499ADBF441022Q00C0F797DBF441022Q0080AF7AFEF141022Q00E045061FE541022Q00A00A62AAE241022Q00C0CF02FDF041022Q00E0DF0BE2E641023Q00D70D77B441023Q00A2DA0ECC41022Q00C05C6643D141022Q00409E191CD441023Q00971BA8E241022Q00B0EE9D94F041023Q00A8DB899741023Q00A910D0C341022Q004038D7DDEB41023Q00763546B741022Q0040364B74EF41022Q00809239CFD241022Q00A0D02EB1EE41022Q00F09F89DCF441022Q00C01EBB61D541022Q004033C118F241022Q00C08C92C5DB41022Q00C0768C88D541023Q006E4FFFBE41022Q0080FD77B2F241022Q00206C09C5ED41022Q00805AE840DB41022Q00809907C5ED41023Q00251300D841022Q00E01D9DDBF441022Q0060FE1DD6F441022Q00A088BA21EA41022Q0040430BC5ED41022Q00208A0DC5ED41022Q00A0947FE0EF41022Q0040D6B31CDB41022Q0080FB1F5DC641022Q00C0A4FF7EEF41023Q002747ABE241022Q00606A010BF341023Q004DCEA7C941022Q00A0FACC8AE341022Q00E0C44BC1EF41022Q0060355D23F041022Q00803E2FD2D941022Q00806F310FDD41022Q0090C02B05F341022Q00C019CF88DC41023Q00A43963D541022Q0060E1075DE741022Q0040712EDDF241022Q00805D9ACEED41022Q0020523102F441022Q00F0806298F241022Q004054AB54DA41022Q00F0CE2B02F441023Q008FA98CD741023Q00244005AC41022Q006092D670EA41022Q00802F229CC541023Q00D72449CA41022Q0040796B6ADA41022Q00C0AEDA14D541022Q00E09D3C33E741022Q00802F3D92D641022Q002043C859EA41022Q0080EF7B01D141022Q00E069E36AE841023Q00548607F441023Q0040A5687641022Q00E002A450E841022Q00309C128BF141023Q005331A5B341022Q0080BDC918F241024Q00D9045341023Q00E6702FA541022Q0080204A60DC41022Q00A0C4CFCBF141023Q00C0298C6741022Q0080888B65D241023Q0054346F9D41022Q00604A610CEE41023Q000DBB0CD641022Q00105897BFF341023Q005426B3A741022Q0030B9DE21F341023Q004689EBC44103043Q0067616D6503073Q00506C6179657273030B3Q004C6F63616C506C6179657203063Q00557365724964008D4Q000E5Q00290030043Q000100020030043Q000300020030043Q000400020030043Q000500020030043Q000600020030043Q000700020030043Q000800020030043Q000900020030043Q000A00020030043Q000B00020030043Q000C00020030043Q000D00020030043Q000E00020030043Q000F00020030043Q001000020030043Q001100020030043Q001200020030043Q001300140030043Q001500140030043Q001600140030043Q001700020030043Q001800020030043Q001900020030043Q001A00020030043Q001B00020030043Q001C00020030043Q001D00020030043Q001E00020030043Q001F00020030043Q002000020030043Q002100020030043Q002200020030043Q002300020030043Q002400020030043Q002500020030043Q002600020030043Q002700020030043Q002800020030043Q002900020030043Q002A00020030043Q002B00020030043Q002C00020030043Q002D00020030043Q002E00020030043Q002F00020030043Q003000020030043Q003100020030043Q003200020030043Q003300020030043Q003400020030043Q003500020030043Q003600020030043Q003700020030043Q003800020030043Q003900020030043Q003A00020030043Q003B00020030043Q003C00020030043Q003D00020030043Q003E00020030043Q003F00020030043Q004000020030043Q004100020030043Q004200020030043Q004300020030043Q004400020030043Q004500020030043Q004600020030043Q004700020030043Q004800020030043Q004900020030043Q004A00020030043Q004B00020030043Q004C00020030043Q004D00020030043Q004E00020030043Q004F00020030043Q005000020030043Q005100020030043Q005200020030043Q005300020030043Q005400020030043Q005500020030043Q005600020030043Q005700020030043Q005800020030043Q005900020030043Q005A00020030043Q005B00020030043Q005C00020030043Q005D00020030043Q005E00020030043Q005F00020030043Q006000020030043Q006100020030043Q006200020030043Q006300020030043Q006400020030043Q006500020030043Q006600020030043Q006700020030043Q006800020030043Q006900020030043Q006A00020030043Q006B00020030043Q006C00020030043Q006D00020030043Q006E00020030043Q006F00020030043Q007000020030043Q007100020030043Q007200020030043Q007300020030043Q007400020030043Q007500020030043Q007600020030043Q007700020030043Q007800020030043Q007900140030043Q007A00020030043Q007B00140030043Q007C00140030043Q007D00020030043Q007E00020030043Q007F00140030043Q008000020030043Q008100020030043Q008200020030043Q008300020030043Q008400020030043Q008500020030043Q008600020030043Q0087000200120D000100883Q00200100010001008900200100010001008A00200100010001008B2Q000300023Q00012Q0002000200024Q00093Q00017Q00",v9(),...);