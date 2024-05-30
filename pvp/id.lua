--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.5) ~  Much Love, Ferib 

]] --
local v0 = tonumber;
local v1 = string.byte;
local v2 = string.char;
local v3 = string.sub;
local v4 = string.gsub;
local v5 = string.rep;
local v6 = table.concat;
local v7 = table.insert;
local v8 = math.ldexp;
local v9 = getfenv or function()
    return _ENV;
end;
local v10 = setmetatable;
local v11 = pcall;
local v12 = select;
local v13 = unpack or table.unpack;
local v14 = tonumber;
local function v15(v16, v17, ...)
    local v18 = 1;
    local v19;
    v16 = v4(v3(v16, 5), "..", function(v30)
        if (v1(v30, 2) == 79) then
            v19 = v0(v3(v30, 1, 1));
            return "";
        else
            local v68 = v2(v0(v30, 16));
            if v19 then
                local v76 = 0;
                local v77;
                while true do
                    if (v76 == 1) then
                        return v77;
                    end
                    if (v76 == 0) then
                        v77 = v5(v68, v19);
                        v19 = nil;
                        v76 = 1;
                    end
                end
            else
                return v68;
            end
        end
    end);
    local function v20(v31, v32, v33)
        if v33 then
            local v69 = (v31 / ((5 - 3) ^ (v32 - (2 - 1)))) %
                            ((3 - 1) ^ (((v33 - (2 - 1)) - (v32 - (620 - ((2192 - (1523 + 114)) + 64)))) + 1));
            return v69 - (v69 % (932 - (857 + 74)));
        else
            local v70 = (511 + 57) - (367 + 201);
            local v71;
            while true do
                if (v70 == (927 - (214 + 713))) then
                    v71 = ((1 - 0) + (1066 - (68 + 997))) ^ (v32 - (1 + 0));
                    return (((v31 % (v71 + v71)) >= v71) and (878 - (282 + 595))) or 0;
                end
            end
        end
    end
    local function v21()
        local v34 = v1(v16, v18, v18);
        v18 = v18 + 1;
        return v34;
    end
    local function v22()
        local v35, v36 = v1(v16, v18, v18 + (8 - 6));
        v18 = v18 + 2;
        return (v36 * (1526 - (226 + 1044))) + v35;
    end
    local function v23()
        local v37, v38, v39, v40 = v1(v16, v18, v18 + 3 + 0);
        v18 = v18 + 1 + 3;
        return (v40 * (16778173 - (892 + 65))) + (v39 * ((287008 - 130671) - (91151 - (87 + 263)))) +
                   (v38 * (472 - (396 - (67 + 113)))) + v37;
    end
    local function v24()
        local v41 = v23();
        local v42 = v23();
        local v43 = 1 + (0 - 0);
        local v44 = (v20(v42, 2 - 1, 15 + 5) * (((449 - (416 + 26)) - (15 - 10)) ^ (984 - (802 + 150)))) + v41;
        local v45 = v20(v42, 56 - 35, 55 - 24);
        local v46 = ((v20(v42, 24 + 8) == (998 - (915 + 82))) and -(2 - 1)) or (1 + 0);
        if (v45 == (0 - 0)) then
            if (v44 == (1187 - (1069 + 51 + 67))) then
                return v46 * (0 - 0);
            else
                v45 = 2 - 1;
                v43 = 0 - 0;
            end
        elseif (v45 == (356 + 1691)) then
            return ((v44 == (0 - 0)) and (v46 * (1 / (0 + 0)))) or (v46 * NaN);
        end
        return v8(v46, v45 - (1814 - (368 + (861 - (145 + 293))))) * (v43 + (v44 / ((6 - 4) ^ (70 - (10 + 8)))));
    end
    local function v25(v47)
        local v48;
        if not v47 then
            local v72 = (1790 - 1360) - (44 + 386);
            while true do
                if (v72 == (1486 - (998 + 488))) then
                    v47 = v23();
                    if (v47 == ((668 + 470) - (116 + 1022))) then
                        return "";
                    end
                    break
                end
            end
        end
        v48 = v3(v16, v18, (v18 + v47) - 1);
        v18 = v18 + v47;
        local v49 = {};
        for v66 = 1 + 0, #v48 do
            v49[v66] = v2(v1(v3(v48, v66, v66)));
        end
        return v6(v49);
    end
    local v26 = v23;
    local function v27(...)
        return {...}, v12("#", ...);
    end
    local function v28()
        local v50 = 0 - 0;
        local v51;
        local v52;
        local v53;
        local v54;
        local v55;
        local v56;
        local v57;
        local v58;
        while true do
            if (v50 == (935 - (39 + 896))) then
                v51 = 0 - 0;
                v52 = nil;
                v50 = 1 - 0;
            end
            if (v50 ~= 1) then
            else
                v53 = nil;
                v54 = nil;
                v50 = 5 - 3;
            end
            if (v50 == (2 + 0)) then
                v55 = nil;
                v56 = nil;
                v50 = 3;
            end
            if (v50 == (3 + 1)) then
                while true do
                    if (v51 ~= (396 - (115 + 281))) then
                    else
                        v52 = 0;
                        v53 = nil;
                        v51 = 1;
                    end
                    if (v51 ~= 1) then
                    else
                        local v95 = 0 - 0;
                        while true do
                            if (v95 == 1) then
                                v51 = 2 + 0;
                                break
                            end
                            if (v95 == (0 - 0)) then
                                v54 = nil;
                                v55 = nil;
                                v95 = 1;
                            end
                        end
                    end
                    if (v51 ~= (7 - 5)) then
                    else
                        v56 = nil;
                        v57 = nil;
                        v51 = 3;
                    end
                    if ((870 - (550 + 317)) == v51) then
                        v58 = nil;
                        while true do
                            if (v52 ~= (1 - 0)) then
                            else
                                v57 = v23();
                                v58 = {};
                                for v105 = 1, v57 do
                                    local v106 = 0 - 0;
                                    local v107;
                                    local v108;
                                    while true do
                                        if (v106 ~= 0) then
                                        else
                                            local v109 = 0;
                                            while true do
                                                if (v109 ~= (2 - 1)) then
                                                else
                                                    v106 = 286 - (134 + 151);
                                                    break
                                                end
                                                if (v109 == (1665 - (970 + 695))) then
                                                    v107 = v21();
                                                    v108 = nil;
                                                    v109 = 1;
                                                end
                                            end
                                        end
                                        if (v106 ~= (1 - 0)) then
                                        else
                                            if (v107 == (1991 - (582 + 1408))) then
                                                v108 = v21() ~= (0 - 0);
                                            elseif (v107 == 2) then
                                                v108 = v24();
                                            elseif (v107 == 3) then
                                                v108 = v25();
                                            end
                                            v58[v105] = v108;
                                            break
                                        end
                                    end
                                end
                                v56[3] = v21();
                                v52 = 2 - 0;
                            end
                            if (2 ~= v52) then
                            else
                                local v101 = 0;
                                local v102;
                                while true do
                                    if (v101 == (0 - 0)) then
                                        v102 = 1824 - (1195 + 629);
                                        while true do
                                            local v111 = 0;
                                            while true do
                                                if (v111 == (0 - 0)) then
                                                    if (v102 == (242 - (187 + 54))) then
                                                        return v56;
                                                    end
                                                    if (v102 ~= (780 - (162 + 618))) then
                                                    else
                                                        local v164 = 0;
                                                        while true do
                                                            if (v164 == 1) then
                                                                v102 = 1;
                                                                break
                                                            end
                                                            if ((0 + 0) == v164) then
                                                                for v189 = 1, v23() do
                                                                    local v190 = 0;
                                                                    local v191;
                                                                    local v192;
                                                                    while true do
                                                                        if (v190 ~= (1 + 0)) then
                                                                        else
                                                                            while true do
                                                                                if (v191 == (0 - 0)) then
                                                                                    v192 = v21();
                                                                                    if (v20(v192, 1 - 0, 1) == (0 + 0)) then
                                                                                        local v196 = 1636 - (1373 + 263);
                                                                                        local v197;
                                                                                        local v198;
                                                                                        local v199;
                                                                                        local v200;
                                                                                        while true do
                                                                                            if (v196 ~=
                                                                                                (1002 - (451 + 549))) then
                                                                                            else
                                                                                                while true do
                                                                                                    if (v197 == (0 + 0)) then
                                                                                                        local v203 = 0 -
                                                                                                                         0;
                                                                                                        local v204;
                                                                                                        while true do
                                                                                                            if ((0 - 0) ==
                                                                                                                v203) then
                                                                                                                v204 = 0;
                                                                                                                while true do
                                                                                                                    if (v204 ==
                                                                                                                        0) then
                                                                                                                        local 
                                                                                                                            v213 =
                                                                                                                            0;
                                                                                                                        local 
                                                                                                                            v214;
                                                                                                                        while true do
                                                                                                                            if (v213 ==
                                                                                                                                0) then
                                                                                                                                v214 =
                                                                                                                                    1384 -
                                                                                                                                        (746 +
                                                                                                                                            638);
                                                                                                                                while true do
                                                                                                                                    if ((0 +
                                                                                                                                        0) ~=
                                                                                                                                        v214) then
                                                                                                                                    else
                                                                                                                                        v198 =
                                                                                                                                            v20(
                                                                                                                                                v192,
                                                                                                                                                2 -
                                                                                                                                                    0,
                                                                                                                                                344 -
                                                                                                                                                    (218 +
                                                                                                                                                        123));
                                                                                                                                        v199 =
                                                                                                                                            v20(
                                                                                                                                                v192,
                                                                                                                                                4,
                                                                                                                                                6);
                                                                                                                                        v214 =
                                                                                                                                            1;
                                                                                                                                    end
                                                                                                                                    if ((1582 -
                                                                                                                                        (1535 +
                                                                                                                                            46)) ==
                                                                                                                                        v214) then
                                                                                                                                        v204 =
                                                                                                                                            1;
                                                                                                                                        break
                                                                                                                                    end
                                                                                                                                end
                                                                                                                                break
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                    if ((1 +
                                                                                                                        0) ~=
                                                                                                                        v204) then
                                                                                                                    else
                                                                                                                        v197 =
                                                                                                                            1;
                                                                                                                        break
                                                                                                                    end
                                                                                                                end
                                                                                                                break
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                    if (v197 ~= (1 + 2)) then
                                                                                                    else
                                                                                                        if (v20(v199,
                                                                                                            563 -
                                                                                                                (306 +
                                                                                                                    254),
                                                                                                            3) ~= 1) then
                                                                                                        else
                                                                                                            v200[1 + 3] =
                                                                                                                v58[v200[4]];
                                                                                                        end
                                                                                                        v53[v189] = v200;
                                                                                                        break
                                                                                                    end
                                                                                                    if (v197 ~= 2) then
                                                                                                    else
                                                                                                        local v206 = 0 -
                                                                                                                         0;
                                                                                                        while true do
                                                                                                            if (v206 ==
                                                                                                                (1468 -
                                                                                                                    (899 +
                                                                                                                        568))) then
                                                                                                                v197 = 3;
                                                                                                                break
                                                                                                            end
                                                                                                            if (v206 ==
                                                                                                                (0 + 0)) then
                                                                                                                local 
                                                                                                                    v210 =
                                                                                                                    0;
                                                                                                                while true do
                                                                                                                    if (v210 ==
                                                                                                                        (0 -
                                                                                                                            0)) then
                                                                                                                        local 
                                                                                                                            v215 =
                                                                                                                            0;
                                                                                                                        while true do
                                                                                                                            if ((603 -
                                                                                                                                (268 +
                                                                                                                                    335)) ==
                                                                                                                                v215) then
                                                                                                                                if (v20(
                                                                                                                                    v199,
                                                                                                                                    291 -
                                                                                                                                        (60 +
                                                                                                                                            230),
                                                                                                                                    573 -
                                                                                                                                        (426 +
                                                                                                                                            146)) ==
                                                                                                                                    1) then
                                                                                                                                    v200[2] =
                                                                                                                                        v58[v200[2]];
                                                                                                                                end
                                                                                                                                if (v20(
                                                                                                                                    v199,
                                                                                                                                    2,
                                                                                                                                    2) ==
                                                                                                                                    (1 +
                                                                                                                                        0)) then
                                                                                                                                    v200[3] =
                                                                                                                                        v58[v200[3]];
                                                                                                                                end
                                                                                                                                v215 =
                                                                                                                                    1457 -
                                                                                                                                        (282 +
                                                                                                                                            1174);
                                                                                                                            end
                                                                                                                            if ((812 -
                                                                                                                                (569 +
                                                                                                                                    242)) ==
                                                                                                                                v215) then
                                                                                                                                v210 =
                                                                                                                                    2 -
                                                                                                                                        1;
                                                                                                                                break
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                    if (v210 ~=
                                                                                                                        (1 +
                                                                                                                            0)) then
                                                                                                                    else
                                                                                                                        v206 =
                                                                                                                            1025 -
                                                                                                                                (706 +
                                                                                                                                    318);
                                                                                                                        break
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                    if (v197 ~= 1) then
                                                                                                    else
                                                                                                        local v207 = 0;
                                                                                                        while true do
                                                                                                            if (v207 ==
                                                                                                                (1252 -
                                                                                                                    (721 +
                                                                                                                        530))) then
                                                                                                                v197 =
                                                                                                                    1273 -
                                                                                                                        (945 +
                                                                                                                            326);
                                                                                                                break
                                                                                                            end
                                                                                                            if (v207 ==
                                                                                                                (0 - 0)) then
                                                                                                                v200 =
                                                                                                                    {v22(),
                                                                                                                     v22(),
                                                                                                                     nil,
                                                                                                                     nil};
                                                                                                                if (v198 ==
                                                                                                                    0) then
                                                                                                                    local 
                                                                                                                        v211 =
                                                                                                                        0;
                                                                                                                    local 
                                                                                                                        v212;
                                                                                                                    while true do
                                                                                                                        if (v211 ==
                                                                                                                            0) then
                                                                                                                            v212 =
                                                                                                                                1500 -
                                                                                                                                    (1408 +
                                                                                                                                        92);
                                                                                                                            while true do
                                                                                                                                if (v212 ~=
                                                                                                                                    0) then
                                                                                                                                else
                                                                                                                                    v200[3] =
                                                                                                                                        v22();
                                                                                                                                    v200[4] =
                                                                                                                                        v22();
                                                                                                                                    break
                                                                                                                                end
                                                                                                                            end
                                                                                                                            break
                                                                                                                        end
                                                                                                                    end
                                                                                                                elseif (v198 ==
                                                                                                                    (1087 -
                                                                                                                        (461 +
                                                                                                                            625))) then
                                                                                                                    v200[3] =
                                                                                                                        v23();
                                                                                                                elseif (v198 ==
                                                                                                                    2) then
                                                                                                                    v200[1291 -
                                                                                                                        (993 +
                                                                                                                            295)] =
                                                                                                                        v23() -
                                                                                                                            (2 ^
                                                                                                                                16);
                                                                                                                elseif (v198 ==
                                                                                                                    (1 +
                                                                                                                        2)) then
                                                                                                                    local 
                                                                                                                        v224 =
                                                                                                                        0;
                                                                                                                    local 
                                                                                                                        v225;
                                                                                                                    while true do
                                                                                                                        if (v224 ~=
                                                                                                                            (1171 -
                                                                                                                                (418 +
                                                                                                                                    753))) then
                                                                                                                        else
                                                                                                                            v225 =
                                                                                                                                0;
                                                                                                                            while true do
                                                                                                                                if (v225 ==
                                                                                                                                    0) then
                                                                                                                                    v200[2 +
                                                                                                                                        1] =
                                                                                                                                        v23() -
                                                                                                                                            ((1 +
                                                                                                                                                1) ^
                                                                                                                                                (5 +
                                                                                                                                                    11));
                                                                                                                                    v200[2 +
                                                                                                                                        2] =
                                                                                                                                        v22();
                                                                                                                                    break
                                                                                                                                end
                                                                                                                            end
                                                                                                                            break
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                                v207 =
                                                                                                                    530 -
                                                                                                                        (406 +
                                                                                                                            123);
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                                break
                                                                                            end
                                                                                            if (v196 == 1) then
                                                                                                v199 = nil;
                                                                                                v200 = nil;
                                                                                                v196 = 1771 -
                                                                                                           (1749 + 20);
                                                                                            end
                                                                                            if (v196 == (0 + 0)) then
                                                                                                local v201 = 1322 -
                                                                                                                 (1249 +
                                                                                                                     73);
                                                                                                local v202;
                                                                                                while true do
                                                                                                    if (v201 == (0 + 0)) then
                                                                                                        v202 = 1145 -
                                                                                                                   (466 +
                                                                                                                       679);
                                                                                                        while true do
                                                                                                            if (v202 ==
                                                                                                                (2 - 1)) then
                                                                                                                v196 = 1;
                                                                                                                break
                                                                                                            end
                                                                                                            if (v202 ==
                                                                                                                0) then
                                                                                                                v197 =
                                                                                                                    0 -
                                                                                                                        0;
                                                                                                                v198 =
                                                                                                                    nil;
                                                                                                                v202 = 1;
                                                                                                            end
                                                                                                        end
                                                                                                        break
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                    break
                                                                                end
                                                                            end
                                                                            break
                                                                        end
                                                                        if (v190 ~= (1900 - (106 + 1794))) then
                                                                        else
                                                                            local v195 = 0 + 0;
                                                                            while true do
                                                                                if (v195 == (0 + 0)) then
                                                                                    v191 = 0;
                                                                                    v192 = nil;
                                                                                    v195 = 1;
                                                                                end
                                                                                if (v195 == 1) then
                                                                                    v190 = 1;
                                                                                    break
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                                for v193 = 1, v23() do
                                                                    v54[v193 - 1] = v28();
                                                                end
                                                                v164 = 1;
                                                            end
                                                        end
                                                    end
                                                    break
                                                end
                                            end
                                        end
                                        break
                                    end
                                end
                            end
                            if (0 ~= v52) then
                            else
                                local v103 = 0 - 0;
                                local v104;
                                while true do
                                    if ((0 - 0) ~= v103) then
                                    else
                                        v104 = 0;
                                        while true do
                                            if (v104 == 1) then
                                                v55 = {};
                                                v56 = {v53, v54, nil, v55};
                                                v104 = 2;
                                            end
                                            if (v104 == (586 - (57 + 527))) then
                                                v52 = 1;
                                                break
                                            end
                                            if (v104 ~= 0) then
                                            else
                                                v53 = {};
                                                v54 = {};
                                                v104 = 1;
                                            end
                                        end
                                        break
                                    end
                                end
                            end
                        end
                        break
                    end
                end
                break
            end
            if (v50 ~= 3) then
            else
                v57 = nil;
                v58 = nil;
                v50 = 4;
            end
        end
    end
    local function v29(v59, v60, v61)
        local v62 = 0;
        local v63;
        local v64;
        local v65;
        while true do
            if (v62 == 0) then
                v63 = v59[1];
                v64 = v59[2];
                v62 = 1;
            end
            if (v62 == 1) then
                v65 = v59[3];
                return function(...)
                    local v78 = v63;
                    local v79 = v64;
                    local v80 = v65;
                    local v81 = v27;
                    local v82 = 1;
                    local v83 = -1;
                    local v84 = {};
                    local v85 = {...};
                    local v86 = v12("#", ...) - 1;
                    local v87 = {};
                    local v88 = {};
                    for v92 = 0, v86 do
                        if (v92 >= v80) then
                            v84[v92 - v80] = v85[v92 + 1];
                        else
                            v88[v92] = v85[v92 + 1];
                        end
                    end
                    local v89 = (v86 - v80) + 1;
                    local v90;
                    local v91;
                    while true do
                        v90 = v78[v82];
                        v91 = v90[1];
                        if (v91 <= 9) then
                            if (v91 <= 4) then
                                if (v91 <= 1) then
                                    if (v91 == 0) then
                                        if (v88[v90[2]] == v90[4]) then
                                            v82 = v82 + 1;
                                        else
                                            v82 = v90[3];
                                        end
                                    else
                                        local v112 = v90[2];
                                        local v113 = {v88[v112](v88[v112 + 1])};
                                        local v114 = 0;
                                        for v124 = v112, v90[4] do
                                            v114 = v114 + 1;
                                            v88[v124] = v113[v114];
                                        end
                                    end
                                elseif (v91 <= 2) then
                                    v88[v90[2]][v90[3]] = v90[4];
                                elseif (v91 > 3) then
                                    v88[v90[2]] = {};
                                else
                                    v88[v90[2]] = v90[3];
                                end
                            elseif (v91 <= 6) then
                                if (v91 > 5) then
                                    do
                                        return;
                                    end
                                else
                                    v88[v90[2]] = v88[v90[3]][v88[v90[4]]];
                                end
                            elseif (v91 <= 7) then
                                for v127 = v90[2], v90[3] do
                                    v88[v127] = nil;
                                end
                            elseif (v91 > 8) then
                                local v133 = 0;
                                while true do
                                    if (v133 == 1) then
                                        v88[v90[2]] = v88[v90[3]];
                                        v82 = v82 + 1;
                                        v90 = v78[v82];
                                        v133 = 2;
                                    end
                                    if (4 == v133) then
                                        v88[v90[2]] = v88[v90[3]][v90[4]];
                                        v82 = v82 + 1;
                                        v90 = v78[v82];
                                        v133 = 5;
                                    end
                                    if (v133 == 3) then
                                        v88[v90[2]] = v88[v90[3]][v90[4]];
                                        v82 = v82 + 1;
                                        v90 = v78[v82];
                                        v133 = 4;
                                    end
                                    if (v133 == 5) then
                                        v88[v90[2]] = v90[3];
                                        break
                                    end
                                    if (0 == v133) then
                                        v88[v90[2]][v90[3]] = v90[4];
                                        v82 = v82 + 1;
                                        v90 = v78[v82];
                                        v133 = 1;
                                    end
                                    if (v133 == 2) then
                                        v88[v90[2]] = v61[v90[3]];
                                        v82 = v82 + 1;
                                        v90 = v78[v82];
                                        v133 = 3;
                                    end
                                end
                            else
                                local v134 = v90[2];
                                v88[v134](v13(v88, v134 + 1, v90[3]));
                            end
                        elseif (v91 <= 14) then
                            if (v91 <= 11) then
                                if (v91 == 10) then
                                    v88[v90[2]] = v88[v90[3]][v90[4]];
                                else
                                    v82 = v90[3];
                                end
                            elseif (v91 <= 12) then
                                if (v88[v90[2]] == v88[v90[4]]) then
                                    v82 = v82 + 1;
                                else
                                    v82 = v90[3];
                                end
                            elseif (v91 == 13) then
                                local v136 = 0;
                                local v137;
                                local v138;
                                while true do
                                    if (v136 == 0) then
                                        v137 = v90[2];
                                        v138 = v88[v90[3]];
                                        v136 = 1;
                                    end
                                    if (v136 == 1) then
                                        v88[v137 + 1] = v138;
                                        v88[v137] = v138[v90[4]];
                                        break
                                    end
                                end
                            else
                                v88[v90[2]] = v88[v90[3]];
                            end
                        elseif (v91 <= 17) then
                            if (v91 <= 15) then
                                v88[v90[2]] = v61[v90[3]];
                            elseif (v91 > 16) then
                                v88[v90[2]] = v90[3] ~= 0;
                            else
                                local v142;
                                local v143;
                                v88[v90[2]] = v88[v90[3]][v90[4]];
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                v88[v90[2]] = v88[v90[3]][v90[4]];
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                v143 = v90[2];
                                v142 = v88[v90[3]];
                                v88[v143 + 1] = v142;
                                v88[v143] = v142[v90[4]];
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                v88[v90[2]] = v90[3];
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                v143 = v90[2];
                                v88[v143](v13(v88, v143 + 1, v90[3]));
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                do
                                    return;
                                end
                                v82 = v82 + 1;
                                v90 = v78[v82];
                                v82 = v90[3];
                            end
                        elseif (v91 <= 18) then
                            if not v88[v90[2]] then
                                v82 = v82 + 1;
                            else
                                v82 = v90[3];
                            end
                        elseif (v91 > 19) then
                            local v154 = v90[2];
                            local v155 = v90[4];
                            local v156 = v154 + 2;
                            local v157 = {v88[v154](v88[v154 + 1], v88[v156])};
                            for v159 = 1, v155 do
                                v88[v156 + v159] = v157[v159];
                            end
                            local v158 = v157[1];
                            if v158 then
                                local v162 = 0;
                                while true do
                                    if (v162 == 0) then
                                        v88[v156] = v158;
                                        v82 = v90[3];
                                        break
                                    end
                                end
                            else
                                v82 = v82 + 1;
                            end
                        elseif (v90[2] == v88[v90[4]]) then
                            v82 = v82 + 1;
                        else
                            v82 = v90[3];
                        end
                        v82 = v82 + 1;
                    end
                end;
            end
        end
    end
    return v29(v28(), {}, v17)(...);
