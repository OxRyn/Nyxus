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
            local v67 = 0;
            while true do
                if (v67 == 0) then
                    v19 = v0(v3(v30, 1, 1));
                    return "";
                end
            end
        else
            local v68 = v2(v0(v30, 16));
            if v19 then
                local v82 = v5(v68, v19);
                v19 = nil;
                return v82;
            else
                return v68;
            end
        end
    end);
    local function v20(v31, v32, v33)
        if v33 then
            local v69 = 0 - 0;
            local v70;
            while true do
                if (v69 == (0 - 0)) then
                    v70 = (v31 / ((3 - 1) ^ (v32 - 1))) %
                              ((4 - 2) ^
                                  (((v33 - (620 - (555 + 64))) - (v32 - (932 - (857 + 74)))) +
                                      (569 - ((523 - 156) + 201))));
                    return v70 - (v70 % ((1993 - (68 + 997)) - (214 + 713)));
                end
            end
        else
            local v71 = 0;
            local v72;
            while true do
                if (v71 == ((1270 - (226 + 1044)) + 0)) then
                    v72 = (1 + 1) ^ (v32 - (878 - (282 + 595)));
                    return (((v31 % (v72 + v72)) >= v72) and ((7132 - 5494) - (1523 + 114))) or (0 + 0);
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
        local v35 = (86 + 31) - (32 + 85);
        local v36;
        local v37;
        while true do
            if (v35 == (1 + 0)) then
                return (v37 * (469 - (522 - 309))) + v36;
            end
            if (v35 == (0 + 0)) then
                v36, v37 = v1(v16, v18, v18 + (352 - (87 + 263)));
                v18 = v18 + (959 - (657 + 235 + 65));
                v35 = 181 - (67 + 113);
            end
        end
    end
    local function v23()
        local v38, v39, v40, v41 = v1(v16, v18, v18 + (11 - 8));
        v18 = v18 + (956 - (802 + 150));
        return (v41 * (45169940 - 28392724)) + (v40 * ((119876 - (915 + 82)) - 53343)) + (v39 * (187 + 69)) + v38;
    end
    local function v24()
        local v42 = v23();
        local v43 = v23();
        local v44 = 2 - 1;
        local v45 = (v20(v43, 1 + 0, 20) * ((2 - (1486 - (998 + 488))) ^ (1219 - (1069 + 118)))) + v42;
        local v46 = v20(v43, 47 - 26, 67 - 36);
        local v47 = ((v20(v43, 6 + 9 + 17) == (1 - 0)) and -(1 + 0)) or (792 - (368 + 423));
        if (v46 == (0 + 0)) then
            if (v45 == (0 - 0)) then
                return v47 * (18 - (10 + 8));
            else
                v46 = 1;
                v44 = 0 - (772 - (201 + 571));
            end
        elseif (v46 == (3185 - (116 + 1022))) then
            return ((v45 == ((1840 - 1398) - (416 + 26))) and (v47 * ((3 - 2) / (0 + 0)))) or (v47 * NaN);
        end
        return v8(v47, v46 - (1809 - 786)) * (v44 + (v45 / ((440 - (145 + 293)) ^ (482 - (44 + 227 + 159)))));
    end
    local function v25(v48)
        local v49;
        if not v48 then
            v48 = v23();
            if (v48 == (0 - 0)) then
                return "";
            end
        end
        v49 = v3(v16, v18, (v18 + v48) - 1);
        v18 = v18 + v48;
        local v50 = {};
        for v65 = 3 - 2, #v49 do
            v50[v65] = v2(v1(v3(v49, v65, v65)));
        end
        return v6(v50);
    end
    local v26 = v23;
    local function v27(...)
        return {...}, v12("#", ...);
    end
    local function v28()
        local v51 = 0 + 0;
        local v52;
        local v53;
        local v54;
        local v55;
        local v56;
        local v57;
        while true do
            if (v51 ~= (1 + 0)) then
            else
                local v73 = 0;
                local v74;
                while true do
                    if (v73 == 0) then
                        v74 = 0 + 0;
                        while true do
                            if (v74 ~= (836 - (660 + 176))) then
                            else
                                local v116 = 0 + 0;
                                while true do
                                    if (v116 == (203 - (14 + 188))) then
                                        v74 = 676 - (534 + 141);
                                        break
                                    end
                                    if (v116 == (0 + 0)) then
                                        v55 = {v52, v53, nil, v54};
                                        v56 = v23();
                                        v116 = 1 - 0;
                                    end
                                end
                            end
                            if (1 ~= v74) then
                            else
                                v57 = {};
                                v51 = 2;
                                break
                            end
                        end
                        break
                    end
                end
            end
            if (v51 == 3) then
                local v75 = 0 - 0;
                local v76;
                while true do
                    if ((0 + 0) ~= v75) then
                    else
                        v76 = 0;
                        while true do
                            if (v76 ~= (0 + 0)) then
                            else
                                local v117 = 396 - (115 + 281);
                                while true do
                                    if (v117 == 0) then
                                        for v119 = 2 - 1, v23() do
                                            v53[v119 - (1 + 0)] = v28();
                                        end
                                        return v55;
                                    end
                                end
                            end
                        end
                        break
                    end
                end
            end
            if (v51 == 0) then
                local v77 = 0;
                while true do
                    if (v77 ~= 1) then
                    else
                        v54 = {};
                        v51 = 1;
                        break
                    end
                    if (v77 ~= (0 - 0)) then
                    else
                        v52 = {};
                        v53 = {};
                        v77 = 3 - 2;
                    end
                end
            end
            if (v51 == (869 - (550 + 317))) then
                for v83 = 1 - 0, v56 do
                    local v84 = 0;
                    local v85;
                    local v86;
                    while true do
                        if (v84 ~= 0) then
                        else
                            local v109 = 0;
                            while true do
                                if (1 ~= v109) then
                                else
                                    v84 = 1 - 0;
                                    break
                                end
                                if (v109 == (0 - 0)) then
                                    v85 = v21();
                                    v86 = nil;
                                    v109 = 1;
                                end
                            end
                        end
                        if (v84 == 1) then
                            if (v85 == 1) then
                                v86 = v21() ~= (285 - (134 + 151));
                            elseif (v85 == (1667 - (970 + 695))) then
                                v86 = v24();
                            elseif (v85 == (5 - 2)) then
                                v86 = v25();
                            end
                            v57[v83] = v86;
                            break
                        end
                    end
                end
                v55[1993 - (582 + 1408)] = v21();
                for v87 = 1, v23() do
                    local v88 = 0;
                    local v89;
                    local v90;
                    local v91;
                    while true do
                        if (1 == v88) then
                            v91 = nil;
                            while true do
                                if (v89 == (3 - 2)) then
                                    while true do
                                        if (v90 ~= 0) then
                                        else
                                            v91 = v21();
                                            if (v20(v91, 1 - 0, 1) ~= (0 - 0)) then
                                            else
                                                local v121 = 1824 - (1195 + 629);
                                                local v122;
                                                local v123;
                                                local v124;
                                                local v125;
                                                local v126;
                                                while true do
                                                    if (v121 ~= 2) then
                                                    else
                                                        v126 = nil;
                                                        while true do
                                                            if (v122 == (1 - 0)) then
                                                                v125 = nil;
                                                                v126 = nil;
                                                                v122 = 2;
                                                            end
                                                            if (v122 == (243 - (187 + 54))) then
                                                                while true do
                                                                    if (v123 ~= 1) then
                                                                    else
                                                                        v126 = {v22(), v22(), nil, nil};
                                                                        if (v124 == (0 - 0)) then
                                                                            local v901 = 0 - 0;
                                                                            local v902;
                                                                            local v903;
                                                                            while true do
                                                                                if (v901 == 1) then
                                                                                    while true do
                                                                                        if (v902 ~= 0) then
                                                                                        else
                                                                                            v903 = 0;
                                                                                            while true do
                                                                                                if (v903 ~= 0) then
                                                                                                else
                                                                                                    v126[3] = v22();
                                                                                                    v126[1 + 3] = v22();
                                                                                                    break
                                                                                                end
                                                                                            end
                                                                                            break
                                                                                        end
                                                                                    end
                                                                                    break
                                                                                end
                                                                                if (0 == v901) then
                                                                                    v902 = 0;
                                                                                    v903 = nil;
                                                                                    v901 = 1;
                                                                                end
                                                                            end
                                                                        elseif (v124 == 1) then
                                                                            v126[1639 - (1373 + 263)] = v23();
                                                                        elseif (v124 == 2) then
                                                                            v126[3] = v23() - (2 ^ 16);
                                                                        elseif (v124 ~= 3) then
                                                                        else
                                                                            local v910 = 1000 - (451 + 549);
                                                                            local v911;
                                                                            while true do
                                                                                if ((0 + 0) == v910) then
                                                                                    v911 = 0 - 0;
                                                                                    while true do
                                                                                        if (v911 == (0 - 0)) then
                                                                                            v126[3] = v23() - (2 ^ 16);
                                                                                            v126[1388 - (746 + 638)] =
                                                                                                v22();
                                                                                            break
                                                                                        end
                                                                                    end
                                                                                    break
                                                                                end
                                                                            end
                                                                        end
                                                                        v123 = 1 + 1;
                                                                    end
                                                                    if (v123 ~= 3) then
                                                                    else
                                                                        if (v20(v125, 4 - 1, 344 - (218 + 123)) ~=
                                                                            (1582 - (1535 + 46))) then
                                                                        else
                                                                            v126[4 + 0] = v57[v126[1 + 3]];
                                                                        end
                                                                        v52[v87] = v126;
                                                                        break
                                                                    end
                                                                    if (v123 == 2) then
                                                                        local v896 = 0;
                                                                        local v897;
                                                                        while true do
                                                                            if (v896 == (560 - (306 + 254))) then
                                                                                v897 = 0 + 0;
                                                                                while true do
                                                                                    if (v897 ~= 0) then
                                                                                    else
                                                                                        if (v20(v125, 1 - 0, 1) ==
                                                                                            (1468 - (899 + 568))) then
                                                                                            v126[2] = v57[v126[2 + 0]];
                                                                                        end
                                                                                        if (v20(v125, 4 - 2, 2) ==
                                                                                            (604 - (268 + 335))) then
                                                                                            v126[3] = v57[v126[3]];
                                                                                        end
                                                                                        v897 = 1;
                                                                                    end
                                                                                    if (v897 == 1) then
                                                                                        v123 = 293 - (60 + 230);
                                                                                        break
                                                                                    end
                                                                                end
                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                    if (v123 ~= 0) then
                                                                    else
                                                                        v124 = v20(v91, 2, 575 - (426 + 146));
                                                                        v125 = v20(v91, 4, 6);
                                                                        v123 = 1;
                                                                    end
                                                                end
                                                                break
                                                            end
                                                            if (v122 ~= 0) then
                                                            else
                                                                v123 = 0 + 0;
                                                                v124 = nil;
                                                                v122 = 1;
                                                            end
                                                        end
                                                        break
                                                    end
                                                    if (v121 ~= (1456 - (282 + 1174))) then
                                                    else
                                                        v122 = 811 - (569 + 242);
                                                        v123 = nil;
                                                        v121 = 2 - 1;
                                                    end
                                                    if (v121 ~= (1 + 0)) then
                                                    else
                                                        v124 = nil;
                                                        v125 = nil;
                                                        v121 = 2;
                                                    end
                                                end
                                            end
                                            break
                                        end
                                    end
                                    break
                                end
                                if (v89 ~= (1024 - (706 + 318))) then
                                else
                                    local v118 = 1251 - (721 + 530);
                                    while true do
                                        if (v118 == (1271 - (945 + 326))) then
                                            v90 = 0 - 0;
                                            v91 = nil;
                                            v118 = 1;
                                        end
                                        if (v118 ~= 1) then
                                        else
                                            v89 = 1 + 0;
                                            break
                                        end
                                    end
                                end
                            end
                            break
                        end
                        if (v88 ~= (700 - (271 + 429))) then
                        else
                            local v111 = 0 + 0;
                            while true do
                                if ((1501 - (1408 + 92)) == v111) then
                                    v88 = 1087 - (461 + 625);
                                    break
                                end
                                if (v111 == (1288 - (993 + 295))) then
                                    v89 = 0 + 0;
                                    v90 = nil;
                                    v111 = 1172 - (418 + 753);
                                end
                            end
                        end
                    end
                end
                v51 = 2 + 1;
            end
        end
    end
    local function v29(v58, v59, v60)
        local v61 = 0;
        local v62;
        local v63;
        local v64;
        while true do
            if (1 == v61) then
                v64 = v58[3];
                return function(...)
                    local v92 = v62;
                    local v93 = v63;
                    local v94 = v64;
                    local v95 = v27;
                    local v96 = 1;
                    local v97 = -1;
                    local v98 = {};
                    local v99 = {...};
                    local v100 = v12("#", ...) - 1;
                    local v101 = {};
                    local v102 = {};
                    for v106 = 0, v100 do
                        if (v106 >= v94) then
                            v98[v106 - v94] = v99[v106 + 1];
                        else
                            v102[v106] = v99[v106 + 1];
                        end
                    end
                    local v103 = (v100 - v94) + 1;
                    local v104;
                    local v105;
                    while true do
                        v104 = v92[v96];
                        v105 = v104[1];
                        if (v105 <= 34) then
                            if (v105 <= 16) then
                                if (v105 <= 7) then
                                    if (v105 <= 3) then
                                        if (v105 <= 1) then
                                            if (v105 > 0) then
                                                v102[v104[2]] = v104[3];
                                            else
                                                local v129;
                                                local v130;
                                                v102[v104[2]][v104[3]] = v102[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v130 = v104[2];
                                                v102[v130](v13(v102, v130 + 1, v104[3]));
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v130 = v104[2];
                                                v129 = v102[v104[3]];
                                                v102[v130 + 1] = v129;
                                                v102[v130] = v129[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v104[3];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = {};
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v130 = v104[2];
                                                v102[v130] = v102[v130](v13(v102, v130 + 1, v104[3]));
                                            end
                                        elseif (v105 > 2) then
                                            v102[v104[2]] = v59[v104[3]];
                                        else
                                            local v145 = 0;
                                            local v146;
                                            local v147;
                                            while true do
                                                if (v145 == 1) then
                                                    for v809 = v146 + 1, v104[3] do
                                                        v7(v147, v102[v809]);
                                                    end
                                                    break
                                                end
                                                if (v145 == 0) then
                                                    v146 = v104[2];
                                                    v147 = v102[v146];
                                                    v145 = 1;
                                                end
                                            end
                                        end
                                    elseif (v105 <= 5) then
                                        if (v105 == 4) then
                                            local v148 = 0;
                                            local v149;
                                            local v150;
                                            while true do
                                                if (v148 == 8) then
                                                    v102[v150](v13(v102, v150 + 1, v104[3]));
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    do
                                                        return;
                                                    end
                                                    break
                                                end
                                                if (1 == v148) then
                                                    v150 = v104[2];
                                                    v149 = v102[v104[3]];
                                                    v102[v150 + 1] = v149;
                                                    v102[v150] = v149[v104[4]];
                                                    v96 = v96 + 1;
                                                    v148 = 2;
                                                end
                                                if (0 == v148) then
                                                    v149 = nil;
                                                    v150 = nil;
                                                    v102[v104[2]] = v60[v104[3]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v148 = 1;
                                                end
                                                if (5 == v148) then
                                                    v149 = v102[v104[3]];
                                                    v102[v150 + 1] = v149;
                                                    v102[v150] = v149[v104[4]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v148 = 6;
                                                end
                                                if (7 == v148) then
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v104[3];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v150 = v104[2];
                                                    v148 = 8;
                                                end
                                                if (v148 == 4) then
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v150 = v104[2];
                                                    v148 = 5;
                                                end
                                                if (v148 == 6) then
                                                    v102[v104[2]] = v104[3];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v104[3];
                                                    v96 = v96 + 1;
                                                    v148 = 7;
                                                end
                                                if (v148 == 3) then
                                                    v102[v150] = v102[v150](v13(v102, v150 + 1, v104[3]));
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v96 = v96 + 1;
                                                    v148 = 4;
                                                end
                                                if (v148 == 2) then
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v104[3];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v150 = v104[2];
                                                    v148 = 3;
                                                end
                                            end
                                        else
                                            local v151;
                                            local v152;
                                            v59[v104[3]] = v102[v104[2]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v60[v104[3]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]][v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]][v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]][v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v152 = v104[2];
                                            v151 = v102[v104[3]];
                                            v102[v152 + 1] = v151;
                                            v102[v152] = v151[v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v152 = v104[2];
                                            v102[v152] = v102[v152](v13(v102, v152 + 1, v104[3]));
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v152 = v104[2];
                                            v151 = v102[v104[3]];
                                            v102[v152 + 1] = v151;
                                            v102[v152] = v151[v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v60[v104[3]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]][v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]][v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v152 = v104[2];
                                            v102[v152](v13(v102, v152 + 1, v104[3]));
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                        end
                                    elseif (v105 > 6) then
                                        local v164 = 0;
                                        local v165;
                                        local v166;
                                        while true do
                                            if (v164 == 0) then
                                                v165 = nil;
                                                v166 = nil;
                                                v166 = v104[2];
                                                v102[v166](v102[v166 + 1]);
                                                v164 = 1;
                                            end
                                            if (v164 == 3) then
                                                v102[v104[2]] = {};
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v166 = v104[2];
                                                v164 = 4;
                                            end
                                            if (v164 == 7) then
                                                v166 = v104[2];
                                                v102[v166](v13(v102, v166 + 1, v104[3]));
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v164 = 8;
                                            end
                                            if (v164 == 4) then
                                                v102[v166](v13(v102, v166 + 1, v104[3]));
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v166 = v104[2];
                                                v164 = 5;
                                            end
                                            if (v164 == 1) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v166 = v104[2];
                                                v165 = v102[v104[3]];
                                                v164 = 2;
                                            end
                                            if (v164 == 5) then
                                                v165 = v102[v104[3]];
                                                v102[v166 + 1] = v165;
                                                v102[v166] = v165[v104[4]];
                                                v96 = v96 + 1;
                                                v164 = 6;
                                            end
                                            if (v164 == 8) then
                                                v102[v104[2]] = v104[3];
                                                break
                                            end
                                            if (v164 == 2) then
                                                v102[v166 + 1] = v165;
                                                v102[v166] = v165[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v164 = 3;
                                            end
                                            if (v164 == 6) then
                                                v104 = v92[v96];
                                                v102[v104[2]] = v104[3];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v164 = 7;
                                            end
                                        end
                                    elseif (v102[v104[2]] == v104[4]) then
                                        v96 = v96 + 1;
                                    else
                                        v96 = v104[3];
                                    end
                                elseif (v105 <= 11) then
                                    if (v105 <= 9) then
                                        if (v105 > 8) then
                                            local v167 = 0;
                                            local v168;
                                            local v169;
                                            while true do
                                                if (v167 == 4) then
                                                    v102[v104[2]][v104[3]] = v104[4];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v169 = v104[2];
                                                    v102[v169] = v102[v169](v13(v102, v169 + 1, v104[3]));
                                                    v167 = 5;
                                                end
                                                if (v167 == 7) then
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = {};
                                                    break
                                                end
                                                if (v167 == 3) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]][v104[3]] = v104[4];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v167 = 4;
                                                end
                                                if (v167 == 2) then
                                                    v102[v169 + 1] = v168;
                                                    v102[v169] = v168[v104[4]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = {};
                                                    v167 = 3;
                                                end
                                                if (v167 == 5) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]][v104[3]] = v102[v104[4]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v167 = 6;
                                                end
                                                if (v167 == 6) then
                                                    v169 = v104[2];
                                                    v168 = v102[v104[3]];
                                                    v102[v169 + 1] = v168;
                                                    v102[v169] = v168[v104[4]];
                                                    v96 = v96 + 1;
                                                    v167 = 7;
                                                end
                                                if (v167 == 0) then
                                                    v168 = nil;
                                                    v169 = nil;
                                                    v60[v104[3]] = v102[v104[2]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v167 = 1;
                                                end
                                                if (v167 == 1) then
                                                    v102[v104[2]] = {};
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v169 = v104[2];
                                                    v168 = v102[v104[3]];
                                                    v167 = 2;
                                                end
                                            end
                                        else
                                            local v170 = 0;
                                            local v171;
                                            local v172;
                                            local v173;
                                            local v174;
                                            local v175;
                                            while true do
                                                if (v170 == 2) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v96 = v96 + 1;
                                                    v170 = 3;
                                                end
                                                if (v170 == 0) then
                                                    v171 = nil;
                                                    v172, v173 = nil;
                                                    v174 = nil;
                                                    v175 = nil;
                                                    v170 = 1;
                                                end
                                                if (v170 == 10) then
                                                    v174 = v102[v104[3]];
                                                    v102[v175 + 1] = v174;
                                                    v102[v175] = v174[v104[4]];
                                                    break
                                                end
                                                if (v170 == 3) then
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v170 = 4;
                                                end
                                                if (v170 == 4) then
                                                    v175 = v104[2];
                                                    v174 = v102[v104[3]];
                                                    v102[v175 + 1] = v174;
                                                    v102[v175] = v174[v104[4]];
                                                    v170 = 5;
                                                end
                                                if (v170 == 6) then
                                                    v104 = v92[v96];
                                                    v175 = v104[2];
                                                    v172, v173 = v95(v102[v175](v13(v102, v175 + 1, v104[3])));
                                                    v97 = (v173 + v175) - 1;
                                                    v170 = 7;
                                                end
                                                if (v170 == 1) then
                                                    v102[v104[2]] = v60[v104[3]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v170 = 2;
                                                end
                                                if (v170 == 8) then
                                                    v175 = v104[2];
                                                    v102[v175] = v102[v175](v13(v102, v175 + 1, v97));
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v170 = 9;
                                                end
                                                if (5 == v170) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v104[3];
                                                    v96 = v96 + 1;
                                                    v170 = 6;
                                                end
                                                if (7 == v170) then
                                                    v171 = 0;
                                                    for v810 = v175, v97 do
                                                        v171 = v171 + 1;
                                                        v102[v810] = v172[v171];
                                                    end
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v170 = 8;
                                                end
                                                if (v170 == 9) then
                                                    v102[v104[2]] = v102[v104[3]];
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v175 = v104[2];
                                                    v170 = 10;
                                                end
                                            end
                                        end
                                    elseif (v105 > 10) then
                                        local v176 = v104[2];
                                        local v177 = v102[v176];
                                        local v178 = v104[3];
                                        for v412 = 1, v178 do
                                            v177[v412] = v102[v176 + v412];
                                        end
                                    else
                                        do
                                            return;
                                        end
                                    end
                                elseif (v105 <= 13) then
                                    if (v105 == 12) then
                                        local v179;
                                        local v180;
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v180 = v104[2];
                                        v102[v180](v13(v102, v180 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v180 = v104[2];
                                        v179 = v102[v104[3]];
                                        v102[v180 + 1] = v179;
                                        v102[v180] = v179[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = {};
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v180 = v104[2];
                                        v102[v180](v13(v102, v180 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v180 = v104[2];
                                        v179 = v102[v104[3]];
                                        v102[v180 + 1] = v179;
                                        v102[v180] = v179[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v180 = v104[2];
                                        v102[v180](v102[v180 + 1]);
                                    elseif v102[v104[2]] then
                                        v96 = v96 + 1;
                                    else
                                        v96 = v104[3];
                                    end
                                elseif (v105 <= 14) then
                                    local v191 = 0;
                                    local v192;
                                    local v193;
                                    while true do
                                        if (v191 == 5) then
                                            v102[v104[2]] = {};
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = {};
                                            v191 = 6;
                                        end
                                        if (v191 == 3) then
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]][v104[3]] = v104[4];
                                            v96 = v96 + 1;
                                            v191 = 4;
                                        end
                                        if (v191 == 1) then
                                            v104 = v92[v96];
                                            v193 = v104[2];
                                            v192 = v102[v104[3]];
                                            v102[v193 + 1] = v192;
                                            v191 = 2;
                                        end
                                        if (v191 == 6) then
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]][v104[3]] = v104[4];
                                            break
                                        end
                                        if (v191 == 0) then
                                            v192 = nil;
                                            v193 = nil;
                                            v102[v104[2]] = v59[v104[3]];
                                            v96 = v96 + 1;
                                            v191 = 1;
                                        end
                                        if (v191 == 2) then
                                            v102[v193] = v192[v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = {};
                                            v191 = 3;
                                        end
                                        if (v191 == 4) then
                                            v104 = v92[v96];
                                            v102[v104[2]][v104[3]] = v104[4];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v191 = 5;
                                        end
                                    end
                                elseif (v105 == 15) then
                                    local v443;
                                    local v444;
                                    v444 = v104[2];
                                    v443 = v102[v104[3]];
                                    v102[v444 + 1] = v443;
                                    v102[v444] = v443[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v444 = v104[2];
                                    v102[v444](v13(v102, v444 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v96 = v104[3];
                                else
                                    local v453;
                                    v102[v104[2]][v104[3]] = v104[4];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v60[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v102[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v453 = v104[2];
                                    v102[v453] = v102[v453](v13(v102, v453 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                end
                            elseif (v105 <= 25) then
                                if (v105 <= 20) then
                                    if (v105 <= 18) then
                                        if (v105 == 17) then
                                            local v194;
                                            local v195;
                                            v195 = v104[2];
                                            v194 = v102[v104[3]];
                                            v102[v195 + 1] = v194;
                                            v102[v195] = v194[v104[4]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = {};
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]][v104[3]] = v104[4];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]][v104[3]] = v104[4];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v195 = v104[2];
                                            v102[v195] = v102[v195](v13(v102, v195 + 1, v104[3]));
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v96 = v104[3];
                                        else
                                            v60[v104[3]] = v102[v104[2]];
                                        end
                                    elseif (v105 == 19) then
                                        v102[v104[2]] = v60[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v102[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        do
                                            return;
                                        end
                                    else
                                        local v214 = 0;
                                        local v215;
                                        local v216;
                                        while true do
                                            if (v214 == 3) then
                                                v102[v216] = v215[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v104[3];
                                                v214 = 4;
                                            end
                                            if (0 == v214) then
                                                v215 = nil;
                                                v216 = nil;
                                                v216 = v104[2];
                                                v102[v216](v13(v102, v216 + 1, v104[3]));
                                                v214 = 1;
                                            end
                                            if (v214 == 8) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v102[v104[3]];
                                                break
                                            end
                                            if (v214 == 7) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v216 = v104[2];
                                                v102[v216] = v102[v216](v13(v102, v216 + 1, v104[3]));
                                                v214 = 8;
                                            end
                                            if (6 == v214) then
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v214 = 7;
                                            end
                                            if (v214 == 2) then
                                                v104 = v92[v96];
                                                v216 = v104[2];
                                                v215 = v102[v104[3]];
                                                v102[v216 + 1] = v215;
                                                v214 = 3;
                                            end
                                            if (4 == v214) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = {};
                                                v96 = v96 + 1;
                                                v214 = 5;
                                            end
                                            if (v214 == 5) then
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v214 = 6;
                                            end
                                            if (v214 == 1) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v214 = 2;
                                            end
                                        end
                                    end
                                elseif (v105 <= 22) then
                                    if (v105 == 21) then
                                        v102[v104[2]][v104[3]] = v102[v104[4]];
                                    else
                                        local v219 = v104[2];
                                        v102[v219] = v102[v219](v13(v102, v219 + 1, v104[3]));
                                    end
                                elseif (v105 <= 23) then
                                    v59[v104[3]] = v102[v104[2]];
                                elseif (v105 == 24) then
                                    local v465 = 0;
                                    local v466;
                                    local v467;
                                    local v468;
                                    local v469;
                                    local v470;
                                    while true do
                                        if (v465 == 0) then
                                            v466 = nil;
                                            v467, v468 = nil;
                                            v469 = nil;
                                            v470 = nil;
                                            v102[v104[2]] = v60[v104[3]];
                                            v96 = v96 + 1;
                                            v465 = 1;
                                        end
                                        if (v465 == 2) then
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v470 = v104[2];
                                            v467, v468 = v95(v102[v470](v13(v102, v470 + 1, v104[3])));
                                            v465 = 3;
                                        end
                                        if (v465 == 3) then
                                            v97 = (v468 + v470) - 1;
                                            v466 = 0;
                                            for v888 = v470, v97 do
                                                v466 = v466 + 1;
                                                v102[v888] = v467[v466];
                                            end
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v470 = v104[2];
                                            v465 = 4;
                                        end
                                        if (v465 == 1) then
                                            v104 = v92[v96];
                                            v470 = v104[2];
                                            v469 = v102[v104[3]];
                                            v102[v470 + 1] = v469;
                                            v102[v470] = v469[v104[4]];
                                            v96 = v96 + 1;
                                            v465 = 2;
                                        end
                                        if (v465 == 4) then
                                            v102[v470] = v102[v470](v13(v102, v470 + 1, v97));
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v470 = v104[2];
                                            v102[v470] = v102[v470]();
                                            v96 = v96 + 1;
                                            v465 = 5;
                                        end
                                        if (v465 == 5) then
                                            v104 = v92[v96];
                                            v102[v104[2]] = v102[v104[3]];
                                            v96 = v96 + 1;
                                            v104 = v92[v96];
                                            v102[v104[2]] = v104[3];
                                            v96 = v96 + 1;
                                            v465 = 6;
                                        end
                                        if (6 == v465) then
                                            v104 = v92[v96];
                                            v96 = v104[3];
                                            break
                                        end
                                    end
                                else
                                    v102[v104[2]] = v104[3] ~= 0;
                                end
                            elseif (v105 <= 29) then
                                if (v105 <= 27) then
                                    if (v105 == 26) then
                                        local v223;
                                        local v224;
                                        v224 = v104[2];
                                        v102[v224](v13(v102, v224 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v224 = v104[2];
                                        v223 = v102[v104[3]];
                                        v102[v224 + 1] = v223;
                                        v102[v224] = v223[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = {};
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                    else
                                        local v235;
                                        v102[v104[2]] = v60[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v235 = v104[2];
                                        v102[v235](v13(v102, v235 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        do
                                            return;
                                        end
                                    end
                                elseif (v105 > 28) then
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                else
                                    local v244 = v104[2];
                                    v102[v244] = v102[v244]();
                                end
                            elseif (v105 <= 31) then
                                if (v105 > 30) then
                                    local v246;
                                    local v247;
                                    v247 = v104[2];
                                    v246 = v102[v104[3]];
                                    v102[v247 + 1] = v246;
                                    v102[v247] = v246[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v247 = v104[2];
                                    v102[v247] = v102[v247](v13(v102, v247 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v96 = v104[3];
                                else
                                    local v256 = v93[v104[3]];
                                    local v257;
                                    local v258 = {};
                                    v257 = v10({}, {
                                        __index = function(v415, v416)
                                            local v417 = 0;
                                            local v418;
                                            while true do
                                                if (0 == v417) then
                                                    v418 = v258[v416];
                                                    return v418[1][v418[2]];
                                                end
                                            end
                                        end,
                                        __newindex = function(v419, v420, v421)
                                            local v422 = 0;
                                            local v423;
                                            while true do
                                                if (v422 == 0) then
                                                    v423 = v258[v420];
                                                    v423[1][v423[2]] = v421;
                                                    break
                                                end
                                            end
                                        end
                                    });
                                    for v424 = 1, v104[4] do
                                        v96 = v96 + 1;
                                        local v425 = v92[v96];
                                        if (v425[1] == 54) then
                                            v258[v424 - 1] = {v102, v425[3]};
                                        else
                                            v258[v424 - 1] = {v59, v425[3]};
                                        end
                                        v101[#v101 + 1] = v258;
                                    end
                                    v102[v104[2]] = v29(v256, v257, v60);
                                end
                            elseif (v105 <= 32) then
                                v96 = v104[3];
                            elseif (v105 == 33) then
                                local v472;
                                local v473;
                                v473 = v104[2];
                                v472 = v102[v104[3]];
                                v102[v473 + 1] = v472;
                                v102[v473] = v472[v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = {};
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]][v104[3]] = v104[4];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]][v104[3]] = v104[4];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v473 = v104[2];
                                v102[v473](v13(v102, v473 + 1, v104[3]));
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v473 = v104[2];
                                v472 = v102[v104[3]];
                                v102[v473 + 1] = v472;
                                v102[v473] = v472[v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = {};
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]][v104[3]] = v104[4];
                            else
                                local v485;
                                v485 = v104[2];
                                v102[v485] = v102[v485](v13(v102, v485 + 1, v97));
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v485 = v104[2];
                                v102[v485] = v102[v485]();
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v96 = v104[3];
                            end
                        elseif (v105 <= 52) then
                            if (v105 <= 43) then
                                if (v105 <= 38) then
                                    if (v105 <= 36) then
                                        if (v105 > 35) then
                                            local v261 = 0;
                                            local v262;
                                            local v263;
                                            while true do
                                                if (v261 == 0) then
                                                    v262 = v104[3];
                                                    v263 = v102[v262];
                                                    v261 = 1;
                                                end
                                                if (v261 == 1) then
                                                    for v816 = v262 + 1, v104[4] do
                                                        v263 = v263 .. v102[v816];
                                                    end
                                                    v102[v104[2]] = v263;
                                                    break
                                                end
                                            end
                                        else
                                            local v264 = 0;
                                            local v265;
                                            local v266;
                                            while true do
                                                if (v264 == 4) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v266 = v104[2];
                                                    v264 = 5;
                                                end
                                                if (8 == v264) then
                                                    do
                                                        return;
                                                    end
                                                    break
                                                end
                                                if (6 == v264) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v266 = v104[2];
                                                    v264 = 7;
                                                end
                                                if (v264 == 1) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v264 = 2;
                                                end
                                                if (v264 == 3) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v264 = 4;
                                                end
                                                if (0 == v264) then
                                                    v265 = nil;
                                                    v266 = nil;
                                                    v102[v104[2]] = v60[v104[3]];
                                                    v264 = 1;
                                                end
                                                if (v264 == 7) then
                                                    v102[v266](v102[v266 + 1]);
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v264 = 8;
                                                end
                                                if (v264 == 2) then
                                                    v96 = v96 + 1;
                                                    v104 = v92[v96];
                                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                                    v264 = 3;
                                                end
                                                if (v264 == 5) then
                                                    v265 = v102[v104[3]];
                                                    v102[v266 + 1] = v265;
                                                    v102[v266] = v265[v104[4]];
                                                    v264 = 6;
                                                end
                                            end
                                        end
                                    elseif (v105 > 37) then
                                        local v267 = 0;
                                        local v268;
                                        local v269;
                                        local v270;
                                        while true do
                                            if (7 == v267) then
                                                v268 = v102[v269];
                                                for v817 = v269 + 1, v104[4] do
                                                    v268 = v268 .. v102[v817];
                                                end
                                                v102[v104[2]] = v268;
                                                v96 = v96 + 1;
                                                v267 = 8;
                                            end
                                            if (v267 == 4) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]] = v104[3];
                                                v96 = v96 + 1;
                                                v267 = 5;
                                            end
                                            if (v267 == 10) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v270 = v104[2];
                                                v102[v270](v13(v102, v270 + 1, v104[3]));
                                                v267 = 11;
                                            end
                                            if (v267 == 11) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                do
                                                    return;
                                                end
                                                break
                                            end
                                            if (v267 == 3) then
                                                v102[v104[2]] = {};
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v267 = 4;
                                            end
                                            if (v267 == 8) then
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v102[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v267 = 9;
                                            end
                                            if (v267 == 9) then
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v102[v104[2]][v104[3]] = v104[4];
                                                v267 = 10;
                                            end
                                            if (v267 == 5) then
                                                v104 = v92[v96];
                                                v102[v104[2]] = v59[v104[3]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v267 = 6;
                                            end
                                            if (v267 == 1) then
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v270 = v104[2];
                                                v269 = v102[v104[3]];
                                                v267 = 2;
                                            end
                                            if (v267 == 6) then
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v269 = v104[3];
                                                v267 = 7;
                                            end
                                            if (v267 == 0) then
                                                v268 = nil;
                                                v269 = nil;
                                                v270 = nil;
                                                v102[v104[2]] = v59[v104[3]];
                                                v267 = 1;
                                            end
                                            if (v267 == 2) then
                                                v102[v270 + 1] = v269;
                                                v102[v270] = v269[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v267 = 3;
                                            end
                                        end
                                    else
                                        local v271;
                                        local v272;
                                        v272 = v104[2];
                                        v102[v272](v13(v102, v272 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v272 = v104[2];
                                        v271 = v102[v104[3]];
                                        v102[v272 + 1] = v271;
                                        v102[v272] = v271[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = {};
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v272 = v104[2];
                                        v102[v272] = v102[v272](v13(v102, v272 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        for v427 = v104[2], v104[3] do
                                            v102[v427] = nil;
                                        end
                                    end
                                elseif (v105 <= 40) then
                                    if (v105 == 39) then
                                        local v284 = 0;
                                        while true do
                                            if (6 == v284) then
                                                do
                                                    return;
                                                end
                                                break
                                            end
                                            if (v284 == 3) then
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 4;
                                            end
                                            if (v284 == 2) then
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 3;
                                            end
                                            if (v284 == 1) then
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 2;
                                            end
                                            if (v284 == 0) then
                                                v102[v104[2]] = v60[v104[3]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 1;
                                            end
                                            if (v284 == 4) then
                                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 5;
                                            end
                                            if (v284 == 5) then
                                                v102[v104[2]][v104[3]] = v102[v104[4]];
                                                v96 = v96 + 1;
                                                v104 = v92[v96];
                                                v284 = 6;
                                            end
                                        end
                                    else
                                        local v285 = v104[2];
                                        v102[v285] = v102[v285](v13(v102, v285 + 1, v97));
                                    end
                                elseif (v105 <= 41) then
                                    local v287;
                                    local v288;
                                    v288 = v104[2];
                                    v287 = v102[v104[3]];
                                    v102[v288 + 1] = v287;
                                    v102[v288] = v287[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v288 = v104[2];
                                    v102[v288] = v102[v288](v13(v102, v288 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v288 = v104[2];
                                    v287 = v102[v104[3]];
                                    v102[v288 + 1] = v287;
                                    v102[v288] = v287[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3] ~= 0;
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v288 = v104[2];
                                    v102[v288](v13(v102, v288 + 1, v104[3]));
                                elseif (v105 > 42) then
                                    local v492;
                                    local v493, v494;
                                    local v495;
                                    local v496;
                                    v102[v104[2]] = v60[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v496 = v104[2];
                                    v495 = v102[v104[3]];
                                    v102[v496 + 1] = v495;
                                    v102[v496] = v495[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v496 = v104[2];
                                    v493, v494 = v95(v102[v496](v13(v102, v496 + 1, v104[3])));
                                    v97 = (v494 + v496) - 1;
                                    v492 = 0;
                                    for v785 = v496, v97 do
                                        local v786 = 0;
                                        while true do
                                            if (v786 == 0) then
                                                v492 = v492 + 1;
                                                v102[v785] = v493[v492];
                                                break
                                            end
                                        end
                                    end
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v496 = v104[2];
                                    v102[v496] = v102[v496](v13(v102, v496 + 1, v97));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]]();
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v60[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v60[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v496 = v104[2];
                                    v495 = v102[v104[3]];
                                    v102[v496 + 1] = v495;
                                    v102[v496] = v495[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                else
                                    local v506 = 0;
                                    local v507;
                                    local v508;
                                    local v509;
                                    local v510;
                                    while true do
                                        if (0 == v506) then
                                            v507 = v104[2];
                                            v508, v509 = v95(v102[v507](v102[v507 + 1]));
                                            v506 = 1;
                                        end
                                        if (v506 == 1) then
                                            v97 = (v509 + v507) - 1;
                                            v510 = 0;
                                            v506 = 2;
                                        end
                                        if (v506 == 2) then
                                            for v893 = v507, v97 do
                                                local v894 = 0;
                                                while true do
                                                    if (v894 == 0) then
                                                        v510 = v510 + 1;
                                                        v102[v893] = v508[v510];
                                                        break
                                                    end
                                                end
                                            end
                                            break
                                        end
                                    end
                                end
                            elseif (v105 <= 47) then
                                if (v105 <= 45) then
                                    if (v105 > 44) then
                                        local v298;
                                        local v299;
                                        v299 = v104[2];
                                        v298 = v102[v104[3]];
                                        v102[v299 + 1] = v298;
                                        v102[v299] = v298[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v299 = v104[2];
                                        v102[v299] = v102[v299](v13(v102, v299 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v299 = v104[2];
                                        v298 = v102[v104[3]];
                                        v102[v299 + 1] = v298;
                                        v102[v299] = v298[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3] ~= 0;
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v299 = v104[2];
                                        v102[v299](v13(v102, v299 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v96 = v104[3];
                                    else
                                        local v309;
                                        local v310;
                                        local v311;
                                        v311 = v104[3];
                                        v310 = v102[v311];
                                        for v429 = v311 + 1, v104[4] do
                                            v310 = v310 .. v102[v429];
                                        end
                                        v102[v104[2]] = v310;
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v102[v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v60[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v309 = v104[2];
                                        v102[v309] = v102[v309](v13(v102, v309 + 1, v104[3]));
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v102[v104[4]];
                                    end
                                elseif (v105 > 46) then
                                    v102[v104[2]] = v29(v93[v104[3]], nil, v60);
                                else
                                    local v324;
                                    v102[v104[2]][v104[3]] = v104[4];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v324 = v104[2];
                                    v102[v324] = v102[v324](v13(v102, v324 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v102[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                end
                            elseif (v105 <= 49) then
                                if (v105 == 48) then
                                    v102[v104[2]]();
                                else
                                    for v430 = v104[2], v104[3] do
                                        v102[v430] = nil;
                                    end
                                end
                            elseif (v105 <= 50) then
                                v102[v104[2]][v104[3]] = v104[4];
                            elseif (v105 == 51) then
                                if (v104[2] == v102[v104[4]]) then
                                    v96 = v96 + 1;
                                else
                                    v96 = v104[3];
                                end
                            else
                                local v511 = 0;
                                local v512;
                                local v513;
                                while true do
                                    if (v511 == 7) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v511 = 8;
                                    end
                                    if (v511 == 9) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        break
                                    end
                                    if (v511 == 6) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v511 = 7;
                                    end
                                    if (3 == v511) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = {};
                                        v511 = 4;
                                    end
                                    if (v511 == 2) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]] = v104[3];
                                        v511 = 3;
                                    end
                                    if (v511 == 5) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v511 = 6;
                                    end
                                    if (v511 == 8) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v511 = 9;
                                    end
                                    if (v511 == 1) then
                                        v512 = v102[v104[3]];
                                        v102[v513 + 1] = v512;
                                        v102[v513] = v512[v104[4]];
                                        v511 = 2;
                                    end
                                    if (v511 == 4) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v102[v104[2]][v104[3]] = v104[4];
                                        v511 = 5;
                                    end
                                    if (v511 == 0) then
                                        v512 = nil;
                                        v513 = nil;
                                        v513 = v104[2];
                                        v511 = 1;
                                    end
                                end
                            end
                        elseif (v105 <= 61) then
                            if (v105 <= 56) then
                                if (v105 <= 54) then
                                    if (v105 == 53) then
                                        local v336 = 0;
                                        local v337;
                                        local v338;
                                        while true do
                                            if (v336 == 1) then
                                                for v819 = 1, #v101 do
                                                    local v820 = v101[v819];
                                                    for v884 = 0, #v820 do
                                                        local v885 = v820[v884];
                                                        local v886 = v885[1];
                                                        local v887 = v885[2];
                                                        if ((v886 == v102) and (v887 >= v337)) then
                                                            v338[v887] = v886[v887];
                                                            v885[1] = v338;
                                                        end
                                                    end
                                                end
                                                break
                                            end
                                            if (v336 == 0) then
                                                v337 = v104[2];
                                                v338 = {};
                                                v336 = 1;
                                            end
                                        end
                                    else
                                        v102[v104[2]] = v102[v104[3]];
                                    end
                                elseif (v105 == 55) then
                                    local v341;
                                    v102[v104[2]] = v60[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v341 = v104[2];
                                    v102[v341](v13(v102, v341 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    do
                                        return;
                                    end
                                else
                                    local v348 = v104[2];
                                    v102[v348](v13(v102, v348 + 1, v104[3]));
                                end
                            elseif (v105 <= 58) then
                                if (v105 > 57) then
                                    local v349;
                                    v102[v104[2]][v104[3]] = v102[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v349 = v104[2];
                                    v102[v349] = v102[v349](v13(v102, v349 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v96 = v104[3];
                                else
                                    local v358;
                                    local v359;
                                    local v360;
                                    v102[v104[2]] = v59[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v360 = v104[2];
                                    v359 = v102[v104[3]];
                                    v102[v360 + 1] = v359;
                                    v102[v360] = v359[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = {};
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v104[4];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v104[3];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v59[v104[3]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]] = v102[v104[3]][v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v359 = v104[3];
                                    v358 = v102[v359];
                                    for v432 = v359 + 1, v104[4] do
                                        v358 = v358 .. v102[v432];
                                    end
                                    v102[v104[2]] = v358;
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v102[v104[4]];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v104[4];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v102[v104[2]][v104[3]] = v104[4];
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    v360 = v104[2];
                                    v102[v360](v13(v102, v360 + 1, v104[3]));
                                    v96 = v96 + 1;
                                    v104 = v92[v96];
                                    do
                                        return;
                                    end
                                end
                            elseif (v105 <= 59) then
                                local v375;
                                local v376, v377;
                                local v378;
                                local v379;
                                v102[v104[2]] = v60[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v379 = v104[2];
                                v378 = v102[v104[3]];
                                v102[v379 + 1] = v378;
                                v102[v379] = v378[v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v379 = v104[2];
                                v376, v377 = v95(v102[v379](v13(v102, v379 + 1, v104[3])));
                                v97 = (v377 + v379) - 1;
                                v375 = 0;
                                for v433 = v379, v97 do
                                    local v434 = 0;
                                    while true do
                                        if (v434 == 0) then
                                            v375 = v375 + 1;
                                            v102[v433] = v376[v375];
                                            break
                                        end
                                    end
                                end
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v379 = v104[2];
                                v102[v379] = v102[v379](v13(v102, v379 + 1, v97));
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v379 = v104[2];
                                v102[v379] = v102[v379]();
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v379 = v104[2];
                                v378 = v102[v104[3]];
                                v102[v379 + 1] = v378;
                                v102[v379] = v378[v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = {};
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                            elseif (v105 > 60) then
                                local v514;
                                v102[v104[2]] = v60[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]][v104[4]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v514 = v104[2];
                                v102[v514] = v102[v514](v13(v102, v514 + 1, v104[3]));
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v102[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v60[v104[3]];
                                v96 = v96 + 1;
                                v104 = v92[v96];
                                v102[v104[2]] = v104[3];
                            elseif not v102[v104[2]] then
                                v96 = v96 + 1;
                            else
                                v96 = v104[3];
                            end
                        elseif (v105 <= 65) then
                            if (v105 <= 63) then
                                if (v105 == 62) then
                                    v102[v104[2]] = {};
                                else
                                    local v390 = v104[2];
                                    local v391 = v102[v104[3]];
                                    v102[v390 + 1] = v391;
                                    v102[v390] = v391[v104[4]];
                                end
                            elseif (v105 == 64) then
                                v102[v104[2]] = v60[v104[3]];
                            else
                                local v397 = 0;
                                local v398;
                                local v399;
                                local v400;
                                local v401;
                                local v402;
                                while true do
                                    if (v397 == 4) then
                                        v104 = v92[v96];
                                        v402 = v104[2];
                                        v398, v400 = v95(v102[v402](v102[v402 + 1]));
                                        v97 = (v400 + v402) - 1;
                                        v397 = 5;
                                    end
                                    if (v397 == 5) then
                                        v399 = 0;
                                        for v824 = v402, v97 do
                                            v399 = v399 + 1;
                                            v102[v824] = v398[v399];
                                        end
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v397 = 6;
                                    end
                                    if (1 == v397) then
                                        v402 = nil;
                                        v102[v104[2]] = v60[v104[3]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v397 = 2;
                                    end
                                    if (v397 == 0) then
                                        v398 = nil;
                                        v399 = nil;
                                        v398, v400 = nil;
                                        v401 = nil;
                                        v397 = 1;
                                    end
                                    if (v397 == 2) then
                                        v102[v104[2]] = v102[v104[3]][v104[4]];
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v402 = v104[2];
                                        v397 = 3;
                                    end
                                    if (v397 == 7) then
                                        v96 = v96 + 1;
                                        v104 = v92[v96];
                                        v96 = v104[3];
                                        break
                                    end
                                    if (v397 == 3) then
                                        v401 = v102[v104[3]];
                                        v102[v402 + 1] = v401;
                                        v102[v402] = v401[v104[4]];
                                        v96 = v96 + 1;
                                        v397 = 4;
                                    end
                                    if (6 == v397) then
                                        v402 = v104[2];
                                        v398 = {v102[v402](v13(v102, v402 + 1, v97))};
                                        v399 = 0;
                                        for v827 = v402, v104[4] do
                                            v399 = v399 + 1;
                                            v102[v827] = v398[v399];
                                        end
                                        v397 = 7;
                                    end
                                end
                            end
                        elseif (v105 <= 67) then
                            if (v105 > 66) then
                                local v403 = 0;
                                local v404;
                                while true do
                                    if (v403 == 0) then
                                        v404 = v104[2];
                                        v102[v404](v102[v404 + 1]);
                                        break
                                    end
                                end
                            else
                                local v405 = v104[2];
                                local v406, v407 = v95(v102[v405](v13(v102, v405 + 1, v104[3])));
                                v97 = (v407 + v405) - 1;
                                local v408 = 0;
                                for v435 = v405, v97 do
                                    v408 = v408 + 1;
                                    v102[v435] = v406[v408];
                                end
                            end
                        elseif (v105 <= 68) then
                            local v409 = v104[2];
                            local v410 = {v102[v409](v13(v102, v409 + 1, v97))};
                            local v411 = 0;
                            for v438 = v409, v104[4] do
                                v411 = v411 + 1;
                                v102[v438] = v410[v411];
                            end
                        elseif (v105 > 69) then
                            local v523 = v104[2];
                            local v524 = v104[4];
                            local v525 = v523 + 2;
                            local v526 = {v102[v523](v102[v523 + 1], v102[v525])};
                            for v806 = 1, v524 do
                                v102[v525 + v806] = v526[v806];
                            end
                            local v527 = v526[1];
                            if v527 then
                                v102[v525] = v527;
                                v96 = v104[3];
                            else
                                v96 = v96 + 1;
                            end
                        else
                            local v528;
                            local v529;
                            v102[v104[2]] = v104[3];
                            v96 = v96 + 1;
                            v104 = v92[v96];
                            v529 = v104[2];
                            v102[v529](v13(v102, v529 + 1, v104[3]));
                            v96 = v96 + 1;
                            v104 = v92[v96];
                            v529 = v104[2];
                            v528 = v102[v104[3]];
                            v102[v529 + 1] = v528;
                            v102[v529] = v528[v104[4]];
                            v96 = v96 + 1;
                            v104 = v92[v96];
                            v102[v104[2]] = v102[v104[3]][v104[4]];
                            v96 = v96 + 1;
                            v104 = v92[v96];
                            v529 = v104[2];
                            v102[v529](v13(v102, v529 + 1, v104[3]));
                            v96 = v96 + 1;
                            v104 = v92[v96];
                            v102[v104[2]] = v104[3];
                        end
                        v96 = v96 + 1;
                    end
                end;
            end
            if (v61 == 0) then
                v62 = v58[1];
                v63 = v58[2];
                v61 = 1;
            end
        end
    end
    return v29(v28(), {}, v17)(...);
end
return v15(
    "LOL!6C3O00028O00026O00F03F027O0040026O000840026O001040030A3O005365744C69627261727903093O004F6E4368616E67656403043O004D61696E03093O00412O64546F2O676C6503073O00496E664A756D7003053O005469746C6503083O00496E66204A756D7003073O0044656661756C740100026O00144003093O00412O64536C69646572030A3O004A756D70536C69646572030C3O004A756D70204368616E676572030B3O004465736372697074696F6E03283O0041646A75737420746865206A756D7020706F776572207573696E67207468697320736C696465722E026O0049402O033O004D696E2O033O004D6178025O00E0854003083O00526F756E64696E6703083O0043612O6C6261636B03093O00412O6442752O746F6E030F3O0042726572616B2056656C6F63697479033D3O00546869732062752O746F6E206973207665727920696D706F7274616E7420617320697420612O6C6F777320627265616B696E672076656C6F636974792E03073O004F6E436C69636B030A3O00412O644B657962696E6403073O004B657962696E64030A3O00466972652050756E636803043O004D6F646503063O00546F2O676C6503013O005203043O0054656C6503083O00496E662054656C65026O001840030F3O0052657365742043686172616374657203293O005265736574207468652063686172616374657220746F206974732064656661756C742073746174652E03053O004D6574616C03013O005403073O0067657473656E7603043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403113O0074656C656B696E65736973436C69656E74030C3O00412O64506172616772617068030A3O00446973636C61696D657203073O00436F6E74656E7403493O00546869732073637269707420697320612070617274206F6620746865206D61696E20686561646C652O7320736372697074206D616465206279205F2E616D616E6B6F757368616C2E5F030B3O0053702O6564536C69646572030D3O0053702O6564204368616E67657203343O0041646A757374207468652073702O6564206F662074686520636861726163746572207573696E67207468697320736C696465722E026O003040025O00409F40030D3O00627265616B76656C6F6369747903063O00412O6454616203043O0049636F6E03063O0073776F72647303083O0053652O74696E677303083O0073652O74696E677303073O004F7074696F6E7303093O00536574466F6C646572031D3O00466C75656E745363726970744875622F73706563696669632D67616D6503153O004275696C64496E7465726661636553656374696F6E03123O004275696C64436F6E66696753656374696F6E03093O0053656C65637454616203063O004E6F7469667903083O00486561646C652O73031B3O00546865207363726970742068617320622O656E206C6F616465642E03083O004475726174696F6E026O00204003123O004C6F61644175746F6C6F6164436F6E66696703133O0049676E6F72655468656D6553652O74696E677303103O0053657449676E6F7265496E6465786573030F3O00466C75656E74536372697074487562030A3O006C6F6164737472696E6703073O00482O747047657403593O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F64617769642D736372697074732F466C75656E742F6D61737465722F412O646F6E732F496E746572666163654D616E616765722E6C7561030C3O0043726561746557696E646F77031F3O00486561646C652O73202D20507650204D6F64696669636174696F6E73202D2003073O0056657273696F6E03083O005375625469746C6503123O006279205F2E616D616E6B6F757368616C2E5F03083O005461625769647468026O00644003043O0053697A6503053O005544696D32030A3O0066726F6D4F2O66736574025O00208240025O00C0724003073O00416372796C69632O0103053O005468656D6503043O004461726B030B3O004D696E696D697A654B657903043O00456E756D03073O004B6579436F64652O033O00456E64030A3O004765745365727669636503103O0055736572496E7075745365727669636503543O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F64617769642D736372697074732F466C75656E742F6D61737465722F412O646F6E732F536176654D616E616765722E6C756103463O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F49747A416D616E4B6F757368616C2F4E797875732F6D61696E2F7076702F69642E6C756103493O00682O7470733A2O2F6769746875622E636F6D2F64617769642D736372697074732F466C75656E742F72656C65617365732F6C61746573742F646F776E6C6F61642F6D61696E2E6C75610088012O0012013O00014O0031000100083O0026063O0006000100020004203O000600012O0031000300043O0012013O00033O0026063O000B000100010004203O000B0001001201000100014O0031000200023O0012013O00023O0026063O000F000100040004203O000F00012O0031000700083O0012013O00053O0026063O0013000100030004203O001300012O0031000500063O0012013O00043O0026063O0002000100050004203O00020001002606000100EA000100040004203O00EA0001001201000900013O0026060009001F000100020004203O001F000100203F000A000400062O0036000C00024O0038000A000C0001001201000100053O0004203O00EA000100260600090018000100010004203O00180001001201000A00014O0031000B00143O002606000A0028000100010004203O00280001001201000B00014O0031000C000D3O001201000A00023O002606000A002C000100030004203O002C00012O0031001100133O001201000A00043O002606000A0030000100020004203O003000012O0031000E00103O001201000A00033O002606000A0023000100040004203O002300012O0031001400143O002606000B0044000100050004203O0044000100203F0015000F000700061E00173O000100022O00363O00024O00363O000F4O002500150017000100202O00150007000800202O00150015000900122O0017000A6O00183O000200302O0018000B000C00302O0018000D000E4O0015001800024O001000156O001100113O001201000B000F3O002606000B0060000100020004203O0060000100201D00150007000800203400150015001000122O001700116O00183O000700302O0018000B001200302O00180013001400302O0018000D001500302O00180016000200302O00180017001800302O00180019000200022F001900013O0010150018001A00192O00160015001800022O0036000D00153O00203F0015000D000700022F001700024O001A00150017000100202O00150007000800202O00150015001B4O00173O000300302O0017000B001C00302O00170013001D00022F001800033O0010150017001A00182O0038001500170001001201000B00033O002606000B007C000100040004203O007C0001001201001500013O0026060015006A000100020004203O006A000100203F0016000F001E00022F001800044O0038001600180001001201000B00053O0004203O007C0001000E3300010063000100150004203O0063000100203F0016000E000700061E00180005000100022O00363O00024O00363O000E4O001400160018000100202O00160007000800202O00160016001F00122O001800206O00193O000300302O0019000B002100302O00190022002300302O0019000D00244O0016001900024O000F00163O001201001500023O0004203O00630001002606000B00960001000F0004203O00960001001201001500013O0026060015008B000100020004203O008B000100201D00160007000800201100160016000900122O001800256O00193O000200302O0019000B002600302O0019000D000E4O0016001900024O001300163O00122O000B00273O00044O009600010026060015007F000100010004203O007F00012O001900125O00203F00160010000700061E00180006000100032O00363O00124O00363O00114O00363O00064O0038001600180001001201001500023O0004203O007F0001002606000B00AE000100030004203O00AE000100201D00150007000800203F00150015001B2O003E00173O00030030320017000B002800303200170013002900061E00180007000100012O00363O00053O00102O0017001A00184O00150017000100202O00150007000800202O00150015001F00122O001700206O00183O000300302O0018000B002A00302O00180022002300302O0018000D002B4O0015001800022O0036000E00153O00203F0015000E001E00022F001700084O0038001500170001001201000B00043O002606000B00BF000100270004203O00BF00010012400015002C3O0012080016002D3O00202O00160016002E00202O00160016002F00202O00160016003000202O00160016003100122O001800326O001600186O00153O00024O001400153O00202O00150013000700061E00170009000100012O00363O00144O00380015001700010004203O00E40001002606000B0033000100010004203O00330001001201001500013O000E33000200C9000100150004203O00C9000100203F0016000C000700022F0018000A4O0038001600180001001201000B00023O0004203O00330001002606001500C2000100010004203O00C2000100201D0016000700080020210016001600334O00183O000200302O0018000B003400302O0018003500364O00160018000100202O00160007000800202O00160016001000122O001800376O00193O000700302O0019000B00380030320019001300390030320019000D003A00303200190016000200303200190017003B00303200190019000200022F001A000B3O00103A0019001A001A4O0016001900024O000C00163O00122O001500023O00044O00C200010004203O003300010004203O00E400010004203O002300012O0035000A5O00200F000A000300064O000C00026O000A000C000100122O000900023O00044O00180001002606000100062O0100030004203O00062O01001201000900013O00260600092O002O0100010004204O002O0100022F000A000C3O001209000A003C6O000A3O000200202O000B0005003D4O000D3O000200302O000D000B000800302O000D003E003F4O000B000D000200102O000A0008000B00202O000B0005003D4O000D3O0002003032000D000B004000302E000D003E00414O000B000D000200102O000A0040000B4O0007000A3O00122O000900023O002606000900ED000100020004203O00ED000100201D000800020042001201000100043O0004203O00062O010004203O00ED00010026060001001A2O01000F0004203O001A2O01001201000900013O002606000900122O0100010004203O00122O0100203F000A00030043001245000C00446O000A000C000100202O000A0004004500202O000C000700404O000A000C000100122O000900023O002606000900092O0100020004203O00092O0100203F000A0003004600201D000C000700402O0038000A000C0001001201000100273O0004203O001A2O010004203O00092O01002606000100282O0100270004203O00282O0100203F00090005004700120C000B00026O0009000B000100202O0009000200484O000B3O000300302O000B000B004900302O000B0035004A00302O000B004B004C4O0009000B000100202O00090003004D4O0009000200010004203O00862O01002606000100332O0100050004203O00332O0100203F00090003004E2O000700090002000100202O00090003004F4O000B8O0009000B000100202O00090004004300122O000B00506O0009000B000100122O0001000F3O002606000100612O0100020004203O00612O01001201000900013O002606000900572O0100010004203O00572O01001240000A00513O00123B000B002D3O00202O000B000B005200122O000D00536O000B000D6O000A3O00024O000A000100024O0004000A3O00202O000A000200544O000C3O000700122O000D00553O00201D000E000200562O002C000D000D000E00102O000C000B000D00302O000C0057005800302O000C0059005A00122O000D005C3O00202O000D000D005D00122O000E005E3O00122O000F005F6O000D000F000200102O000C005B000D003032000C00600061003010000C0062006300122O000D00653O00202O000D000D006600202O000D000D006700102O000C0064000D4O000A000C00024O0005000A3O00122O000900023O002606000900362O0100020004203O00362O01001240000A002D3O00201F000A000A006800122O000C00696O000A000C00024O0006000A3O00122O000100033O00044O00612O010004203O00362O0100260600010015000100010004203O00150001001201000900013O002606000900702O0100020004203O00702O01001240000A00513O001218000B002D3O00202O000B000B005200122O000D006A6O000B000D6O000A3O00024O000A000100024O0003000A3O00122O000100023O00044O00150001002606000900642O0100010004203O00642O01001240000A00513O00122B000B002D3O00202O000B000B005200122O000D006B6O000B000D6O000A3O00024O000A0001000100122O000A00513O00122O000B002D3O00202O000B000B005200122O000D006C4O0042000B000D4O0022000A3O00024O000A000100024O0002000A3O00122O000900023O00044O00642O010004203O001500010004203O00862O010004203O000200012O00358O000A3O00013O000D3O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E7403313O00546865206B657962696E64696E67206F6620666972652070756E63682068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00397O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001237000100013O00122O000200026O00038O0001000300016O00017O00063O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O004A756D70506F77657201073O001213000100013O00202O00010001000200202O00010001000300202O00010001000400202O00010001000500102O000100068O00017O00013O00030D3O00627265616B76656C6F6369747900033O0012403O00014O00303O000100012O000A3O00017O00093O0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303053O0050756E6368030A3O0046697265536572766572028O00029A5O99B93F026O00F03F000C3O0012043O00013O00206O000200122O000200038O0002000200206O000400206O000500206O000600122O000200073O00122O000300083O00122O000400098O000400016O00017O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E7403303O00546865206B657962696E64696E67206F66206D6574616C736B696E2068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00397O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00017O00043O00028O00030B3O004A756D705265717565737403073O00436F2O6E656374030A3O00446973636F2O6E65637401183O00060D3O001100013O0004203O00110001001201000100013O00260600010003000100010004203O000300012O001900026O001700026O0003000200023O00201D00020002000200203F00020002000300061E00043O000100012O00038O00160002000400022O0017000200013O0004203O001700010004203O000300010004203O001700012O0003000100013O00060D0001001700013O0004203O001700012O0003000100013O00203F0001000100042O00430001000200012O000A3O00013O00013O000D3O00028O00026O00F03F03043O007761697403043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203163O0046696E6446697273744368696C64576869636849734103083O0048756D616E6F6964030B3O004368616E6765537461746503043O00456E756D03113O0048756D616E6F696453746174655479706503073O004A756D70696E67002C4O00037O00063C3O002B000100010004203O002B00010012013O00014O0031000100013O0026063O0005000100010004203O00050001001201000100013O000E330002000F000100010004203O000F0001001240000200034O00300002000100012O001900026O001700025O0004203O002B000100260600010008000100010004203O00080001001201000200013O000E3300010023000100020004203O002300012O0019000300014O000500035O00122O000300043O00202O00030003000500202O00030003000600202O00030003000700202O00030003000800122O000500096O00030005000200202O00030003000A00122O0005000B3O00202O00050005000C00202O00050005000D4O00030005000100122O000200023O000E3300020012000100020004203O00120001001201000100023O0004203O000800010004203O001200010004203O000800010004203O002B00010004203O000500012O000A3O00017O00093O0003063O004469616C6F6703053O005469746C65030F3O0052657365742043686172616374657203073O00436F6E74656E74032D3O0041726520796F75207375726520796F752077616E7420746F20726573657420746865206368617261637465723F03073O0042752O746F6E7303073O00436F6E6669726D03083O0043612O6C6261636B03063O0043616E63656C00124O000E7O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700022F00055O0010150004000800052O003E00053O000200303200050002000900022F000600013O0010150005000800062O000B0003000200010010150002000600032O00383O000200012O000A3O00013O00023O00053O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030B3O00427265616B4A6F696E747300073O0012233O00013O00206O000200206O000300206O000400206O00056O000200016O00017O00023O0003053O007072696E7403153O0043616E63652O6C656420746865206469616C6F672E00043O0012403O00013O001201000100024O00433O000200012O000A3O00017O00073O0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303093O005472616E73666F726D030A3O004669726553657276657203093O006D6574616C536B696E01183O00060D3O000D00013O0004203O000D0001001240000100013O00202D00010001000200122O000300036O00010003000200202O00010001000400202O00010001000500202O00010001000600122O000300076O000400016O00010004000100044O00170001001240000100013O00202900010001000200122O000300036O00010003000200202O00010001000400202O00010001000500202O00010001000600122O000300076O00048O0001000400012O000A3O00017O00033O0003083O00632O6F6C446F776E028O00026O00144001083O00060D3O000500013O0004203O000500012O000300015O0030320001000100020004203O000700012O000300015O0030320001000100032O000A3O00017O00063O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O0057616C6B53702O656401073O001213000100013O00202O00010001000200202O00010001000300202O00010001000400202O00010001000500102O000100068O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001237000100013O00122O000200026O00038O0001000300016O00017O00013O0003053O00737061776E00043O0012403O00013O00022F00016O00433O000200012O000A3O00013O00013O000E3O00028O00026O00F03F03063O0069706169727303063O00706C6179657203093O00436861726163746572030E3O0047657444657363656E64616E74732O033O0049734103083O00426173655061727403083O0056656C6F63697479030B3O00526F7456656C6F6369747903043O007761697403073O00566563746F72332O033O006E657703053O0064656C6179003A3O0012013O00014O0031000100023O0026063O0027000100020004203O0027000100063C00010039000100010004203O00390001001201000300014O0031000400043O00260600030008000100010004203O00080001001201000400013O0026060004000B000100010004203O000B0001001240000500033O001241000600043O00202O00060006000500202O0006000600064O000600076O00053O000700044O001D000100201D000A000900072O0036000B00093O001201000C00084O0016000A000C000200060D000A001D00013O0004203O001D00012O0036000A00023O0010150009000A000200101500090009000A00064600050014000100020004203O001400010012400005000B4O00300005000100010004203O000400010004203O000B00010004203O000400010004203O000800010004203O000400010004203O003900010026063O0002000100010004203O000200012O001900035O00123D0004000C3O00202O00040004000D00122O000500013O00122O000600013O00122O000700016O0004000700024O000200046O000100033O00122O0003000E3O00122O000400023O00061E00053O000100012O00363O00014O00380003000500010012013O00023O0004203O000200012O000A3O00013O00018O00034O00193O00014O00178O000A3O00017O00",
    v9(), ...);
