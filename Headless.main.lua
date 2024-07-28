--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.6) ~  Much Love, Ferib 

]]--

local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 5), "..", function(byte)
		if (Byte(byte, 2) == 79) then
			local FlatIdent_76979 = 0;
			while true do
				if (FlatIdent_76979 == 0) then
					repeatNext = StrToNumber(Sub(byte, 1, 1));
					return "";
				end
			end
		else
			local FlatIdent_69270 = 0;
			local a;
			while true do
				if (FlatIdent_69270 == 0) then
					a = Char(StrToNumber(byte, 16));
					if repeatNext then
						local b = Rep(a, repeatNext);
						repeatNext = nil;
						return b;
					else
						return a;
					end
					break;
				end
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
			return Res - (Res % 1);
		else
			local Plc = 2 ^ (Start - 1);
			return (((Bit % (Plc + Plc)) >= Plc) and 1) or 0;
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + 1;
		return a;
	end
	local function gBits16()
		local a, b = Byte(ByteString, DIP, DIP + 2);
		DIP = DIP + 2;
		return (b * 256) + a;
	end
	local function gBits32()
		local FlatIdent_6D4CB = 0;
		local a;
		local b;
		local c;
		local d;
		while true do
			if (FlatIdent_6D4CB == 1) then
				return (d * 16777216) + (c * 65536) + (b * 256) + a;
			end
			if (FlatIdent_6D4CB == 0) then
				a, b, c, d = Byte(ByteString, DIP, DIP + 3);
				DIP = DIP + 4;
				FlatIdent_6D4CB = 1;
			end
		end
	end
	local function gFloat()
		local FlatIdent_12703 = 0;
		local Left;
		local Right;
		local IsNormal;
		local Mantissa;
		local Exponent;
		local Sign;
		while true do
			if (FlatIdent_12703 == 0) then
				Left = gBits32();
				Right = gBits32();
				FlatIdent_12703 = 1;
			end
			if (FlatIdent_12703 == 3) then
				if (Exponent == 0) then
					if (Mantissa == 0) then
						return Sign * 0;
					else
						Exponent = 1;
						IsNormal = 0;
					end
				elseif (Exponent == 2047) then
					return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
				end
				return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
			end
			if (FlatIdent_12703 == 2) then
				Exponent = gBit(Right, 21, 31);
				Sign = ((gBit(Right, 32) == 1) and -1) or 1;
				FlatIdent_12703 = 3;
			end
			if (FlatIdent_12703 == 1) then
				IsNormal = 1;
				Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
				FlatIdent_12703 = 2;
			end
		end
	end
	local function gString(Len)
		local Str;
		if not Len then
			local FlatIdent_25011 = 0;
			while true do
				if (FlatIdent_25011 == 0) then
					Len = gBits32();
					if (Len == 0) then
						return "";
					end
					break;
				end
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local Instrs = {};
		local Functions = {};
		local Lines = {};
		local Chunk = {Instrs,Functions,nil,Lines};
		local ConstCount = gBits32();
		local Consts = {};
		for Idx = 1, ConstCount do
			local Type = gBits8();
			local Cons;
			if (Type == 1) then
				Cons = gBits8() ~= 0;
			elseif (Type == 2) then
				Cons = gFloat();
			elseif (Type == 3) then
				Cons = gString();
			end
			Consts[Idx] = Cons;
		end
		Chunk[3] = gBits8();
		for Idx = 1, gBits32() do
			local FlatIdent_7DD24 = 0;
			local Descriptor;
			while true do
				if (FlatIdent_7DD24 == 0) then
					Descriptor = gBits8();
					if (gBit(Descriptor, 1, 1) == 0) then
						local FlatIdent_781F8 = 0;
						local Type;
						local Mask;
						local Inst;
						while true do
							if (FlatIdent_781F8 == 3) then
								if (gBit(Mask, 3, 3) == 1) then
									Inst[4] = Consts[Inst[4]];
								end
								Instrs[Idx] = Inst;
								break;
							end
							if (1 == FlatIdent_781F8) then
								Inst = {gBits16(),gBits16(),nil,nil};
								if (Type == 0) then
									Inst[3] = gBits16();
									Inst[4] = gBits16();
								elseif (Type == 1) then
									Inst[3] = gBits32();
								elseif (Type == 2) then
									Inst[3] = gBits32() - (2 ^ 16);
								elseif (Type == 3) then
									Inst[3] = gBits32() - (2 ^ 16);
									Inst[4] = gBits16();
								end
								FlatIdent_781F8 = 2;
							end
							if (2 == FlatIdent_781F8) then
								if (gBit(Mask, 1, 1) == 1) then
									Inst[2] = Consts[Inst[2]];
								end
								if (gBit(Mask, 2, 2) == 1) then
									Inst[3] = Consts[Inst[3]];
								end
								FlatIdent_781F8 = 3;
							end
							if (FlatIdent_781F8 == 0) then
								Type = gBit(Descriptor, 2, 3);
								Mask = gBit(Descriptor, 4, 6);
								FlatIdent_781F8 = 1;
							end
						end
					end
					break;
				end
			end
		end
		for Idx = 1, gBits32() do
			Functions[Idx - 1] = Deserialize();
		end
		return Chunk;
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[2];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -1;
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - 1;
			local Lupvals = {};
			local Stk = {};
			for Idx = 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + 1];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				Inst = Instr[VIP];
				Enum = Inst[1];
				if (Enum <= 86) then
					if (Enum <= 42) then
						if (Enum <= 20) then
							if (Enum <= 9) then
								if (Enum <= 4) then
									if (Enum <= 1) then
										if (Enum == 0) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Upvalues[Inst[3]] = Stk[Inst[2]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										else
											local FlatIdent_455BF = 0;
											while true do
												if (FlatIdent_455BF == 2) then
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_455BF = 3;
												end
												if (FlatIdent_455BF == 0) then
													Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_455BF = 1;
												end
												if (FlatIdent_455BF == 5) then
													VIP = Inst[3];
													break;
												end
												if (FlatIdent_455BF == 4) then
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_455BF = 5;
												end
												if (FlatIdent_455BF == 3) then
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_455BF = 4;
												end
												if (FlatIdent_455BF == 1) then
													Stk[Inst[2]] = Env[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_455BF = 2;
												end
											end
										end
									elseif (Enum <= 2) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									elseif (Enum > 3) then
										local FlatIdent_1B1BA = 0;
										local A;
										while true do
											if (6 == FlatIdent_1B1BA) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_1B1BA = 7;
											end
											if (FlatIdent_1B1BA == 15) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												break;
											end
											if (FlatIdent_1B1BA == 11) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 12;
											end
											if (FlatIdent_1B1BA == 9) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 10;
											end
											if (FlatIdent_1B1BA == 4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_1B1BA = 5;
											end
											if (FlatIdent_1B1BA == 14) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												FlatIdent_1B1BA = 15;
											end
											if (FlatIdent_1B1BA == 10) then
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 11;
											end
											if (8 == FlatIdent_1B1BA) then
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 9;
											end
											if (FlatIdent_1B1BA == 0) then
												A = nil;
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_1B1BA = 1;
											end
											if (FlatIdent_1B1BA == 2) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_1B1BA = 3;
											end
											if (FlatIdent_1B1BA == 13) then
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												FlatIdent_1B1BA = 14;
											end
											if (FlatIdent_1B1BA == 5) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_1B1BA = 6;
											end
											if (FlatIdent_1B1BA == 7) then
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 8;
											end
											if (FlatIdent_1B1BA == 12) then
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_1B1BA = 13;
											end
											if (FlatIdent_1B1BA == 3) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												FlatIdent_1B1BA = 4;
											end
											if (FlatIdent_1B1BA == 1) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_1B1BA = 2;
											end
										end
									else
										local FlatIdent_6C033 = 0;
										local B;
										local A;
										while true do
											if (FlatIdent_6C033 == 7) then
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Inst[4]];
												break;
											end
											if (6 == FlatIdent_6C033) then
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_6C033 = 7;
											end
											if (4 == FlatIdent_6C033) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												FlatIdent_6C033 = 5;
											end
											if (FlatIdent_6C033 == 3) then
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = {};
												VIP = VIP + 1;
												FlatIdent_6C033 = 4;
											end
											if (FlatIdent_6C033 == 2) then
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_6C033 = 3;
											end
											if (FlatIdent_6C033 == 0) then
												B = nil;
												A = nil;
												A = Inst[2];
												Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												FlatIdent_6C033 = 1;
											end
											if (FlatIdent_6C033 == 1) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_6C033 = 2;
											end
											if (FlatIdent_6C033 == 5) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_6C033 = 6;
											end
										end
									end
								elseif (Enum <= 6) then
									if (Enum == 5) then
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
									else
										local B;
										local A;
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
									end
								elseif (Enum <= 7) then
									local A;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								elseif (Enum == 8) then
									Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];
								else
									local B;
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
								end
							elseif (Enum <= 14) then
								if (Enum <= 11) then
									if (Enum > 10) then
										if (Stk[Inst[2]] == Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local FlatIdent_2BE02 = 0;
										while true do
											if (FlatIdent_2BE02 == 3) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_2BE02 = 4;
											end
											if (FlatIdent_2BE02 == 2) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_2BE02 = 3;
											end
											if (FlatIdent_2BE02 == 4) then
												if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
													VIP = VIP + 1;
												else
													VIP = Inst[3];
												end
												break;
											end
											if (FlatIdent_2BE02 == 1) then
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_2BE02 = 2;
											end
											if (0 == FlatIdent_2BE02) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_2BE02 = 1;
											end
										end
									end
								elseif (Enum <= 12) then
									Stk[Inst[2]] = {};
								elseif (Enum == 13) then
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
								else
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 17) then
								if (Enum <= 15) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 16) then
									local FlatIdent_21449 = 0;
									local A;
									while true do
										if (FlatIdent_21449 == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_21449 = 5;
										end
										if (FlatIdent_21449 == 11) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 12;
										end
										if (FlatIdent_21449 == 0) then
											A = nil;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_21449 = 1;
										end
										if (FlatIdent_21449 == 10) then
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 11;
										end
										if (FlatIdent_21449 == 6) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_21449 = 7;
										end
										if (FlatIdent_21449 == 16) then
											Inst = Instr[VIP];
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_21449 == 13) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_21449 = 14;
										end
										if (FlatIdent_21449 == 1) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_21449 = 2;
										end
										if (FlatIdent_21449 == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											FlatIdent_21449 = 3;
										end
										if (FlatIdent_21449 == 8) then
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 9;
										end
										if (FlatIdent_21449 == 12) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 13;
										end
										if (FlatIdent_21449 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_21449 = 6;
										end
										if (FlatIdent_21449 == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											FlatIdent_21449 = 4;
										end
										if (FlatIdent_21449 == 14) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											FlatIdent_21449 = 15;
										end
										if (FlatIdent_21449 == 9) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 10;
										end
										if (FlatIdent_21449 == 15) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_21449 = 16;
										end
										if (FlatIdent_21449 == 7) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_21449 = 8;
										end
									end
								else
									Stk[Inst[2]]();
								end
							elseif (Enum <= 18) then
								local FlatIdent_69C4C = 0;
								local A;
								local Results;
								local Limit;
								local Edx;
								while true do
									if (1 == FlatIdent_69C4C) then
										Top = (Limit + A) - 1;
										Edx = 0;
										FlatIdent_69C4C = 2;
									end
									if (FlatIdent_69C4C == 0) then
										A = Inst[2];
										Results, Limit = _R(Stk[A]());
										FlatIdent_69C4C = 1;
									end
									if (2 == FlatIdent_69C4C) then
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										break;
									end
								end
							elseif (Enum == 19) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								Stk[Inst[2]] = Wrap(Proto[Inst[3]], nil, Env);
							end
						elseif (Enum <= 31) then
							if (Enum <= 25) then
								if (Enum <= 22) then
									if (Enum == 21) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										do
											return;
										end
									elseif not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum <= 23) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								elseif (Enum == 24) then
									local B;
									local A;
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 28) then
								if (Enum <= 26) then
									local FlatIdent_83844 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_83844 == 4) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_83844 = 5;
										end
										if (FlatIdent_83844 == 0) then
											B = nil;
											A = nil;
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_83844 = 1;
										end
										if (FlatIdent_83844 == 6) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											break;
										end
										if (FlatIdent_83844 == 2) then
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_83844 = 3;
										end
										if (1 == FlatIdent_83844) then
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											FlatIdent_83844 = 2;
										end
										if (FlatIdent_83844 == 3) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_83844 = 4;
										end
										if (FlatIdent_83844 == 5) then
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_83844 = 6;
										end
									end
								elseif (Enum > 27) then
									local FlatIdent_4E551 = 0;
									local A;
									local T;
									while true do
										if (FlatIdent_4E551 == 0) then
											A = Inst[2];
											T = Stk[A];
											FlatIdent_4E551 = 1;
										end
										if (FlatIdent_4E551 == 1) then
											for Idx = A + 1, Inst[3] do
												Insert(T, Stk[Idx]);
											end
											break;
										end
									end
								else
									local A = Inst[2];
									local Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									local Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								end
							elseif (Enum <= 29) then
								local FlatIdent_7517F = 0;
								local A;
								local Results;
								local Limit;
								local Edx;
								while true do
									if (2 == FlatIdent_7517F) then
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										break;
									end
									if (0 == FlatIdent_7517F) then
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										FlatIdent_7517F = 1;
									end
									if (FlatIdent_7517F == 1) then
										Top = (Limit + A) - 1;
										Edx = 0;
										FlatIdent_7517F = 2;
									end
								end
							elseif (Enum == 30) then
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local FlatIdent_10DED = 0;
								local Results;
								local Edx;
								local Limit;
								local B;
								local A;
								while true do
									if (FlatIdent_10DED == 3) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										FlatIdent_10DED = 4;
									end
									if (FlatIdent_10DED == 6) then
										Edx = 0;
										for Idx = A, Inst[4] do
											local FlatIdent_163A8 = 0;
											while true do
												if (FlatIdent_163A8 == 0) then
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
													break;
												end
											end
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (FlatIdent_10DED == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										FlatIdent_10DED = 2;
									end
									if (FlatIdent_10DED == 4) then
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Stk[A + 1]));
										Top = (Limit + A) - 1;
										FlatIdent_10DED = 5;
									end
									if (2 == FlatIdent_10DED) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_10DED = 3;
									end
									if (FlatIdent_10DED == 5) then
										Edx = 0;
										for Idx = A, Top do
											local FlatIdent_86E18 = 0;
											while true do
												if (FlatIdent_86E18 == 0) then
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
													break;
												end
											end
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results = {Stk[A](Unpack(Stk, A + 1, Top))};
										FlatIdent_10DED = 6;
									end
									if (FlatIdent_10DED == 0) then
										Results = nil;
										Edx = nil;
										Results, Limit = nil;
										B = nil;
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_10DED = 1;
									end
								end
							end
						elseif (Enum <= 36) then
							if (Enum <= 33) then
								if (Enum > 32) then
									local B;
									local A;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
								else
									local B;
									local A;
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
								end
							elseif (Enum <= 34) then
								local FlatIdent_1D164 = 0;
								local A;
								local Step;
								local Index;
								while true do
									if (FlatIdent_1D164 == 2) then
										if (Step > 0) then
											if (Index <= Stk[A + 1]) then
												local FlatIdent_1BB5D = 0;
												while true do
													if (FlatIdent_1BB5D == 0) then
														VIP = Inst[3];
														Stk[A + 3] = Index;
														break;
													end
												end
											end
										elseif (Index >= Stk[A + 1]) then
											VIP = Inst[3];
											Stk[A + 3] = Index;
										end
										break;
									end
									if (FlatIdent_1D164 == 1) then
										Index = Stk[A] + Step;
										Stk[A] = Index;
										FlatIdent_1D164 = 2;
									end
									if (0 == FlatIdent_1D164) then
										A = Inst[2];
										Step = Stk[A + 2];
										FlatIdent_1D164 = 1;
									end
								end
							elseif (Enum > 35) then
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return;
								end
							else
								local A;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
							end
						elseif (Enum <= 39) then
							if (Enum <= 37) then
								local A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
							elseif (Enum > 38) then
								Stk[Inst[2]] = Inst[3] ~= 0;
							else
								local K;
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								B = Inst[3];
								K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								Stk[Inst[2]] = K;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 40) then
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						elseif (Enum > 41) then
							local A = Inst[2];
							local Cls = {};
							for Idx = 1, #Lupvals do
								local FlatIdent_40096 = 0;
								local List;
								while true do
									if (FlatIdent_40096 == 0) then
										List = Lupvals[Idx];
										for Idz = 0, #List do
											local Upv = List[Idz];
											local NStk = Upv[1];
											local DIP = Upv[2];
											if ((NStk == Stk) and (DIP >= A)) then
												Cls[DIP] = NStk[DIP];
												Upv[1] = Cls;
											end
										end
										break;
									end
								end
							end
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 64) then
						if (Enum <= 53) then
							if (Enum <= 47) then
								if (Enum <= 44) then
									if (Enum > 43) then
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									else
										local B;
										local A;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										do
											return;
										end
									end
								elseif (Enum <= 45) then
									local FlatIdent_622B0 = 0;
									local A;
									while true do
										if (FlatIdent_622B0 == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											do
												return;
											end
											break;
										end
										if (FlatIdent_622B0 == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_622B0 = 3;
										end
										if (FlatIdent_622B0 == 1) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_622B0 = 2;
										end
										if (FlatIdent_622B0 == 0) then
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_622B0 = 1;
										end
										if (FlatIdent_622B0 == 3) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Inst[3]));
											FlatIdent_622B0 = 4;
										end
									end
								elseif (Enum > 46) then
									local FlatIdent_14716 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_14716 == 3) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_14716 = 4;
										end
										if (FlatIdent_14716 == 6) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_14716 = 7;
										end
										if (FlatIdent_14716 == 7) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Inst[3]));
											break;
										end
										if (FlatIdent_14716 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_14716 = 6;
										end
										if (2 == FlatIdent_14716) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_14716 = 3;
										end
										if (FlatIdent_14716 == 1) then
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_14716 = 2;
										end
										if (FlatIdent_14716 == 0) then
											B = nil;
											A = nil;
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											FlatIdent_14716 = 1;
										end
										if (FlatIdent_14716 == 4) then
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											FlatIdent_14716 = 5;
										end
									end
								else
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 50) then
								if (Enum <= 48) then
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								elseif (Enum == 49) then
									local B;
									local A;
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
								else
									local B = Inst[3];
									local K = Stk[B];
									for Idx = B + 1, Inst[4] do
										K = K .. Stk[Idx];
									end
									Stk[Inst[2]] = K;
								end
							elseif (Enum <= 51) then
								local B;
								local T;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								T = Stk[A];
								B = Inst[3];
								for Idx = 1, B do
									T[Idx] = Stk[A + Idx];
								end
							elseif (Enum > 52) then
								if (Inst[2] < Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Top));
							end
						elseif (Enum <= 58) then
							if (Enum <= 55) then
								if (Enum == 54) then
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
								else
									local B;
									local A;
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3] ~= 0;
								end
							elseif (Enum <= 56) then
								Stk[Inst[2]][Inst[3]] = Inst[4];
							elseif (Enum > 57) then
								local FlatIdent_3501F = 0;
								local A;
								while true do
									if (FlatIdent_3501F == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_3501F = 1;
									end
									if (1 == FlatIdent_3501F) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_3501F = 2;
									end
									if (FlatIdent_3501F == 7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_3501F = 8;
									end
									if (5 == FlatIdent_3501F) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_3501F = 6;
									end
									if (FlatIdent_3501F == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_3501F = 4;
									end
									if (2 == FlatIdent_3501F) then
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_3501F = 3;
									end
									if (8 == FlatIdent_3501F) then
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (6 == FlatIdent_3501F) then
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_3501F = 7;
									end
									if (FlatIdent_3501F == 4) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_3501F = 5;
									end
								end
							else
								local FlatIdent_523B3 = 0;
								local B;
								local A;
								while true do
									if (FlatIdent_523B3 == 1) then
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_523B3 = 2;
									end
									if (FlatIdent_523B3 == 2) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_523B3 = 3;
									end
									if (FlatIdent_523B3 == 3) then
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										FlatIdent_523B3 = 4;
									end
									if (FlatIdent_523B3 == 4) then
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_523B3 = 5;
									end
									if (FlatIdent_523B3 == 7) then
										Stk[Inst[2]][Inst[3]] = Inst[4];
										break;
									end
									if (FlatIdent_523B3 == 0) then
										B = nil;
										A = nil;
										A = Inst[2];
										FlatIdent_523B3 = 1;
									end
									if (FlatIdent_523B3 == 6) then
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_523B3 = 7;
									end
									if (FlatIdent_523B3 == 5) then
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_523B3 = 6;
									end
								end
							end
						elseif (Enum <= 61) then
							if (Enum <= 59) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
							elseif (Enum > 60) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local FlatIdent_4D907 = 0;
								local B;
								local A;
								while true do
									if (1 == FlatIdent_4D907) then
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_4D907 = 2;
									end
									if (FlatIdent_4D907 == 3) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_4D907 = 4;
									end
									if (FlatIdent_4D907 == 2) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_4D907 = 3;
									end
									if (FlatIdent_4D907 == 0) then
										B = nil;
										A = nil;
										A = Inst[2];
										B = Stk[Inst[3]];
										FlatIdent_4D907 = 1;
									end
									if (FlatIdent_4D907 == 4) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
										break;
									end
								end
							end
						elseif (Enum <= 62) then
							local K;
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							B = Inst[3];
							K = Stk[B];
							for Idx = B + 1, Inst[4] do
								K = K .. Stk[Idx];
							end
							Stk[Inst[2]] = K;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							do
								return;
							end
						elseif (Enum == 63) then
							Upvalues[Inst[3]] = Stk[Inst[2]];
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 75) then
						if (Enum <= 69) then
							if (Enum <= 66) then
								if (Enum == 65) then
									local A = Inst[2];
									local C = Inst[4];
									local CB = A + 2;
									local Result = {Stk[A](Stk[A + 1], Stk[CB])};
									for Idx = 1, C do
										Stk[CB + Idx] = Result[Idx];
									end
									local R = Result[1];
									if R then
										Stk[CB] = R;
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								else
									local FlatIdent_2C453 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_2C453 == 1) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											FlatIdent_2C453 = 2;
										end
										if (FlatIdent_2C453 == 2) then
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_2C453 = 3;
										end
										if (4 == FlatIdent_2C453) then
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_2C453 = 5;
										end
										if (0 == FlatIdent_2C453) then
											B = nil;
											A = nil;
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_2C453 = 1;
										end
										if (FlatIdent_2C453 == 5) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_2C453 = 6;
										end
										if (FlatIdent_2C453 == 6) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											break;
										end
										if (FlatIdent_2C453 == 3) then
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_2C453 = 4;
										end
									end
								end
							elseif (Enum <= 67) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
							elseif (Enum == 68) then
								local FlatIdent_5013F = 0;
								local A;
								while true do
									if (0 == FlatIdent_5013F) then
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_5013F = 1;
									end
									if (FlatIdent_5013F == 3) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										FlatIdent_5013F = 4;
									end
									if (FlatIdent_5013F == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (5 == FlatIdent_5013F) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_5013F = 6;
									end
									if (FlatIdent_5013F == 4) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];
										FlatIdent_5013F = 5;
									end
									if (1 == FlatIdent_5013F) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_5013F = 2;
									end
									if (FlatIdent_5013F == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
										VIP = VIP + 1;
										FlatIdent_5013F = 3;
									end
								end
							else
								local FlatIdent_58A9D = 0;
								local A;
								while true do
									if (0 == FlatIdent_58A9D) then
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_58A9D = 1;
									end
									if (2 == FlatIdent_58A9D) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_58A9D = 3;
									end
									if (FlatIdent_58A9D == 1) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_58A9D = 2;
									end
									if (FlatIdent_58A9D == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										do
											return;
										end
										break;
									end
								end
							end
						elseif (Enum <= 72) then
							if (Enum <= 70) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
							elseif (Enum > 71) then
								if (Stk[Inst[2]] ~= Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									local FlatIdent_511F5 = 0;
									while true do
										if (0 == FlatIdent_511F5) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return;
								end
							end
						elseif (Enum <= 73) then
							local FlatIdent_7735C = 0;
							local A;
							while true do
								if (FlatIdent_7735C == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_7735C = 2;
								end
								if (FlatIdent_7735C == 4) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									FlatIdent_7735C = 5;
								end
								if (FlatIdent_7735C == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_7735C = 3;
								end
								if (FlatIdent_7735C == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
									break;
								end
								if (FlatIdent_7735C == 0) then
									A = nil;
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									FlatIdent_7735C = 1;
								end
								if (FlatIdent_7735C == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]]();
									FlatIdent_7735C = 6;
								end
								if (FlatIdent_7735C == 3) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_7735C = 4;
								end
							end
						elseif (Enum == 74) then
							local FlatIdent_458D1 = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_458D1 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_458D1 = 2;
								end
								if (FlatIdent_458D1 == 2) then
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_458D1 = 3;
								end
								if (FlatIdent_458D1 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_458D1 = 6;
								end
								if (FlatIdent_458D1 == 0) then
									B = nil;
									A = nil;
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									FlatIdent_458D1 = 1;
								end
								if (FlatIdent_458D1 == 3) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									FlatIdent_458D1 = 4;
								end
								if (FlatIdent_458D1 == 6) then
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									break;
								end
								if (4 == FlatIdent_458D1) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_458D1 = 5;
								end
							end
						else
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						end
					elseif (Enum <= 80) then
						if (Enum <= 77) then
							if (Enum > 76) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return;
								end
							end
						elseif (Enum <= 78) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
						elseif (Enum > 79) then
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 83) then
						if (Enum <= 81) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						elseif (Enum == 82) then
							local FlatIdent_2F3FA = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_2F3FA == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									FlatIdent_2F3FA = 6;
								end
								if (FlatIdent_2F3FA == 7) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 8;
								end
								if (FlatIdent_2F3FA == 9) then
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									FlatIdent_2F3FA = 10;
								end
								if (FlatIdent_2F3FA == 8) then
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_2F3FA = 9;
								end
								if (FlatIdent_2F3FA == 20) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									FlatIdent_2F3FA = 21;
								end
								if (FlatIdent_2F3FA == 19) then
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_2F3FA = 20;
								end
								if (FlatIdent_2F3FA == 2) then
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 3;
								end
								if (FlatIdent_2F3FA == 22) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									break;
								end
								if (FlatIdent_2F3FA == 0) then
									B = nil;
									A = nil;
									Env[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_2F3FA = 1;
								end
								if (16 == FlatIdent_2F3FA) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_2F3FA = 17;
								end
								if (FlatIdent_2F3FA == 3) then
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_2F3FA = 4;
								end
								if (FlatIdent_2F3FA == 15) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									FlatIdent_2F3FA = 16;
								end
								if (FlatIdent_2F3FA == 12) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 13;
								end
								if (FlatIdent_2F3FA == 13) then
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_2F3FA = 14;
								end
								if (FlatIdent_2F3FA == 18) then
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 19;
								end
								if (FlatIdent_2F3FA == 17) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 18;
								end
								if (FlatIdent_2F3FA == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_2F3FA = 5;
								end
								if (FlatIdent_2F3FA == 10) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									FlatIdent_2F3FA = 11;
								end
								if (FlatIdent_2F3FA == 21) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									FlatIdent_2F3FA = 22;
								end
								if (FlatIdent_2F3FA == 6) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									FlatIdent_2F3FA = 7;
								end
								if (FlatIdent_2F3FA == 14) then
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									FlatIdent_2F3FA = 15;
								end
								if (FlatIdent_2F3FA == 11) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_2F3FA = 12;
								end
								if (FlatIdent_2F3FA == 1) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_2F3FA = 2;
								end
							end
						else
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							do
								return;
							end
						end
					elseif (Enum <= 84) then
						local B;
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
					elseif (Enum == 85) then
						local B;
						local A;
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					else
						local B;
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if not Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					end
				elseif (Enum <= 129) then
					if (Enum <= 107) then
						if (Enum <= 96) then
							if (Enum <= 91) then
								if (Enum <= 88) then
									if (Enum == 87) then
										local B;
										local A;
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
									else
										local FlatIdent_2C2F3 = 0;
										local B;
										local A;
										while true do
											if (FlatIdent_2C2F3 == 6) then
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_2C2F3 = 7;
											end
											if (FlatIdent_2C2F3 == 4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = {};
												VIP = VIP + 1;
												FlatIdent_2C2F3 = 5;
											end
											if (FlatIdent_2C2F3 == 2) then
												Inst = Instr[VIP];
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												FlatIdent_2C2F3 = 3;
											end
											if (FlatIdent_2C2F3 == 7) then
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												break;
											end
											if (FlatIdent_2C2F3 == 3) then
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_2C2F3 = 4;
											end
											if (FlatIdent_2C2F3 == 1) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												FlatIdent_2C2F3 = 2;
											end
											if (FlatIdent_2C2F3 == 0) then
												B = nil;
												A = nil;
												A = Inst[2];
												Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_2C2F3 = 1;
											end
											if (FlatIdent_2C2F3 == 5) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_2C2F3 = 6;
											end
										end
									end
								elseif (Enum <= 89) then
									local A = Inst[2];
									local B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
								elseif (Enum > 90) then
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 93) then
								if (Enum == 92) then
									local B;
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								end
							elseif (Enum <= 94) then
								local FlatIdent_755A7 = 0;
								local A;
								while true do
									if (FlatIdent_755A7 == 3) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_755A7 = 4;
									end
									if (FlatIdent_755A7 == 2) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_755A7 = 3;
									end
									if (5 == FlatIdent_755A7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_755A7 = 6;
									end
									if (FlatIdent_755A7 == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_755A7 = 1;
									end
									if (FlatIdent_755A7 == 4) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_755A7 = 5;
									end
									if (FlatIdent_755A7 == 1) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_755A7 = 2;
									end
									if (6 == FlatIdent_755A7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										break;
									end
								end
							elseif (Enum > 95) then
								local FlatIdent_73069 = 0;
								local A;
								local Index;
								local Step;
								while true do
									if (FlatIdent_73069 == 0) then
										A = Inst[2];
										Index = Stk[A];
										FlatIdent_73069 = 1;
									end
									if (FlatIdent_73069 == 1) then
										Step = Stk[A + 2];
										if (Step > 0) then
											if (Index > Stk[A + 1]) then
												VIP = Inst[3];
											else
												Stk[A + 3] = Index;
											end
										elseif (Index < Stk[A + 1]) then
											VIP = Inst[3];
										else
											Stk[A + 3] = Index;
										end
										break;
									end
								end
							else
								Stk[Inst[2]] = Stk[Inst[3]];
							end
						elseif (Enum <= 101) then
							if (Enum <= 98) then
								if (Enum == 97) then
									local K;
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									B = Inst[3];
									K = Stk[B];
									for Idx = B + 1, Inst[4] do
										K = K .. Stk[Idx];
									end
									Stk[Inst[2]] = K;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
								else
									local FlatIdent_23A2C = 0;
									local A;
									while true do
										if (FlatIdent_23A2C == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											FlatIdent_23A2C = 3;
										end
										if (FlatIdent_23A2C == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]]();
											VIP = VIP + 1;
											FlatIdent_23A2C = 4;
										end
										if (FlatIdent_23A2C == 1) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											FlatIdent_23A2C = 2;
										end
										if (4 == FlatIdent_23A2C) then
											Inst = Instr[VIP];
											VIP = Inst[3];
											break;
										end
										if (0 == FlatIdent_23A2C) then
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_23A2C = 1;
										end
									end
								end
							elseif (Enum <= 99) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
							elseif (Enum > 100) then
								if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
							end
						elseif (Enum <= 104) then
							if (Enum <= 102) then
								local FlatIdent_87DF2 = 0;
								local Edx;
								local Results;
								local Limit;
								local B;
								local A;
								while true do
									if (0 == FlatIdent_87DF2) then
										Edx = nil;
										Results, Limit = nil;
										B = nil;
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_87DF2 = 1;
									end
									if (FlatIdent_87DF2 == 2) then
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_87DF2 = 3;
									end
									if (FlatIdent_87DF2 == 1) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										FlatIdent_87DF2 = 2;
									end
									if (FlatIdent_87DF2 == 3) then
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											local FlatIdent_5C3A6 = 0;
											while true do
												if (0 == FlatIdent_5C3A6) then
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
													break;
												end
											end
										end
										FlatIdent_87DF2 = 4;
									end
									if (FlatIdent_87DF2 == 5) then
										Stk[Inst[2]]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										do
											return;
										end
										break;
									end
									if (FlatIdent_87DF2 == 4) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_87DF2 = 5;
									end
								end
							elseif (Enum > 103) then
								local FlatIdent_7FA00 = 0;
								local Edx;
								local Results;
								local Limit;
								local B;
								local A;
								while true do
									if (FlatIdent_7FA00 == 7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]]();
										VIP = VIP + 1;
										FlatIdent_7FA00 = 8;
									end
									if (FlatIdent_7FA00 == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										FlatIdent_7FA00 = 3;
									end
									if (FlatIdent_7FA00 == 10) then
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										break;
									end
									if (FlatIdent_7FA00 == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										FlatIdent_7FA00 = 7;
									end
									if (FlatIdent_7FA00 == 8) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_7FA00 = 9;
									end
									if (0 == FlatIdent_7FA00) then
										Edx = nil;
										Results, Limit = nil;
										B = nil;
										A = nil;
										FlatIdent_7FA00 = 1;
									end
									if (FlatIdent_7FA00 == 5) then
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										FlatIdent_7FA00 = 6;
									end
									if (FlatIdent_7FA00 == 4) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_7FA00 = 5;
									end
									if (FlatIdent_7FA00 == 9) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_7FA00 = 10;
									end
									if (FlatIdent_7FA00 == 1) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_7FA00 = 2;
									end
									if (FlatIdent_7FA00 == 3) then
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_7FA00 = 4;
									end
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 105) then
							Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
						elseif (Enum > 106) then
							local FlatIdent_821F1 = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_821F1 == 0) then
									B = nil;
									A = nil;
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									FlatIdent_821F1 = 1;
								end
								if (FlatIdent_821F1 == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_821F1 = 4;
								end
								if (FlatIdent_821F1 == 2) then
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									FlatIdent_821F1 = 3;
								end
								if (FlatIdent_821F1 == 6) then
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									break;
								end
								if (FlatIdent_821F1 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_821F1 = 2;
								end
								if (FlatIdent_821F1 == 5) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_821F1 = 6;
								end
								if (FlatIdent_821F1 == 4) then
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_821F1 = 5;
								end
							end
						else
							local FlatIdent_6F428 = 0;
							local B;
							local DIP;
							local NStk;
							local Upv;
							local List;
							local Cls;
							local A;
							while true do
								if (FlatIdent_6F428 == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Cls = {};
									FlatIdent_6F428 = 4;
								end
								if (FlatIdent_6F428 == 6) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_6F428 = 7;
								end
								if (FlatIdent_6F428 == 7) then
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_6F428 = 8;
								end
								if (FlatIdent_6F428 == 5) then
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									FlatIdent_6F428 = 6;
								end
								if (FlatIdent_6F428 == 4) then
									for Idx = 1, #Lupvals do
										List = Lupvals[Idx];
										for Idz = 0, #List do
											Upv = List[Idz];
											NStk = Upv[1];
											DIP = Upv[2];
											if ((NStk == Stk) and (DIP >= A)) then
												local FlatIdent_78655 = 0;
												while true do
													if (FlatIdent_78655 == 0) then
														Cls[DIP] = NStk[DIP];
														Upv[1] = Cls;
														break;
													end
												end
											end
										end
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_6F428 = 5;
								end
								if (FlatIdent_6F428 == 9) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_6F428 = 10;
								end
								if (FlatIdent_6F428 == 10) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									FlatIdent_6F428 = 11;
								end
								if (FlatIdent_6F428 == 0) then
									B = nil;
									DIP = nil;
									NStk = nil;
									Upv = nil;
									FlatIdent_6F428 = 1;
								end
								if (FlatIdent_6F428 == 11) then
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									FlatIdent_6F428 = 12;
								end
								if (FlatIdent_6F428 == 2) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_6F428 = 3;
								end
								if (FlatIdent_6F428 == 12) then
									Stk[A] = B[Inst[4]];
									break;
								end
								if (FlatIdent_6F428 == 8) then
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									FlatIdent_6F428 = 9;
								end
								if (FlatIdent_6F428 == 1) then
									List = nil;
									Cls = nil;
									A = nil;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_6F428 = 2;
								end
							end
						end
					elseif (Enum <= 118) then
						if (Enum <= 112) then
							if (Enum <= 109) then
								if (Enum > 108) then
									local B;
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
								else
									Env[Inst[3]] = Stk[Inst[2]];
								end
							elseif (Enum <= 110) then
								if (Stk[Inst[2]] == Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 111) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
							else
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
							end
						elseif (Enum <= 115) then
							if (Enum <= 113) then
								VIP = Inst[3];
							elseif (Enum == 114) then
								local B;
								local A;
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
							else
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							end
						elseif (Enum <= 116) then
							local NewProto = Proto[Inst[3]];
							local NewUvals;
							local Indexes = {};
							NewUvals = Setmetatable({}, {__index=function(_, Key)
								local Val = Indexes[Key];
								return Val[1][Val[2]];
							end,__newindex=function(_, Key, Value)
								local Val = Indexes[Key];
								Val[1][Val[2]] = Value;
							end});
							for Idx = 1, Inst[4] do
								local FlatIdent_943B1 = 0;
								local Mvm;
								while true do
									if (FlatIdent_943B1 == 1) then
										if (Mvm[1] == 95) then
											Indexes[Idx - 1] = {Stk,Mvm[3]};
										else
											Indexes[Idx - 1] = {Upvalues,Mvm[3]};
										end
										Lupvals[#Lupvals + 1] = Indexes;
										break;
									end
									if (FlatIdent_943B1 == 0) then
										VIP = VIP + 1;
										Mvm = Instr[VIP];
										FlatIdent_943B1 = 1;
									end
								end
							end
							Stk[Inst[2]] = Wrap(NewProto, NewUvals, Env);
						elseif (Enum == 117) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							local B;
							local A;
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
						end
					elseif (Enum <= 123) then
						if (Enum <= 120) then
							if (Enum > 119) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local FlatIdent_2394 = 0;
								local Edx;
								local Results;
								local Limit;
								local B;
								local A;
								while true do
									if (FlatIdent_2394 == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										FlatIdent_2394 = 6;
									end
									if (3 == FlatIdent_2394) then
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										FlatIdent_2394 = 4;
									end
									if (FlatIdent_2394 == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										FlatIdent_2394 = 2;
									end
									if (FlatIdent_2394 == 0) then
										Edx = nil;
										Results, Limit = nil;
										B = nil;
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										FlatIdent_2394 = 1;
									end
									if (FlatIdent_2394 == 4) then
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										FlatIdent_2394 = 5;
									end
									if (FlatIdent_2394 == 2) then
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_2394 = 3;
									end
									if (FlatIdent_2394 == 7) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_2394 = 8;
									end
									if (FlatIdent_2394 == 8) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										break;
									end
									if (FlatIdent_2394 == 6) then
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										FlatIdent_2394 = 7;
									end
								end
							end
						elseif (Enum <= 121) then
							local B;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum > 122) then
							Stk[Inst[2]] = Env[Inst[3]];
						else
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
						end
					elseif (Enum <= 126) then
						if (Enum <= 124) then
							Stk[Inst[2]] = Inst[3];
						elseif (Enum == 125) then
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							Upvalues[Inst[3]] = Stk[Inst[2]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 127) then
						local FlatIdent_64015 = 0;
						local K;
						local B;
						local A;
						while true do
							if (FlatIdent_64015 == 5) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_64015 = 6;
							end
							if (FlatIdent_64015 == 8) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_64015 = 9;
							end
							if (FlatIdent_64015 == 3) then
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								FlatIdent_64015 = 4;
							end
							if (10 == FlatIdent_64015) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_64015 = 11;
							end
							if (FlatIdent_64015 == 6) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								B = Inst[3];
								FlatIdent_64015 = 7;
							end
							if (FlatIdent_64015 == 9) then
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								FlatIdent_64015 = 10;
							end
							if (11 == FlatIdent_64015) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return;
								end
								break;
							end
							if (FlatIdent_64015 == 2) then
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_64015 = 3;
							end
							if (FlatIdent_64015 == 4) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_64015 = 5;
							end
							if (FlatIdent_64015 == 0) then
								K = nil;
								B = nil;
								A = nil;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								FlatIdent_64015 = 1;
							end
							if (FlatIdent_64015 == 7) then
								K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								Stk[Inst[2]] = K;
								VIP = VIP + 1;
								FlatIdent_64015 = 8;
							end
							if (FlatIdent_64015 == 1) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								FlatIdent_64015 = 2;
							end
						end
					elseif (Enum == 128) then
						Stk[Inst[2]] = Upvalues[Inst[3]];
					else
						local FlatIdent_2FA59 = 0;
						local A;
						while true do
							if (FlatIdent_2FA59 == 4) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_2FA59 = 5;
							end
							if (FlatIdent_2FA59 == 2) then
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								FlatIdent_2FA59 = 3;
							end
							if (FlatIdent_2FA59 == 1) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_2FA59 = 2;
							end
							if (FlatIdent_2FA59 == 0) then
								A = nil;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_2FA59 = 1;
							end
							if (FlatIdent_2FA59 == 3) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_2FA59 = 4;
							end
							if (FlatIdent_2FA59 == 7) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								break;
							end
							if (FlatIdent_2FA59 == 5) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_2FA59 = 6;
							end
							if (FlatIdent_2FA59 == 6) then
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								FlatIdent_2FA59 = 7;
							end
						end
					end
				elseif (Enum <= 151) then
					if (Enum <= 140) then
						if (Enum <= 134) then
							if (Enum <= 131) then
								if (Enum == 130) then
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local FlatIdent_45054 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_45054 == 9) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_45054 = 10;
										end
										if (FlatIdent_45054 == 12) then
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_45054 = 13;
										end
										if (FlatIdent_45054 == 6) then
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_45054 = 7;
										end
										if (FlatIdent_45054 == 11) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_45054 = 12;
										end
										if (FlatIdent_45054 == 14) then
											Inst = Instr[VIP];
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_45054 == 3) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_45054 = 4;
										end
										if (FlatIdent_45054 == 5) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_45054 = 6;
										end
										if (FlatIdent_45054 == 1) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_45054 = 2;
										end
										if (FlatIdent_45054 == 13) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											FlatIdent_45054 = 14;
										end
										if (FlatIdent_45054 == 4) then
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_45054 = 5;
										end
										if (FlatIdent_45054 == 0) then
											B = nil;
											A = nil;
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_45054 = 1;
										end
										if (FlatIdent_45054 == 10) then
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_45054 = 11;
										end
										if (FlatIdent_45054 == 8) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											FlatIdent_45054 = 9;
										end
										if (FlatIdent_45054 == 2) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_45054 = 3;
										end
										if (7 == FlatIdent_45054) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_45054 = 8;
										end
									end
								end
							elseif (Enum <= 132) then
								local B;
								local A;
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3] ~= 0;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							elseif (Enum == 133) then
								local B;
								local Edx;
								local Results, Limit;
								local A;
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
							else
								local B;
								local A;
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
							end
						elseif (Enum <= 137) then
							if (Enum <= 135) then
								local Results;
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									local FlatIdent_4D046 = 0;
									while true do
										if (FlatIdent_4D046 == 0) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results = {Stk[A](Unpack(Stk, A + 1, Top))};
								Edx = 0;
								for Idx = A, Inst[4] do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							elseif (Enum == 136) then
								Stk[Inst[2]] = Stk[Inst[3]] / Inst[4];
							else
								do
									return;
								end
							end
						elseif (Enum <= 138) then
							local FlatIdent_1FCD6 = 0;
							local A;
							while true do
								if (FlatIdent_1FCD6 == 0) then
									A = nil;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_1FCD6 = 1;
								end
								if (FlatIdent_1FCD6 == 6) then
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_1FCD6 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									FlatIdent_1FCD6 = 3;
								end
								if (FlatIdent_1FCD6 == 1) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									FlatIdent_1FCD6 = 2;
								end
								if (FlatIdent_1FCD6 == 4) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									FlatIdent_1FCD6 = 5;
								end
								if (FlatIdent_1FCD6 == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_1FCD6 = 4;
								end
								if (FlatIdent_1FCD6 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_1FCD6 = 6;
								end
							end
						elseif (Enum == 139) then
							local B;
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
						else
							local B;
							local A;
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
						end
					elseif (Enum <= 145) then
						if (Enum <= 142) then
							if (Enum == 141) then
								local A = Inst[2];
								local Results = {Stk[A](Unpack(Stk, A + 1, Top))};
								local Edx = 0;
								for Idx = A, Inst[4] do
									local FlatIdent_5550 = 0;
									while true do
										if (FlatIdent_5550 == 0) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
							elseif (Inst[2] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 143) then
							local B;
							local A;
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
						elseif (Enum > 144) then
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						else
							local FlatIdent_14BC6 = 0;
							local A;
							while true do
								if (FlatIdent_14BC6 == 1) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_14BC6 = 2;
								end
								if (FlatIdent_14BC6 == 7) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									FlatIdent_14BC6 = 8;
								end
								if (FlatIdent_14BC6 == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_14BC6 = 6;
								end
								if (FlatIdent_14BC6 == 8) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_14BC6 = 9;
								end
								if (4 == FlatIdent_14BC6) then
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_14BC6 = 5;
								end
								if (FlatIdent_14BC6 == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									FlatIdent_14BC6 = 7;
								end
								if (FlatIdent_14BC6 == 3) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_14BC6 = 4;
								end
								if (FlatIdent_14BC6 == 2) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_14BC6 = 3;
								end
								if (FlatIdent_14BC6 == 0) then
									A = nil;
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_14BC6 = 1;
								end
								if (FlatIdent_14BC6 == 10) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_14BC6 == 9) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_14BC6 = 10;
								end
							end
						end
					elseif (Enum <= 148) then
						if (Enum <= 146) then
							local FlatIdent_60BB = 0;
							local A;
							while true do
								if (FlatIdent_60BB == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_60BB = 5;
								end
								if (3 == FlatIdent_60BB) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_60BB = 4;
								end
								if (0 == FlatIdent_60BB) then
									A = nil;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_60BB = 1;
								end
								if (8 == FlatIdent_60BB) then
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									FlatIdent_60BB = 9;
								end
								if (FlatIdent_60BB == 9) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_60BB = 10;
								end
								if (FlatIdent_60BB == 11) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									break;
								end
								if (FlatIdent_60BB == 6) then
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_60BB = 7;
								end
								if (FlatIdent_60BB == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_60BB = 6;
								end
								if (FlatIdent_60BB == 7) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_60BB = 8;
								end
								if (FlatIdent_60BB == 10) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_60BB = 11;
								end
								if (FlatIdent_60BB == 2) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_60BB = 3;
								end
								if (FlatIdent_60BB == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_60BB = 2;
								end
							end
						elseif (Enum > 147) then
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 149) then
						local FlatIdent_41403 = 0;
						local A;
						while true do
							if (FlatIdent_41403 == 1) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_41403 = 2;
							end
							if (FlatIdent_41403 == 2) then
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_41403 = 3;
							end
							if (FlatIdent_41403 == 4) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_41403 = 5;
							end
							if (FlatIdent_41403 == 6) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
								FlatIdent_41403 = 7;
							end
							if (3 == FlatIdent_41403) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								FlatIdent_41403 = 4;
							end
							if (FlatIdent_41403 == 5) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_41403 = 6;
							end
							if (FlatIdent_41403 == 0) then
								A = nil;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_41403 = 1;
							end
							if (FlatIdent_41403 == 7) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
								break;
							end
						end
					elseif (Enum > 150) then
						local FlatIdent_34A16 = 0;
						local K;
						local B;
						local A;
						while true do
							if (FlatIdent_34A16 == 0) then
								K = nil;
								B = nil;
								A = nil;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 1;
							end
							if (FlatIdent_34A16 == 1) then
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 2;
							end
							if (FlatIdent_34A16 == 2) then
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 3;
							end
							if (FlatIdent_34A16 == 6) then
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 7;
							end
							if (FlatIdent_34A16 == 7) then
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return;
								end
								break;
							end
							if (FlatIdent_34A16 == 3) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 4;
							end
							if (FlatIdent_34A16 == 5) then
								Stk[Inst[2]] = K;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_34A16 = 6;
							end
							if (FlatIdent_34A16 == 4) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								B = Inst[3];
								K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								FlatIdent_34A16 = 5;
							end
						end
					else
						local FlatIdent_27E8B = 0;
						local Results;
						local Edx;
						local Limit;
						local B;
						local A;
						while true do
							if (FlatIdent_27E8B == 2) then
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_27E8B = 3;
							end
							if (FlatIdent_27E8B == 0) then
								Results = nil;
								Edx = nil;
								Results, Limit = nil;
								B = nil;
								A = nil;
								Stk[Inst[2]] = Env[Inst[3]];
								FlatIdent_27E8B = 1;
							end
							if (4 == FlatIdent_27E8B) then
								A = Inst[2];
								Results = {Stk[A](Unpack(Stk, A + 1, Top))};
								Edx = 0;
								for Idx = A, Inst[4] do
									local FlatIdent_477A5 = 0;
									while true do
										if (FlatIdent_477A5 == 0) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_27E8B = 5;
							end
							if (FlatIdent_27E8B == 3) then
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									local FlatIdent_43BA3 = 0;
									while true do
										if (FlatIdent_43BA3 == 0) then
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
											break;
										end
									end
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_27E8B = 4;
							end
							if (5 == FlatIdent_27E8B) then
								VIP = Inst[3];
								break;
							end
							if (FlatIdent_27E8B == 1) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_27E8B = 2;
							end
						end
					end
				elseif (Enum <= 162) then
					if (Enum <= 156) then
						if (Enum <= 153) then
							if (Enum > 152) then
								local FlatIdent_59A4E = 0;
								while true do
									if (3 == FlatIdent_59A4E) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 4;
									end
									if (FlatIdent_59A4E == 0) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 1;
									end
									if (FlatIdent_59A4E == 4) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 5;
									end
									if (FlatIdent_59A4E == 2) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 3;
									end
									if (FlatIdent_59A4E == 5) then
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 6;
									end
									if (FlatIdent_59A4E == 6) then
										do
											return;
										end
										break;
									end
									if (1 == FlatIdent_59A4E) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_59A4E = 2;
									end
								end
							else
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							end
						elseif (Enum <= 154) then
							local Edx;
							local Results, Limit;
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A]());
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								local FlatIdent_35E38 = 0;
								while true do
									if (FlatIdent_35E38 == 0) then
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
										break;
									end
								end
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] == Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 155) then
							local FlatIdent_4BA75 = 0;
							local B;
							local A;
							while true do
								if (7 == FlatIdent_4BA75) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_4BA75 = 8;
								end
								if (FlatIdent_4BA75 == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									FlatIdent_4BA75 = 4;
								end
								if (FlatIdent_4BA75 == 2) then
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									FlatIdent_4BA75 = 3;
								end
								if (FlatIdent_4BA75 == 4) then
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_4BA75 = 5;
								end
								if (1 == FlatIdent_4BA75) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_4BA75 = 2;
								end
								if (FlatIdent_4BA75 == 0) then
									B = nil;
									A = nil;
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_4BA75 = 1;
								end
								if (FlatIdent_4BA75 == 8) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									break;
								end
								if (FlatIdent_4BA75 == 5) then
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_4BA75 = 6;
								end
								if (6 == FlatIdent_4BA75) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_4BA75 = 7;
								end
							end
						else
							local A = Inst[2];
							Stk[A] = Stk[A]();
						end
					elseif (Enum <= 159) then
						if (Enum <= 157) then
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						elseif (Enum > 158) then
							local FlatIdent_5F20A = 0;
							local DIP;
							local NStk;
							local Upv;
							local List;
							local Cls;
							local B;
							local A;
							while true do
								if (FlatIdent_5F20A == 6) then
									A = Inst[2];
									Cls = {};
									for Idx = 1, #Lupvals do
										local FlatIdent_74AD2 = 0;
										while true do
											if (FlatIdent_74AD2 == 0) then
												List = Lupvals[Idx];
												for Idz = 0, #List do
													Upv = List[Idz];
													NStk = Upv[1];
													DIP = Upv[2];
													if ((NStk == Stk) and (DIP >= A)) then
														Cls[DIP] = NStk[DIP];
														Upv[1] = Cls;
													end
												end
												break;
											end
										end
									end
									VIP = VIP + 1;
									FlatIdent_5F20A = 7;
								end
								if (FlatIdent_5F20A == 7) then
									Inst = Instr[VIP];
									do
										return;
									end
									break;
								end
								if (2 == FlatIdent_5F20A) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_5F20A = 3;
								end
								if (1 == FlatIdent_5F20A) then
									Cls = nil;
									B = nil;
									A = nil;
									Stk[Inst[2]][Inst[3]] = Inst[4];
									FlatIdent_5F20A = 2;
								end
								if (FlatIdent_5F20A == 4) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_5F20A = 5;
								end
								if (FlatIdent_5F20A == 0) then
									DIP = nil;
									NStk = nil;
									Upv = nil;
									List = nil;
									FlatIdent_5F20A = 1;
								end
								if (FlatIdent_5F20A == 5) then
									A = Inst[2];
									Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_5F20A = 6;
								end
								if (FlatIdent_5F20A == 3) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_5F20A = 4;
								end
							end
						else
							local FlatIdent_81F0D = 0;
							local B;
							local T;
							local A;
							while true do
								if (FlatIdent_81F0D == 7) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81F0D = 8;
								end
								if (6 == FlatIdent_81F0D) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81F0D = 7;
								end
								if (1 == FlatIdent_81F0D) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_81F0D = 2;
								end
								if (FlatIdent_81F0D == 9) then
									B = Inst[3];
									for Idx = 1, B do
										T[Idx] = Stk[A + Idx];
									end
									break;
								end
								if (FlatIdent_81F0D == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_81F0D = 6;
								end
								if (FlatIdent_81F0D == 0) then
									B = nil;
									T = nil;
									A = nil;
									FlatIdent_81F0D = 1;
								end
								if (FlatIdent_81F0D == 4) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									FlatIdent_81F0D = 5;
								end
								if (FlatIdent_81F0D == 2) then
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									FlatIdent_81F0D = 3;
								end
								if (8 == FlatIdent_81F0D) then
									Inst = Instr[VIP];
									A = Inst[2];
									T = Stk[A];
									FlatIdent_81F0D = 9;
								end
								if (FlatIdent_81F0D == 3) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
									VIP = VIP + 1;
									FlatIdent_81F0D = 4;
								end
							end
						end
					elseif (Enum <= 160) then
						local FlatIdent_51A71 = 0;
						local B;
						local A;
						while true do
							if (FlatIdent_51A71 == 3) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								FlatIdent_51A71 = 4;
							end
							if (FlatIdent_51A71 == 2) then
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								FlatIdent_51A71 = 3;
							end
							if (FlatIdent_51A71 == 5) then
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								FlatIdent_51A71 = 6;
							end
							if (FlatIdent_51A71 == 1) then
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								FlatIdent_51A71 = 2;
							end
							if (FlatIdent_51A71 == 0) then
								B = nil;
								A = nil;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_51A71 = 1;
							end
							if (FlatIdent_51A71 == 4) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_51A71 = 5;
							end
							if (6 == FlatIdent_51A71) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								break;
							end
						end
					elseif (Enum > 161) then
						local FlatIdent_84A95 = 0;
						local A;
						while true do
							if (FlatIdent_84A95 == 0) then
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								break;
							end
						end
					else
						local B;
						local A;
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
					end
				elseif (Enum <= 167) then
					if (Enum <= 164) then
						if (Enum == 163) then
							local Edx;
							local Results, Limit;
							local B;
							local A;
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 165) then
						local A;
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
					elseif (Enum == 166) then
						local B;
						local A;
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = {};
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]][Inst[3]] = Inst[4];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					else
						local A = Inst[2];
						Stk[A](Unpack(Stk, A + 1, Inst[3]));
					end
				elseif (Enum <= 170) then
					if (Enum <= 168) then
						local Edx;
						local Results, Limit;
						local B;
						local A;
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
						Top = (Limit + A) - 1;
						Edx = 0;
						for Idx = A, Top do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]]();
						VIP = VIP + 1;
						Inst = Instr[VIP];
						do
							return;
						end
					elseif (Enum > 169) then
						Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
					else
						local A = Inst[2];
						local T = Stk[A];
						local B = Inst[3];
						for Idx = 1, B do
							T[Idx] = Stk[A + Idx];
						end
					end
				elseif (Enum <= 171) then
					local FlatIdent_357A9 = 0;
					local B;
					local A;
					while true do
						if (FlatIdent_357A9 == 3) then
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							FlatIdent_357A9 = 4;
						end
						if (1 == FlatIdent_357A9) then
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							FlatIdent_357A9 = 2;
						end
						if (FlatIdent_357A9 == 4) then
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							FlatIdent_357A9 = 5;
						end
						if (FlatIdent_357A9 == 2) then
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							FlatIdent_357A9 = 3;
						end
						if (0 == FlatIdent_357A9) then
							B = nil;
							A = nil;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							FlatIdent_357A9 = 1;
						end
						if (FlatIdent_357A9 == 5) then
							Stk[Inst[2]] = {};
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = {};
							FlatIdent_357A9 = 6;
						end
						if (FlatIdent_357A9 == 6) then
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Inst[3]] = Inst[4];
							break;
						end
					end
				elseif (Enum > 172) then
					local B;
					local A;
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					B = Stk[Inst[3]];
					Stk[A + 1] = B;
					Stk[A] = B[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = {};
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Inst[4];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Inst[4];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = {};
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = {};
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Inst[3]] = Inst[4];
				else
					local B;
					local A;
					A = Inst[2];
					B = Stk[Inst[3]];
					Stk[A + 1] = B;
					Stk[A] = B[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					B = Stk[Inst[3]];
					Stk[A + 1] = B;
					Stk[A] = B[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A](Stk[A + 1]);
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
return VMCall("LOL!DB3O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403463O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F49747A416D616E4B6F757368616C2F4E797875732F6D61696E2F7076702F69642E6C756103493O00682O7470733A2O2F6769746875622E636F6D2F64617769642D736372697074732F466C75656E742F72656C65617365732F6C61746573742F646F776E6C6F61642F6D61696E2E6C756103543O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F64617769642D736372697074732F466C75656E742F6D61737465722F412O646F6E732F536176654D616E616765722E6C756103593O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F64617769642D736372697074732F466C75656E742F6D61737465722F412O646F6E732F496E746572666163654D616E616765722E6C7561030C3O0043726561746557696E646F7703053O005469746C65030B3O00486561646C652O73202D2003073O0056657273696F6E03083O005375625469746C6503083O006279202E5F6D346E03083O005461625769647468026O00644003043O0053697A6503053O005544696D32030A3O0066726F6D4F2O66736574025O00208240025O00C0724003073O00416372796C69632O0103053O005468656D6503043O004461726B030B3O004D696E696D697A654B657903043O00456E756D03073O004B6579436F64652O033O00456E64030A3O004765745365727669636503103O0055736572496E70757453657276696365030D3O00627265616B76656C6F6369747903043O004D61696E03063O00412O64546162030B3O00496E666F726D6174696F6E03043O0049636F6E03043O00696E666F03073O004661726D696E6703053O0075736572732O033O0050765003113O00507650204D6F64696669636174696F6E7303063O0073776F726473030C3O004F7468657253637269707473030D3O004F746865722053637269707473030D3O00616C69676E2D6A75737469667903083O0053652O74696E677303083O0073652O74696E677303073O004F7074696F6E73030C3O00412O64506172616772617068030A3O00446973636C61696D657203073O00436F6E74656E7403E7012O00312E20557365206F66207468697320736372697074206D6179206C65616420746F2065787472616F7264696E617279206665617473206F6620526F626C6F786572792C2062757420616C736F20746F20706F74656E7469616C2062616E732C206578697374656E7469616C206372697365732C20616E6420616E20696E6578706C696361626C652064657369726520746F20636F2O6C656374207669727475616C20686174732E2O0A322E20416D616E204B6F7573686C2069732074686520617574686F722077686F206D616465206974207368612O6C206E6F742062652068656C6420612O636F756E7461626C6520666F7220616E79207669727475616C206F72207265616C2D6C69666520636F6E73657175656E6365732061726973696E672066726F6D2074686520757365206F662074686973207363726970742E2O0A332E2052656D656D6265722C207769746820677265617420706F77657220636F6D657320677265617420726573706F6E736962696C6974792C206F72206174206C65617374206120632O6F6C20757365726E616D6520616E64206120636F2O6C656374696F6E206F6620526F626C6F7820667269656E64732E2O0A342E2050726F632O656420617420796F7572206F776E207269736B2C206272617665206578706C6F7265722103043O004E6F74650385022O00312E2054686973207363726970742069732061206D617276656C206F66204C756120656E67696E2O6572696E672C206D65746963756C6F75736C79206372616674656420746F20656C6576617465207468652067616D696E6720657870657269656E63652077697468696E2074686520692O6C75737472696F7573207265616C6D206F6620526F626C6F782C20706172746963756C61726C79207461696C6F72656420666F722074686520657069632073616761206B6E6F776E2061732022416765206F66204865726F65732E222O0A322E20456D62726163652069747320706F77657220616E64207769656C6420697420776973656C792C20666F7220697420706F2O73652O73657320746865206361706162696C69747920746F207472616E7363656E64206D6572652067616D65706C617920696E746F207265616C6D73206F66206C6567656E642E2O0A332E204265686F6C642069747320617273656E616C206F662066656174757265733A20706C6179657220612O74726962757465206D616E6970756C6174696F6E2C2074656C65706F72746174696F6E206D6173746572792C206175746F6D6174656420636F6D6261742070726F77652O732C20616E74692D69646C6520656E6368616E746D656E74732C20616E6420746865207365616D6C652O7320696E746567726174696F6E207769746820446973636F726420666F722073637269707420657865637574696F6E207265706F7274696E672E2O0A342E204120736D612O6C206D652O7361676520666F72206365727461696E20696E646976696475616C73204F2O6C696520616E642050617472692O783A204655434B20552C204F2O4C494520414E44205041542C205355434B204D59204449434B2103073O004372656469747303803O00546869732073637269707420776173206D616465206279205F6D346E2C2076657273696F6E2031322E352C2072656C6561736564206F6E204D617920392C20323032342E2O0A476974487562207265706F7369746F72793A20682O7470733A2O2F6769746875622E636F6D2F49747A416D616E4B6F757368616C2F4E79787573036E3O0054686973207363726970742069732064657369676E656420746F20666163696C697461746520746865206661726D696E67206F66206D756C7469706C652074616E6B656420612O636F756E747320696E206F7264657220746F2073752O706F72742061206D61696E2074616E6B2E03093O00412O6442752O746F6E03073O0047726176697479030B3O004465736372697074696F6E03283O00536574207468652067726176697479206F662074686520706C6179657220746F20315O302E03083O0043612O6C6261636B025O00507040025O0022B2C0025O00C0584002E92F37EFC673704002F5979B77E3617040020BEB14421020B2C0020B6864881C3E70400217D0C810392C704002F514EBBDEF23B2C0031A3O004661726D696E6720412O636F756E7420284D61696E20412O632903063O0054616E6B203103063O0054616E6B203203063O0054616E6B203303063O0054616E6B203403063O0054616E6B203503063O0054616E6B2036030B3O00412O6444726F70646F776E03103O004C6F636174696F6E44726F70646F776E03113O004C6F636174696F6E2044726F70646F776E03063O0056616C75657303053O004D756C7469010003073O0044656661756C74026O00F03F03093O004F6E4368616E67656403093O00412O64546F2O676C65030C3O004C2O6F705470546F2O676C6503223O00546F2O676C65204C2O6F7020545020546F2053656C6563746564204F7074696F6E2E03053O004E6F74653A03BD3O00496620796F75206172652074656C65706F7274696E6720746F20616E206F7074696F6E2066726F6D207468652064726F70646F776E2061626F766520616E64206E6F7720796F752077616E7420746F2074656C65706F727420746F20616E79206F74686572206F7074696F6E207468656E206669727374207475726E206F2O6620746865206C2O6F70207468656E2073656C65637420746865206E6577206F7074696F6E207468656E207475726E20746865206C2O6F70206261636B2E03093O00412O64536C69646572030D3O0047726176697479536C69646572030E3O004772617669747920536C6964657203273O0041646A7573742074686520677261766974792076616C7565206F662074686520706C617965722E025O668668402O033O004D696E028O002O033O004D6178024O0080842E4103083O00526F756E64696E67030B3O0050756E6368546F2O676C65030A3O004175746F2050756E6368030B3O005374617473546F2O676C6503153O004175746F2053746174732028737472656E6774682903183O004F6E6365207475726E6564206F6E2069742077692O6C202E03103O00537461727420416E74692049646C652E033F3O0053746172742074686520616E74692069646C652070726F63652O7320746F2070726576656E74203230206D696E2049646C65206B69636B2073797374656D2E033F3O005468697320736372697074206D6F64696669657320746865205076502028506C617965722076657273757320506C617965722920657870657269656E63652E030B3O0053702O6564536C69646572030D3O0053702O6564204368616E67657203343O0041646A757374207468652073702O6564206F662074686520636861726163746572207573696E67207468697320736C696465722E026O003040025O00409F40030A3O004A756D70536C69646572030C3O004A756D70204368616E67657203283O0041646A75737420746865206A756D7020706F776572207573696E67207468697320736C696465722E026O004940025O00E08540030F3O0042726572616B2056656C6F63697479033D3O00546869732062752O746F6E206973207665727920696D706F7274616E7420617320697420612O6C6F777320627265616B696E672076656C6F636974792E030F3O0052657365742043686172616374657203293O005265736574207468652063686172616374657220746F206974732064656661756C742073746174652E030A3O00412O644B657962696E6403073O004B657962696E6403053O004D6574616C03043O004D6F646503063O00546F2O676C6503013O005203073O004F6E436C69636B03073O006B657962696E6403043O004D61736B03013O0054030A3O00466972652050756E636803013O004C03113O005265706C69636174656453746F7261676503063O004576656E747303053O0050756E6368030A3O004175746F436F6D626174030B3O004175746F20436F6D626174026O00144003103O004175746F436F6D626174536C6964657203173O0050756E636820686561727462656174206368616E676572032D3O0041646A757374207468652070756E636820686561727462656174207573696E67207468697320736C696465722E026O00E03F026O00244003103O00436F6D626174436C696E657442696E64030D3O00436F6D62617420436C69656E7403013O004A030A3O00496E707574426567616E03073O00436F2O6E656374030A3O00496E707574456E64656403073O00496E664A756D7003083O00496E66204A756D7003043O0054656C6503083O00496E662054656C6503073O0067657473656E7603073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403113O0074656C656B696E65736973436C69656E74030D3O004E616D65457370546F2O676C65030C3O00557365724E616D652045535003083O007465787473697A65026O00344003083O00496E7374616E63652O033O006E6577030C3O0042692O6C626F61726447756903093O00546578744C6162656C03043O004E616D652O033O00657370030C3O0052657365744F6E537061776E030B3O00416C776179734F6E546F70030E3O004C69676874496E666C75656E6365026O00FC3F03103O004261636B67726F756E64436F6C6F723303063O00436F6C6F723303073O0066726F6D524742025O00E06F4003043O0054657874034O00022D431CEBE2361A3F023O0080B5F8E43E030F3O00426F7264657253697A65506978656C026O001040030C3O00426F72646572436F6C6F7233025O00405F40025O00406B40026O00564003043O00466F6E7403123O00536F7572636553616E7353656D69626F6C6403083O005465787453697A65030A3O0054657874436F6C6F7233030A3O0052756E53657276696365030D3O0052656E6465725374652O706564030E3O00496E66696E697465205969656C6403223O004120676C6F62616C2073637269707420666F7220496E66696E697465205969656C64030D3O00536372697074204E652O62696103153O00536372697074204E652O626961206279206A6F7365030B3O0043796C696E64726963616C031F3O0043796C696E64726963616C206D616465206279204C65636875676166726961030C3O00446578204578706C6F72657203193O00446578204578706C6F726572206279206D2O6F6E6C69676874030A3O005365744C69627261727903133O0049676E6F72655468656D6553652O74696E677303103O0053657449676E6F7265496E646578657303093O00536574466F6C646572030F3O00466C75656E74536372697074487562031D3O00466C75656E745363726970744875622F73706563696669632D67616D6503153O004275696C64496E7465726661636553656374696F6E03123O004275696C64436F6E66696753656374696F6E03093O0053656C65637454616203063O004E6F7469667903083O00486561646C652O73031B3O00546865207363726970742068617320622O656E206C6F616465642E03083O004475726174696F6E026O00204003123O004C6F61644175746F6C6F6164436F6E666967007E022O0012683O00013O00122O000100023O00202O00010001000300122O000300046O000100039O0000026O0001000100124O00013O00122O000100023O00202O00010001000300127C000300054O0085000100039O0000026O0001000200122O000100013O00122O000200023O00202O00020002000300122O000400066O000200046O00013O00024O00010001000200127B000200013O001277000300023O00202O00030003000300122O000500076O000300056O00023O00024O00020001000200202O00033O00084O00053O000700122O0006000A3O00202O00073O000B2O003200060006000700102300050009000600302O0005000C000D00302O0005000E000F00122O000600113O00202O00060006001200122O000700133O00122O000800146O00060008000200102O00050010000600302O0005001500160030380005001700180012550006001A3O00202O00060006001B00202O00060006001C00102O0005001900064O00030005000200122O000400023O00202O00040004001D00122O0006001E6O00040006000200021400055O0012520005001F6O00053O000500202O0006000300214O00083O000200302O00080009002200302O0008002300244O00060008000200102O00050020000600202O0006000300214O00083O000200302O00080009002500302O0008002300264O00060008000200102O00050025000600202O0006000300214O00083O000200302O00080009002800302O0008002300294O00060008000200102O00050027000600202O0006000300214O00083O000200302O00080009002B00302O00080023002C4O00060008000200102O0005002A000600202O0006000300214O00083O000200302O00080009002D00302O00080023002E4O00060008000200102O0005002D000600202O00063O002F00202O00070005002000202O0007000700304O00093O000200302O00090009003100302O0009003200334O00070009000100202O00070005002000202O0007000700304O00093O000200302O00090009003400302O0009003200354O00070009000100202O00070005002000202O0007000700304O00093O000200302O00090009003600302O0009003200374O00070009000100202O00070005002500202O0007000700304O00093O000200302O00090009003400302O0009003200384O00070009000100202O00070005002500202O0007000700394O00093O000300302O00090009003A00302O0009003B003C000214000A00013O00109E0009003D000A4O0007000900014O000700076O000800033O00122O0009003E3O00122O000A003F3O00122O000B00406O0008000300012O000C000900033O00127C000A00413O00127C000B003F3O00127C000C00404O00A90009000300012O000C000A00033O00127C000B00423O00127C000C00433O00127C000D00404O00A9000A000300012O000C000B00033O00127C000C00443O00127C000D00433O00127C000E00404O00A9000B000300012O000C000C00033O00127C000D00453O00127C000E003F3O00127C000F00404O00A9000C000300012O000C000D00033O00127C000E00443O00127C000F00463O00127C001000404O00A9000D000300012O000C000E00033O00127C000F00423O00127C001000463O00127C001100404O00A9000E000300012O00A90007000700012O000C000800073O001233000900473O00122O000A00483O00122O000B00493O00122O000C004A3O00122O000D004B3O00122O000E004C3O00122O000F004D6O00080007000100201700090005002500209B00090009004E00122O000B004F6O000C3O000400302O000C0009005000102O000C0051000800302O000C0052005300302O000C005400554O0009000C000200202O000A00090056000674000C0002000100022O005F3O00084O005F3O00074O0037000A000C000100202O000A0005002500202O000A000A005700122O000C00586O000D3O000200302O000D0009005900302O000D005400534O000A000D00024O000B5O000674000C0003000100042O005F3O000B4O005F3O00084O005F3O00094O005F3O00073O002059000D000A0056000674000F0004000100032O005F3O000B4O005F3O00064O005F3O000C4O0039000D000F000100202O000D0005002500202O000D000D00304O000F3O000200302O000F0009005A00302O000F0032005B2O00A7000D000F0001002059000D00090056000674000F0005000100022O005F3O000B4O005F3O000C4O0031000D000F000100202O000D0005002500202O000D000D005C00122O000F005D6O00103O000700302O00100009005E00302O0010003B005F00302O00100054006000302O00100061006200302O001000630064003038001000650055000214001100063O0010500010003D00112O0091000D00100002002059000E000D0056000214001000074O0037000E0010000100202O000E0005002500202O000E000E005700122O001000666O00113O000200302O00110009006700302O0011005400534O000E001100024O000F5O00067400100008000100012O005F3O000F3O0020590011000E005600067400130009000100032O005F3O000F4O005F3O00064O005F3O00104O005800110013000100202O00110005002500202O00110011005700122O001300686O00143O000200302O00140009006900302O0014005400534O0011001400020002140012000A4O002700135O0020590014001100560006740016000B000100032O005F3O00134O005F3O00064O005F3O00124O003900140016000100202O00140005002500202O0014001400304O00163O000200302O00160009005A00302O00160032006A2O003900140016000100202O00140005002500202O0014001400394O00163O000300302O00160009006B00302O0016003B006C0006740017000C000100022O005F3O00034O005F7O00108F0016003D00174O00140016000100202O00140005002700202O0014001400304O00163O000200302O00160009003400302O00160032006D2O003100140016000100202O00140005002700202O00140014005C00122O0016006E6O00173O000700302O00170009006F00302O0017003B007000302O00170054007100302O00170061005500302O0017006300720030380017006500620002140018000D3O0010500017003D00182O00910014001700020020590015001400560002140017000E4O003100150017000100202O00150005002700202O00150015005C00122O001700736O00183O000700302O00180009007400302O0018003B007500302O00180054007600302O00180061005500302O0018006300770030380018006500620002140019000F3O0010500018003D00192O0091001500180002002059001600150056000214001800104O003900160018000100202O00160005002700202O0016001600394O00183O000300302O00180009007800302O0018003B0079000214001900113O00108F0018003D00194O00160018000100202O00160005002700202O0016001600394O00183O000300302O00180009007A00302O0018003B007B00067400190012000100012O005F3O00033O0010A60018003D00194O00160018000100202O00160005002700202O00160016007C00122O0018007D6O00193O000300302O00190009007E00302O0019007F008000302O0019005400814O001600190002002059001700160082000214001900134O00A700170019000100205900170016005600067400190014000100022O005F8O005F3O00164O000300170019000100202O00170005002700202O00170017007C00122O001900836O001A3O000300302O001A0009008400302O001A007F008000302O001A005400854O0017001A000200202O001800170082000214001A00154O00A70018001A0001002059001800170056000674001A0016000100022O005F8O005F3O00174O00030018001A000100202O00180005002700202O00180018007C00122O001A007D6O001B3O000300302O001B0009008600302O001B007F008000302O001B005400874O0018001B000200202O001900180082000214001B00174O00A70019001B0001002059001900180056000674001B0018000100022O005F8O005F3O00184O001A0019001B000100122O001900023O00202O00190019001D00122O001B00886O0019001B000200202O00190019008900202O00190019008A00202O001A0005002700202O001A001A005700122O001C008B4O000C001D3O0002003084001D0009008C00302O001D005400534O001A001D00024O001B5O00202O001C001A0056000674001E0019000100012O005F3O001B4O0018001C001E000100122O001C008D3O00122O001D00553O00202O001E0005002700202O001E001E005C00122O0020008E6O00213O000700302O00210009008F00302O0021003B009000302O0021005400550030380021006100910030380021006300920030380021006500550002140022001A3O0010500021003D00222O0091001E00210002002059001F001E00560006740021001B000100012O005F3O001C4O0043001F0021000100202O001F0005002700202O001F001F007C00122O002100936O00223O000300302O00220009009400302O0022007F008000302O0022005400954O001F002200024O00205O0006740021001C000100042O005F3O00204O005F3O001B4O005F3O00194O005F3O001C3O0020590022001F00820002140024001D4O00A70022002400010020590022001F00560006740024001E000100022O005F8O005F3O001F4O00A70022002400010020170022000400960020590022002200970006740024001F000100032O005F3O001F4O005F3O00204O005F3O00214O00A700220024000100201700220004009800205900220022009700067400240020000100022O005F3O001F4O005F3O00204O005800220024000100202O00220005002700202O00220022005700122O002400996O00253O000200302O00250009009A00302O0025005400534O0022002500022O0073002300234O002700245O00205900250022005600067400270021000100032O005F3O00244O005F3O00234O005F3O00044O007000250027000100202O00250005002700202O00250025005700122O0027009B6O00283O000200302O00280009009C00302O0028005400534O00250028000200122O0026009D3O00122O002700023O00201700270027009E00209800270027009F00202O0027002700A000202O0027002700A100122O002900A26O002700296O00263O000200202O00270025005600067400290022000100012O005F3O00264O006300270029000100202O00270005002700202O00270027005700122O002900A36O002A3O000200302O002A000900A400302O002A005400534O0027002A00024O00283O000100302O002800A500A600122O002900A73O00202O0029002900A800122O002A00A96O00290002000200122O002A00A73O00202O002A002A00A800122O002B00AA6O002C00296O002A002C000200302O002900AB00AC00302O002900AD005300302O002900AE001600302O002900AF006200122O002B00113O00202O002B002B00A800122O002C00B03O00122O002D00623O00122O002E00B03O00122O002F00626O002B002F000200102O00290010002B00122O002B00B23O00202O002B002B00B300122O002C00B43O00122O002D00B43O00122O002E00B46O002B002E000200102O002A00B1002B00302O002A00B500B600122O002B00113O00202O002B002B00A800122O002C00B73O00122O002D00B83O00122O002E00B73O00122O002F00B86O002B002F000200102O002A0010002B00302O002A00B900BA00122O002B00B23O00202O002B002B00A800122O002C00BC3O00122O002D00BD3O00122O002E00BE6O002B002E000200102O002A00BB002B00302O002A00B9006200302O002A00BF00C000202O002B002800A500102O002A00C1002B00122O002B00B23O00202O002B002B00B300122O002C00B43O00122O002D00B43O00122O002E00B46O002B002E000200102O002A00C2002B4O002B5O000674002C0023000100012O005F3O002B3O002059002D00270056000674002F0024000100012O005F3O002C4O008C002D002F000100122O002D00023O00202O002D002D001D00122O002F00C36O002D002F000200202O002D002D00C400202O002D002D0097000674002F0025000100032O005F3O002B4O005F3O002A4O005F3O00294O0039002D002F000100202O002D0005002A00202O002D002D00394O002F3O000300302O002F000900C500302O002F003B00C600067400300026000100012O005F3O00033O00108F002F003D00304O002D002F000100202O002D0005002A00202O002D002D00394O002F3O000300302O002F000900C700302O002F003B00C800067400300027000100012O005F3O00033O00108F002F003D00304O002D002F000100202O002D0005002A00202O002D002D00394O002F3O000300302O002F000900C900302O002F003B00CA00067400300028000100012O005F3O00033O00108F002F003D00304O002D002F000100202O002D0005002A00202O002D002D00394O002F3O000300302O002F000900CB00302O002F003B00CC00067400300029000100012O005F3O00033O00106A002F003D00304O002D002F00014O00075O00202O0007000100CD4O00098O00070009000100202O0007000200CD4O00098O00070009000100202O0007000100CE2O00A200070002000100204E0007000100CF4O00098O00070009000100202O0007000200D000122O000900D16O00070009000100202O0007000100D000122O000900D26O00070009000100202O0007000200D300201700090005002D2O000600070009000100202O0007000100D400202O00090005002D4O00070009000100202O0007000300D500122O000900556O00070009000100202O00073O00D64O00093O000300302O0009000900D70030380009003200D800309F000900D900DA4O00070009000100202O0007000100DB4O0007000200019O006O00013O002A3O00013O0003053O00737061776E00043O00127B3O00013O00021400016O00A23O000200012O00893O00013O00013O000E3O00028O00026O00F03F03063O0069706169727303063O00706C6179657203093O00436861726163746572030E3O0047657444657363656E64616E74732O033O0049734103083O00426173655061727403083O0056656C6F63697479030B3O00526F7456656C6F6369747903043O007761697403073O00566563746F72332O033O006E657703053O0064656C617900463O00127C3O00014O0073000100033O000E8E0001000700013O0004713O0007000100127C000100014O0073000200023O00127C3O00023O00266E3O0002000100020004713O000200012O0073000300033O00266E00010029000100020004713O0029000100061600020045000100010004713O0045000100127C000400013O00266E0004000F000100010004713O000F000100127B000500033O001296000600043O00202O00060006000500202O0006000600064O000600076O00053O000700044O00210001002017000A000900072O005F000B00093O00127C000C00084O0091000A000C000200061E000A002100013O0004713O002100012O005F000A00033O0010500009000A000300105000090009000A00064100050018000100020004713O0018000100127B0005000B4O00100005000100010004713O000C00010004713O000F00010004713O000C00010004713O0045000100266E0001000A000100010004713O000A000100127C000400013O00266E0004003D000100010004713O003D00012O002700055O0012820006000C3O00202O00060006000D00122O000700013O00122O000800013O00122O000900016O0006000900024O000300066O000200053O00122O0005000E3O00122O000600023O00067400073O000100012O005F3O00024O00A700050007000100127C000400023O00266E0004002C000100020004713O002C000100127C000100023O0004713O000A00010004713O002C00010004713O000A00010004713O004500010004713O000200012O00893O00013O00018O00034O00273O00014O003F8O00893O00017O00033O0003093O00776F726B737061636503073O0047726176697479024O0080842E4100033O00127B3O00013O0030383O000200032O00893O00017O00033O00028O0003053O007461626C6503043O0066696E6401113O00127C000100014O0073000200023O00266E00010002000100010004713O0002000100127B000300023O00200F0003000300034O00048O00058O0003000500024O000200033O00062O0002001000013O0004713O001000012O0080000300014O002C0003000300020004713O001000010004713O000200012O00893O00017O00113O00028O0003053O007461626C6503043O0066696E6403053O0056616C7565026O00F03F03093O00436861726163746572030E3O0046696E6446697273744368696C6403103O0048756D616E6F6964522O6F745061727403063O00434672616D652O033O006E6577026O000840027O004003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203043O0077616974029A5O99B93F00564O00807O00061E3O005500013O0004713O0055000100127C3O00014O0073000100013O00266E3O004D000100010004713O004D000100127C000200013O00266E00020048000100010004713O0048000100127B000300023O00204F0003000300034O000400016O000500023O00202O0005000500044O0003000500024O000100033O00062O0001004700013O0004713O0047000100127C000300014O0073000400063O00266E0003001A000100010004713O001A000100127C000400014O0073000500053O00127C000300053O00266E00030015000100050004713O001500012O0073000600063O00266E00040034000100050004713O0034000100061E0006004700013O0004713O0047000100201700070006000600061E0007004700013O0004713O0047000100201700070006000600205900070007000700127C000900084O009100070009000200061E0007004700013O0004713O0047000100201700070006000600202800070007000800122O000800093O00202O00080008000A00202O00090005000500202O000A0005000B00202O000B0005000C4O0008000B000200102O00070009000800044O0047000100266E0004001D000100010004713O001D000100127C000700013O00266E0007003B000100050004713O003B000100127C000400053O0004713O001D000100266E00070037000100010004713O003700012O0080000800034O000100050008000100122O0008000D3O00202O00080008000E00202O00060008000F00122O000700053O00044O003700010004713O001D00010004713O004700010004713O0015000100127C000200053O00266E00020008000100050004713O0008000100127C3O00053O0004713O004D00010004713O0008000100266E3O0005000100050004713O0005000100127B000200103O00127C000300114O00A20002000200010004715O00010004713O000500010004715O00012O00893O00017O00043O00028O00030C3O004C2O6F705470546F2O676C6503053O0056616C756503053O00737061776E00103O00127C3O00013O00266E3O0001000100010004713O000100012O0080000100013O00200E00010001000200202O0001000100034O00018O00015O00062O0001000F00013O0004713O000F000100127B000100044O0080000200024O00A20001000200010004713O000F00010004713O000100012O00893O00019O002O0001064O008000015O00061E0001000500013O0004713O000500012O0080000100014O00100001000100012O00893O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001253000100013O00122O000200026O00038O0001000300016O00017O00023O0003093O00776F726B737061636503073O004772617669747901033O00127B000100013O001050000100024O00893O00017O00113O00028O00026O00F03F03043O0077616974026O00084003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403083O0048756D616E6F6964026O004940030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303053O0050756E6368030A3O0046697265536572766572029A5O99D93F002F4O00807O00061E3O002E00013O0004713O002E000100127C3O00014O0073000100013O00266E3O000B000100020004713O000B000100127B000200033O00127C000300044O00A20002000200010004715O000100266E3O0005000100010004713O0005000100127B000200053O00201700020002000600201700010002000700061E0001002B00013O0004713O002B000100201700020001000800061E0002002B00013O0004713O002B000100201700020001000800205900020002000900127C0004000A4O009100020004000200061E0002002B00013O0004713O002B000100127C000200023O00127C0003000B3O00127C000400023O0004600002002B000100127B000600053O00202F00060006000C00122O0008000D6O00060008000200202O00060006000E00202O00060006000F00202O00060006001000122O000800113O00122O000900013O00122O000A00026O0006000A00010004220002001F000100127C3O00023O0004713O000500010004715O00012O00893O00017O00043O00028O00030B3O0050756E6368546F2O676C6503053O0056616C756503053O00737061776E00103O00127C3O00013O00266E3O0001000100010004713O000100012O0080000100013O00200E00010001000200202O0001000100034O00018O00015O00062O0001000F00013O0004713O000F000100127B000100044O0080000200024O00A20001000200010004713O000F00010004713O000100012O00893O00017O00173O00028O00027O0040026O00F03F03043O0077616974026O002440029A5O99C93F029A5O99B93F03083O00746F6E756D62657203083O00746F737472696E672O033O00737562027O00C003043O006D6174682O033O006D696E03043O007461736B03053O00737061776E0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E7473030E3O00557067726164654162696C697479030C3O00496E766F6B65536572766572026O005940025C3O00127C000200014O0073000300053O00266E00020046000100020004713O00460001000E350001005B000100050004713O005B000100127C000600014O0073000700093O00266E0006003D000100030004713O003D00012O0073000900093O00266E00070016000100020004713O0016000100127B000A00043O000E3500050013000100090004713O0013000100127C000B00063O000616000B0014000100010004713O0014000100127C000B00074O00A2000A000200010004713O0043000100266E00070023000100030004713O002300012O00AA0005000500080012A3000A00083O00122O000B00096O000C00056O000B0002000200202O000B000B000A00122O000D000B6O000B000D6O000A3O00024O0009000A3O00122O000700023O00266E0007000B000100010004713O000B000100127C000A00013O00266E000A0036000100010004713O0036000100127B000B000C3O00205E000B000B000D4O000C00046O000D00056O000B000D00024O0008000B3O00122O000B000E3O00202O000B000B000F000674000C3O000100032O005F3O00084O005F3O00034O005F8O00A2000B0002000100127C000A00033O00266E000A0026000100030004713O0026000100127C000700033O0004713O000B00010004713O002600010004713O000B00010004713O00430001000E8E00010008000100060004713O0008000100127C000700014O0073000800083O00127C000600033O0004713O000800012O002A00065O0004713O000400010004713O005B000100266E00020055000100010004713O005500010026483O004C000100100004713O004C000100266E0001004D000100100004713O004D00012O00893O00013O00127B000600113O00205100060006001200122O000800136O00060008000200202O00060006001400202O00060006001500202O00030006001600122O000200033O000E8E00030002000100020004713O0002000100127C000400174O005F000500013O00127C000200023O0004713O000200012O00893O00013O00013O00063O00026O00F03F03043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E7473030E3O00557067726164654162696C697479000F3O00127C3O00014O008000015O00127C000200013O0004603O000E00012O0080000400013O00128B000500023O00202O00050005000300122O000700046O00050007000200202O00050005000500202O0005000500064O000600026O0004000600010004223O000400012O00893O00017O00043O00028O00030B3O005374617473546F2O676C6503053O0056616C756503053O00737061776E00193O00127C3O00014O0073000100013O00266E3O0002000100010004713O0002000100127C000100013O000E8E00010005000100010004713O000500012O0080000200013O00200E00020002000200202O0002000200034O00028O00025O00062O0002001800013O0004713O0018000100127B000200043O00067400033O000100032O00808O00803O00024O00803O00014O00A20002000200010004713O001800010004713O000500010004713O001800010004713O000200012O00893O00013O00013O00053O00028O0003083O00737472656E677468026O00F03F030B3O005374617473546F2O676C6503053O0056616C756500124O00807O00061E3O001100013O0004713O0011000100127C3O00013O00266E3O0004000100010004713O000400012O0080000100013O001295000200023O00122O000300036O0001000300014O000100023O00202O00010001000400202O0001000100054O00015O00046O00010004713O000400010004715O00012O00893O00017O00093O0003063O004469616C6F6703053O005469746C65030C3O00436F6E6669726D6174696F6E03073O00436F6E74656E7403303O0041726520796F75207375726520752077616E7420746F2072756E2074686520416E74692049646C652073797374656D3F03073O0042752O746F6E7303073O00436F6E6669726D03083O0043612O6C6261636B03063O0043616E63656C00134O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700067400053O000100012O00803O00013O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O006E3O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C61796572030C3O0057616974466F724368696C6403093O00506C61796572477569030E3O0046696E6446697273744368696C6403193O00416E746949646C654B69636B65724D6178546865446576323103063O004E6F7469667903053O005469746C65030C3O004E6F74696669636174696F6E03073O00436F6E74656E7403243O00416E74692049646C652073797374656D20697320616C72656164792072752O6E696E672E030A3O00537562436F6E74656E7403293O0054686973206D652O736167652077692O6C2064692O73617065617220696E2035207365636F6E64732E03083O004475726174696F6E026O001440028O00026O00264003063O00506172656E7403103O004261636B67726F756E64436F6C6F723303063O00436F6C6F723303073O0066726F6D524742025O00E06F4003163O004261636B67726F756E645472616E73706172656E6379026O00F03F03083O00506F736974696F6E03053O005544696D322O033O006E65770243BD48003164913F02F60AEADF1E19BE3F03043O0053697A6502F78A2AA0A9F7EE3F023BA827A04704E83F03043O00466F6E7403043O00456E756D03083O0053617270616E636803043O005465787403283O005765206A7573742073746F2O70656420726F626C6F782066726F6D206B69636B696E6720796F7521026O002840026O00224003113O0055702054696D653A20304820304D203053030A3O0054657874436F6C6F7233025O00405540030A3O00546578745363616C65642O0103083O005465787453697A65026O002C40030B3O00546578745772612O706564030B3O00417370656374526174696F028FC2F5285C4F2640026O002440026O001840030C3O00436F726E657252616469757303043O005544696D026O00104002295C8FC2F528F03F03043O004E616D6503063O00486561646572026O001C400283F725803ADCCF3F0277040D409E32B73F022CC53F80CDA8E53F02743BEC9F561AD43F03153O00416E74692D49646C65204B69636B65722076322E30026O002040020C022B8716992440030B3O0054696D65446973706C61790261BD42001F85DB3F0267E7CFDFCDA8E53F029BBC5E205C8FD23F02F0A7C64B37493240030C3O004D6F76654775694672616D65029A5O99C93F02BD7B54002B87963F02BD7E34A0C64BB73F023C880F7F5CC1C53F020A730EE025BFE93F03103O004B69636B4D652O736167654672616D65026O004840029A5O99B93F023O0080EFE2813E02FD0B2D80632ED8BF02FA02A3602O00F03F020BF280A0461BD63F03073O0056697369626C650100026O002A40021F85EB51B81E134003093O00636F726F7574696E6503043O0077726170026O00084002AC81CC1FEA76D93F0262CF64204B76DE3F023E971B9FD8E9C73F02FFA62F40EDBBB33F03063O004D616465427903083O00496E7374616E636503083O005549436F726E657203093O00546578744C6162656C027O004003093O005363722O656E47756903053O004672616D6503173O005549417370656374526174696F436F6E73747261696E7402643BDF4F8DD7314002068195438BAC2B40030C3O0052657365744F6E537061776E02A0E8DDFF97F0E83F021A803BC0FBA9E53F02845DFB9F4FA6C63F03133O004D616465204279204D6178546865446576323100D3012O00125C3O00013O00206O000200206O000300206O000400122O000200058O0002000200202O00013O000600122O000300076O00010003000200062O0001001400013O0004713O001400012O008000015O00205D0001000100084O00033O000400302O00030009000A00302O0003000B000C00302O0003000D000E00302O0003000F00104O00010003000100044O00D22O0100127C000100114O0073000200143O00266E00010038000100120004713O00380001001050000F0013000E00100700100013000E00122O001500153O00202O00150015001600122O001600173O00122O001700173O00122O001800176O00150018000200102O00100014001500302O00100018001900122O0015001B3O00202O00150015001C00122O0016001D3O00122O001700113O00122O0018001E3O00122O001900116O00150019000200102O0010001A001500122O0015001B3O00202O00150015001C00122O001600203O00122O001700113O00122O001800213O00122O001900116O00150019000200102O0010001F001500122O001500233O00202O00150015002200202O00150015002400102O00100022001500302O00100025002600122O000100273O00266E0001004C000100280004713O004C000100127B001500233O00204000150015002200202O00150015002400102O000C0022001500302O000C0025002900122O001500153O00202O00150015001600122O0016002B3O00122O001700173O00122O001800116O00150018000200102O000C002A001500302O000C002C002D00302O000C002E002F00302O000C0030002D00102O000D0013000C00302O000D0031003200122O000100333O00266E00010062000100340004713O0062000100127B001500363O00202900150015001C00122O001600113O00122O001700376O00150017000200102O00080035001500102O00080013000700102O00090013000700302O00090031003800302O000A0039003A00102O000A0013000300122O001500153O00202O00150015001600122O001600173O00122O001700173O00122O001800176O00150018000200102O000A0014001500302O000A0018001900122O0001003B3O00266E000100840001003B0004713O0084000100127B0015001B3O00200400150015001C00122O0016003C3O00122O001700113O00122O0018003D3O00122O001900116O00150019000200102O000A001A001500122O0015001B3O00202O00150015001C00122O0016003E3O00122O001700113O00122O0018003F3O00122O001900116O00150019000200102O000A001F001500122O001500233O00202O00150015002200202O00150015002400102O000A0022001500302O000A0025004000122O001500153O00202O00150015001600122O0016002B3O00122O001700173O00122O001800116O00150018000200102O000A002A001500302O000A002C002D00302O000A002E002F00302O000A0030002D00122O000100413O00266E000100A3000100410004713O00A30001001050000B0013000A003090000B0031004200302O000C0039004300102O000C0013000300122O001500153O00202O00150015001600122O001600173O00122O001700173O00122O001800176O00150018000200102O000C0014001500302O000C0018001900122O0015001B3O00202O00150015001C00122O0016003C3O00122O001700113O00122O001800443O00122O001900116O00150019000200102O000C001A001500122O0015001B3O00202O00150015001C00122O001600453O00122O001700113O00122O001800463O00122O001900116O00150019000200102O000C001F001500122O000100283O00266E000100C2000100100004713O00C2000100105000060013000500309000060031004700302O00070039004800102O00070013000300122O001500153O00202O00150015001600122O0016002B3O00122O001700173O00122O001800116O00150018000200102O00070014001500302O00070018004900122O0015001B3O00202O00150015001C00122O0016004A3O00122O001700113O00122O0018004B3O00122O001900116O00150019000200102O0007001A001500122O0015001B3O00202O00150015001C00122O0016004C3O00122O001700113O00122O0018004D3O00122O001900116O00150019000200102O0007001F001500122O000100343O00266E000100E6000100330004713O00E60001003038000E0039004E001092000E0013000300122O001500153O00202O00150015001600122O0016004F3O00122O0017004F3O00122O0018004F6O00150018000200102O000E0014001500302O000E0018005000122O0015001B3O00202O00150015001C00122O001600513O00122O001700113O00122O001800523O00122O001900116O00150019000200102O000E001A001500122O0015001B3O00202O00150015001C00122O001600533O00122O001700113O00122O001800543O00122O001900116O00150019000200102O000E001F001500302O000E0055005600122O001500363O00202O00150015001C00122O001600113O00122O001700376O00150017000200102O000F0035001500122O000100123O00266E000100F3000100570004713O00F300010010500013001300030030380013003100582O0073001400143O00067400143O000100012O005F3O00033O001262001500593O00202O00150015005A4O001600146O0015000200024O00150001000100044O00D12O01000E8E005B00172O0100010004713O00172O0100127B0015001B3O00201900150015001C00122O0016005C3O00122O001700113O00122O0018005D3O00122O001900116O00150019000200102O0003001A001500122O0015001B3O00202O00150015001C00122O0016005E3O00122O001700113O00122O0018005F3O00122O001900116O00150019000200102O0003001F001500122O001500363O00202O00150015001C00122O001600113O00122O001700376O00150017000200102O00040035001500102O00040013000300302O00050039006000102O00050013000300122O001500153O00202O00150015001600122O001600173O00122O001700173O00122O001800176O00150018000200102O00050014001500302O00050018001900122O000100373O00266E000100532O0100110004713O00532O0100127C001500113O00266E001500272O0100190004713O00272O0100127B001600613O00208A00160016001C00122O001700626O0016000200024O000400163O00122O001600613O00202O00160016001C00122O001700636O0016000200024O000500163O00122O001500643O00266E001500342O0100110004713O00342O0100127B001600613O00208A00160016001C00122O001700656O0016000200024O000200163O00122O001600613O00202O00160016001C00122O001700666O0016000200024O000300163O00122O001500193O00266E001500412O0100640004713O00412O0100127B001600613O00208A00160016001C00122O001700676O0016000200024O000600163O00122O001600613O00202O00160016001C00122O001700666O0016000200024O000700163O00122O0015005B3O00266E001500452O0100370004713O00452O0100127C000100193O0004713O00532O0100266E0015001A2O01005B0004713O001A2O0100127B001600613O00208A00160016001C00122O001700626O0016000200024O000800163O00122O001600613O00202O00160016001C00122O001700676O0016000200024O000900163O00122O001500373O0004713O001A2O0100266E0001007E2O0100190004713O007E2O0100127B001500613O00209D00150015001C00122O001600636O0015000200024O000A00153O00122O001500613O00202O00150015001C00122O001600676O0015000200024O000B00153O00122O001500613O00202O00150015001C00122O001600636O0015000200024O000C00153O00122O001500613O00202O00150015001C00122O001600676O0015000200024O000D00153O00122O001500613O00202O00150015001C00122O001600666O0015000200024O000E00153O00122O001500613O00202O00150015001C00122O001600626O0015000200024O000F00153O00122O001500613O00202O00150015001C00122O001600636O0015000200024O001000153O00122O001500613O00202O00150015001C00122O001600676O0015000200024O001100153O00122O000100643O00266E0001008F2O0100270004713O008F2O0100127B001500153O00207800150015001600122O001600173O00122O001700113O00122O001800116O00150018000200102O0010002A001500302O0010002C002D00302O0010002E002F00302O00100030002D00102O00110013001000302O00110031006800102O00120013000E00302O00120031006900122O000100573O00266E000100AE2O0100640004713O00AE2O0100127B001500613O00203000150015001C00122O001600676O0015000200024O001200153O00122O001500613O00202O00150015001C00122O001600676O0015000200024O001300153O00302O00020039000700122O001500013O00202O00150015000200202O00150015000300202O00150015000400122O001700056O00150017000200102O00020013001500302O0002006A005600102O00030013000200122O001500153O00202O00150015001600122O0016004F3O00122O0017004F3O00122O0018004F6O00150018000200102O00030014001500302O00030018005000122O0001005B3O00266E00010016000100370004713O0016000100127B0015001B3O00201100150015001C00122O0016003C3O00122O001700113O00122O0018006B3O00122O001900116O00150019000200102O0005001A001500122O0015001B3O00202O00150015001C00122O0016006C3O00122O001700113O00122O0018006D3O00122O001900116O00150019000200102O0005001F001500122O001500233O00202O00150015002200202O00150015002400102O00050022001500302O00050025006E00122O001500153O00202O00150015001600122O0016002B3O00122O001700173O00122O001800116O00150018000200102O0005002A001500302O0005002C002D00302O0005002E002F00302O00050030002D00122O000100103O00044O001600012O002A00016O00893O00013O00013O001E3O0003083O00496E7374616E63652O033O006E6577030B3O004C6F63616C53637269707403063O00506172656E7403043O0067616D6503073O007365727669636503073O00506C6179657273030B3O004C6F63616C506C6179657203053O0049646C656403073O00436F2O6E656374030A3O004765745365727669636503103O0055736572496E70757453657276696365030C3O004D6F76654775694672616D65030A3O00496E707574426567616E030C3O00496E7075744368616E676564028O00026O00F03F027O0040026O004E4003043O006D61746803053O00666C2O6F7203043O0077616974025O0020AC40026O003840030B3O0054696D65446973706C617903043O005465787403093O0055702054696D653A2003023O00482003023O004D2003013O005300583O00126D3O00013O00206O000200122O000100036O00029O000002000200202O00013O000400122O000200053O00202O00020002000600122O000400076O00020004000200202O00020002000800202O00020002000900202O00020002000A00067400043O000100012O005F3O00014O004D00020004000100122O000200053O00202O00020002000B00122O0004000C6O0002000400024O000300053O00067400060001000100032O005F3O00044O005F3O00054O005F3O00013O00201700070001000D00201700070007000E00205900070007000A00067400090002000100042O005F3O00034O005F3O00044O005F3O00054O005F3O00014O00A700070009000100201700070002000F00205900070007000A00067400090003000100022O005F3O00034O005F3O00064O00A700070009000100127C000700103O00127C000800104O00730009000B3O00266E0008003C000100110004713O003C000100127C000C00103O00266E000C0032000100110004713O0032000100127C000800123O0004713O003C000100266E000C002E000100100004713O002E0001002008000900070013001244000D00143O00202O000D000D001500202O000E000700134O000D0002000200202O000A000D001300122O000C00113O00044O002E0001000E8E00100043000100080004713O0043000100127B000C00163O00127C000D00114O00A2000C0002000100206900070007001100127C000800113O000E8E0012002B000100080004713O002B000100127B000C00143O002026000C000C001500202O000D000700174O000C0002000200202O000B000C001800202O000C0001001900122O000D001B6O000E000B3O00122O000F001C6O0010000A3O00122O0011001D6O001200093O00122O0013001E6O000D000D001300102O000C001A000D00044O002900010004713O002B00010004713O002900012O00893O00013O00043O000F3O00028O0003043O0067616D6503073O0073657276696365030B3O005669727475616C5573657203113O0043617074757265436F6E74726F2O6C6572026O00F03F030C3O00436C69636B42752O746F6E3203073O00566563746F72322O033O006E657703103O004B69636B4D652O736167654672616D6503073O0056697369626C6501002O0103043O0077616974026O000840002C3O00127C3O00014O0073000100013O00266E3O000C000100010004713O000C000100127B000200023O0020AC00020002000300122O000400046O0002000400024O000100023O00202O0002000100054O00020002000100124O00063O000E8E0006000200013O0004713O0002000100205900020001000700129A000400083O00202O0004000400094O000400016O00023O00014O00025O00202O00020002000A00202O00020002000B00262O0002002B0001000C0004713O002B000100127C000200013O00266E00020022000100010004713O002200012O008000035O0020A400030003000A00302O0003000B000D00122O0003000E3O00122O0004000F6O00030002000100122O000200063O00266E00020019000100060004713O001900012O008000035O00201700030003000A0030380003000B000C0004713O002B00010004713O001900010004713O002B00010004713O000200012O00893O00017O00103O00028O0003083O00506F736974696F6E03053O005544696D322O033O006E657703013O005803053O005363616C6503063O004F2O6673657403013O0059026O00F03F03043O0067616D65030A3O0047657453657276696365030C3O0054772O656E5365727669636503063O0043726561746503093O0054772O656E496E666F027B14AE47E17A843F03043O00506C617901303O00127C000100014O0073000200033O00266E0001001C000100010004713O001C000100201700043O00022O000200058O00020004000500122O000400033O00202O0004000400044O000500013O00202O00050005000500202O0005000500064O000600013O00202O00060006000500202O00060006000700202O0007000200054O0006000600074O000700013O00202O00070007000800202O0007000700064O000800013O00202O00080008000800202O00080008000700202O0009000200084O0008000800094O0004000800024O000300043O00122O000100093O00266E00010002000100090004713O0002000100127B0004000A3O00208300040004000B00122O0006000C6O00040006000200202O00040004000D4O000600023O00122O0007000E3O00202O00070007000400122O0008000F6O0007000200024O00083O000100102O0008000200034O00040008000200202O0004000400104O00040002000100044O002F00010004713O000200012O00893O00017O00073O00030D3O0055736572496E7075745479706503043O00456E756D030C3O004D6F75736542752O746F6E3103053O00546F75636803083O00506F736974696F6E03073O004368616E67656403073O00436F2O6E656374011A3O00200A00013O000100122O000200023O00202O00020002000100202O00020002000300062O0001000C000100020004713O000C000100201700013O000100127B000200023O00201700020002000100201700020002000400060B00010019000100020004713O001900012O0027000100014O006B00015O00202O00013O00054O000100016O000100033O00202O0001000100054O000100023O00202O00013O000600202O00010001000700067400033O000100022O005F8O00808O00A70001000300012O00893O00013O00013O00033O00030E3O0055736572496E707574537461746503043O00456E756D2O033O00456E64000A4O005B7O00206O000100122O000100023O00202O00010001000100202O00010001000300064O0009000100010004713O000900012O00278O003F3O00014O00893O00017O00043O00030D3O0055736572496E7075745479706503043O00456E756D030D3O004D6F7573654D6F76656D656E7403053O00546F75636801133O00200A00013O000100122O000200023O00202O00020002000100202O00020002000300062O0001000C000100020004713O000C000100201700013O000100127B000200023O00201700020002000100201700020002000400060B00010012000100020004713O001200012O008000015O00061E0001001200013O0004713O001200012O0080000100014O005F00026O00A20001000200012O00893O00017O00023O0003053O007072696E7403153O0043616E63652O6C656420746865206469616C6F672E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001253000100013O00122O000200026O00038O0001000300016O00017O00063O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O0057616C6B53702O656401073O001299000100013O00202O00010001000200202O00010001000300202O00010001000400202O00010001000500102O000100068O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001253000100013O00122O000200026O00038O0001000300016O00017O00063O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203083O0048756D616E6F696403093O004A756D70506F77657201073O001299000100013O00202O00010001000200202O00010001000300202O00010001000400202O00010001000500102O000100068O00017O00013O00030D3O00627265616B76656C6F6369747900033O00127B3O00014O00103O000100012O00893O00017O00093O0003063O004469616C6F6703053O005469746C65030F3O0052657365742043686172616374657203073O00436F6E74656E74032D3O0041726520796F75207375726520796F752077616E7420746F20726573657420746865206368617261637465723F03073O0042752O746F6E7303073O00436F6E6669726D03083O0043612O6C6261636B03063O0043616E63656C00124O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700021400055O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O00053O0003043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030B3O00427265616B4A6F696E747300073O0012093O00013O00206O000200206O000300206O000400206O00056O000200016O00017O00023O0003053O007072696E7403153O0043616E63652O6C656420746865206469616C6F672E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00073O0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303093O005472616E73666F726D030A3O004669726553657276657203093O006D6574616C536B696E01183O00061E3O000D00013O0004713O000D000100127B000100013O00207A00010001000200122O000300036O00010003000200202O00010001000400202O00010001000500202O00010001000600122O000300076O000400016O0001000400010004713O0017000100127B000100013O00207A00010001000200122O000300036O00010003000200202O00010001000400202O00010001000500202O00010001000600122O000300076O00048O0001000400012O00893O00017O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E7403303O00546865206B657962696E64696E67206F66206D6574616C736B696E2068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00977O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00017O00013O0003053O00737061776E00043O00127B3O00013O00021400016O00A23O000200012O00893O00013O00013O000D3O0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303113O00546F2O676C6554656C656B696E65736973030C3O00496E766F6B6553657276657203073O00566563746F72332O033O006E6577028O0003073O00506C6179657273030B3O004C6F63616C506C6179657203043O004E616D6503093O0043686172616374657200183O0012243O00013O00206O000200122O000200038O0002000200206O000400206O000500206O000600122O000200073O00202O00020002000800122O000300093O00122O000400093O00122O000500096O0002000500024O00035O00122O000400013O00202O00040004000A00122O000500013O00202O00050005000A00202O00050005000B00202O00050005000C4O00040004000500202O00040004000D6O000400016O00017O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E74032B3O00546865206B657962696E64696E67206F66206D61736B2068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00977O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00017O00093O0003043O0067616D65030A3O004765745365727669636503113O005265706C69636174656453746F7261676503063O004576656E747303053O0050756E6368030A3O0046697265536572766572029A5O99D93F029A5O99B93F026O00F03F000C3O00122B3O00013O00206O000200122O000200038O0002000200206O000400206O000500206O000600122O000200073O00122O000300083O00122O000400098O000400016O00017O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E7403313O00546865206B657962696E64696E67206F6620666972652070756E63682068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00977O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00019O002O0001024O003F8O00893O00017O00023O0003053O007072696E7403133O00536C6964657220776173206368616E6765643A01053O001253000100013O00122O000200026O00038O0001000300016O00019O002O0001024O003F8O00893O00017O00053O00028O00030A3O0046697265536572766572029A5O99B93F026O00F03F03043O007761697400184O00807O00061E3O001700013O0004713O001700012O00803O00013O00061E3O001700013O0004713O0017000100127C3O00013O00266E3O0007000100010004713O000700012O0080000100023O00209300010001000200122O000300013O00122O000400033O00122O000500046O00010005000100122O000100056O000200036O00010002000100046O00010004713O000700010004715O00010004713O001700010004715O00012O00893O00019O003O00014O00893O00017O000A3O0003063O004E6F7469667903053O005469746C6503153O00486561646C652O73204E6F74696669636174696F6E03073O00436F6E74656E7403313O00546865206B657962696E64696E67206F6620666972652070756E63682068616420622O656E206368616E67656420746F2003053O0056616C7565030A3O00537562436F6E74656E74031A3O00546869732063616E206265206368616E67656420616761696E2103083O004475726174696F6E026O001440000D4O00977O00206O00014O00023O000400302O00020002000300122O000300056O000400013O00202O0004000400064O00030003000400102O00020004000300302O00020007000800302O00020009000A6O000200016O00017O00063O0003073O004B6579436F646503043O00456E756D03053O0056616C7565028O0003093O00636F726F7574696E6503043O0077726170021D3O0006160001001C000100010004713O001C000100201700023O000100127D000300023O00202O0003000300014O00045O00202O0004000400034O00030003000400062O0002001C000100030004713O001C000100127C000200044O0073000300033O00266E0002000C000100040004713O000C000100127C000300043O00266E0003000F000100040004713O000F00012O0027000400014O0049000400013O00122O000400053O00202O0004000400064O000500026O0004000200024O00040001000100044O001C00010004713O000F00010004713O001C00010004713O000C00012O00893O00017O00033O0003073O004B6579436F646503043O00456E756D03053O0056616C7565020D3O0006160001000C000100010004713O000C000100201700023O000100127D000300023O00202O0003000300014O00045O00202O0004000400034O00030003000400062O0002000C000100030004713O000C00012O002700026O003F000200014O00893O00017O00043O00028O00030B3O004A756D705265717565737403073O00436F2O6E656374030A3O00446973636F2O6E65637401183O00061E3O001100013O0004713O0011000100127C000100013O00266E00010003000100010004713O000300012O002700026O003F00026O0080000200023O00201700020002000200205900020002000300067400043O000100012O00808O00910002000400022O003F000200013O0004713O001700010004713O000300010004713O001700012O0080000100013O00061E0001001700013O0004713O001700012O0080000100013O0020590001000100042O00A20001000200012O00893O00013O00013O000D3O00028O00026O00F03F03043O007761697403043O0067616D6503073O00506C6179657273030B3O004C6F63616C506C6179657203093O0043686172616374657203163O0046696E6446697273744368696C64576869636849734103083O0048756D616E6F6964030B3O004368616E6765537461746503043O00456E756D03113O0048756D616E6F696453746174655479706503073O004A756D70696E67001E4O00807O0006163O001D000100010004713O001D000100127C3O00013O000E8E0002000B00013O0004713O000B000100127B000100034O00100001000100012O002700016O003F00015O0004713O001D000100266E3O0004000100010004713O000400012O0027000100014O007E00015O00122O000100043O00202O00010001000500202O00010001000600202O00010001000700202O00010001000800122O000300096O00010003000200202O00010001000A00122O0003000B3O00202O00030003000C00202O00030003000D4O00010003000100124O00023O00044O000400012O00893O00017O00033O0003083O00632O6F6C446F776E028O00026O00144001083O00061E3O000500013O0004713O000500012O008000015O0030380001000100020004713O000700012O008000015O0030380001000100032O00893O00017O000C3O00028O0003053O00706169727303043O0067616D65030A3O004765745365727669636503073O00506C6179657273030A3O00476574506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403043O00486561642O033O0065737003073O0044657374726F79013A3O00127C000100014O0073000200023O000E8E00010002000100010004713O0002000100127C000200013O00266E00020005000100010004713O000500012O003F7O0006163O0039000100010004713O0039000100127B000300023O001287000400033O00202O00040004000400122O000600056O00040006000200202O0004000400064O000400056O00033O000500044O0033000100127B000800033O00205A00080008000400122O000A00056O0008000A000200202O00080008000700062O00070033000100080004713O0033000100201700080007000800061E0008003300013O0004713O0033000100201700080007000800205900080008000900127C000A000A4O00910008000A000200061E0008003300013O0004713O0033000100127C000800014O0073000900093O000E8E00010025000100080004713O00250001002017000A000700080020790009000A000A00202O000A0009000900122O000C000B6O000A000C000200062O000A003300013O0004713O00330001002017000A0009000B002059000A000A000C2O00A2000A000200010004713O003300010004713O0025000100064100030013000100020004713O001300010004713O003900010004713O000500010004713O003900010004713O000200012O00893O00019O002O0001044O008000016O005F00026O00A20001000200012O00893O00017O000F3O0003053O00706169727303043O0067616D65030A3O004765745365727669636503073O00506C6179657273030A3O00476574506C6179657273030B3O004C6F63616C506C6179657203093O00436861726163746572030E3O0046696E6446697273744368696C6403043O00486561642O033O00657370028O0003043O005465787403043O004E616D6503053O00436C6F6E6503063O00506172656E7400344O00807O00061E3O003300013O0004713O0033000100127B3O00013O001287000100023O00202O00010001000300122O000300046O00010003000200202O0001000100054O000100029O00000200044O0031000100127B000500023O00205A00050005000300122O000700046O00050007000200202O00050005000600062O00040031000100050004713O0031000100201700050004000700061E0005003100013O0004713O0031000100201700050004000700205900050005000800127C000700094O009100050007000200061E0005003100013O0004713O0031000100201700050004000700205600050005000900202O00050005000800122O0007000A6O00050007000200062O00050031000100010004713O0031000100127C0005000B3O00266E000500240001000B0004713O002400012O0080000600013O00206700070004000D00102O0006000C00074O000600023O00202O00060006000E4O00060002000200202O00070004000700202O00070007000900102O0006000F000700044O003100010004713O002400010006413O000C000100020004713O000C00012O00893O00017O00093O0003063O004469616C6F6703053O005469746C6503163O004578656375746520496E66696E697465205969656C6403073O00436F6E74656E7403313O00446F20796F752077616E7420746F20657865637574652074686520496E66696E697465205969656C64207363726970743F03073O0042752O746F6E732O033O0059657303083O0043612O6C6261636B03023O004E6F00124O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700021400055O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O00043O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403443O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F4564676549592F696E66696E6974657969656C642F6D61737465722F736F7572636500083O0012663O00013O00122O000100023O00202O00010001000300122O000300046O000100039O0000026O000100016O00017O00023O0003053O007072696E74031B3O0043616E63652O6C65642073637269707420657865637574696F6E2E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00093O0003063O004469616C6F6703053O005469746C6503153O004578656375746520536372697074204E652O62696103073O00436F6E74656E7403293O00446F20796F752077616E7420746F20657865637574652074686520536372697074204E652O6269613F03073O0042752O746F6E732O033O0059657303083O0043612O6C6261636B03023O004E6F00124O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700021400055O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O00043O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403943O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F4465764D6963746C616E7465637568746C692F4D6963746C616E7465637568746C692D532D412D432D562F41712F334430363034323134434641354642444137323641384639313237353936413437342O374338443746303934303742343234323035393533312O3730354638462E6C756100083O0012663O00013O00122O000100023O00202O00010001000300122O000300046O000100039O0000026O000100016O00017O00023O0003053O007072696E74031B3O0043616E63652O6C65642073637269707420657865637574696F6E2E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00093O0003063O004469616C6F6703053O005469746C65030E3O00457865637574652053637269707403073O00436F6E74656E74032E3O00446F20796F752077616E7420746F2065786563757465207468652043796C696E64726963616C207363726970743F03073O0042752O746F6E732O033O0059657303083O0043612O6C6261636B03023O004E6F00124O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700021400055O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O00043O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403693O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F4465764D6963746C616E7465637568746C692F4D6963746C616E7465637568746C692D532D412D432D562F41712F4544383544364230352D43796C696E64726963616C2E6C756100083O0012663O00013O00122O000100023O00202O00010001000300122O000300046O000100039O0000026O000100016O00017O00023O0003053O007072696E74031B3O0043616E63652O6C65642073637269707420657865637574696F6E2E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00093O0003063O004469616C6F6703053O005469746C6503143O004578656375746520446578204578706C6F72657203073O00436F6E74656E74032F3O00446F20796F752077616E7420746F20657865637574652074686520446578204578706C6F726572207363726970743F03073O0042752O746F6E732O033O0059657303083O0043612O6C6261636B03023O004E6F00124O00647O00206O00014O00023O000300302O00020002000300302O0002000400054O000300026O00043O000200302O00040002000700021400055O0010500004000800052O000C00053O0002003038000500020009000214000600013O0010500005000800062O00A90003000200010010500002000600032O00A73O000200012O00893O00013O00023O00063O00030A3O006C6F6164737472696E6703043O0067616D65030A3O004765744F626A6563747303173O00726278612O73657469643A2O2F3231382O30382O343738026O00F03F03063O00536F75726365000A3O00124C3O00013O00122O000100023O00202O00010001000300122O000300046O00010003000200202O00010001000500202O0001000100066O000200026O000100016O00017O00023O0003053O007072696E74031B3O0043616E63652O6C65642073637269707420657865637574696F6E2E00043O00127B3O00013O00127C000100024O00A23O000200012O00893O00017O00", GetFEnv(), ...);