end
return v15(
    "LOL!0C3O00028O00026O00F03F03063O00557365724964027O0040022O00E01D9DDBF4412O0103043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203053O00706169727303043O004B69636B03303O004745542052452O4B4544204A45524B46414345207C20594F552043414E205553452054484953205348495421204C4F4C003A3O0012033O00014O0007000100043O00264O00070001000200040B3O0007000100200A0003000200032O00050004000100030012033O00043O00264O00100001000100040B3O001000012O000400053O00010030090005000500064O000100053O00122O000500073O00202O00050005000800202O00020005000900124O00023O00264O00020001000400040B3O0002000100120F0005000A4O000E000600014O000100050002000700040B3O001E000100120F000A00073O00200A000A000A000800200A000A000A000900200A000A000A000300060C000A001E0001000900040B3O001E00012O0011000400013O00040B3O00200001000614000500160001000200040B3O00160001000612000400390001000100040B3O00390001001203000500014O0007000600063O000E13000100240001000500040B3O00240001001203000600013O00262O000600270001000100040B3O00270001001203000700013O00262O0007002A0001000100040B3O002A000100120F000800073O00201000080008000800202O00080008000900202O00080008000B00122O000A000C6O0008000A00016O00013O00044O002A000100040B3O0027000100040B3O0039000100040B3O0024000100040B3O0039000100040B3O000200012O00063O00017O00",
    v9(), ...);
