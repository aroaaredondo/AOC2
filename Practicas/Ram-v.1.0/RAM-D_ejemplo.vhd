----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:12:11 04/04/2014 
-- Design Name: 
-- Module Name:    memoriaRAM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- Memoria RAM de 128 oalabras de 32 bits
entity Data_Memory_Subsystem is port (
	CLK : in std_logic;
	reset: in std_logic;
	ADDR : in std_logic_vector (31 downto 0); --Dir solicitada por el Mips
	Din : in std_logic_vector (31 downto 0);--entrada de datos desde el Mips
	WE : in std_logic;		-- write enable	del MIPS
	RE : in std_logic;		-- read enable del MIPS	
	Mem_ready: out std_logic; -- indica si podemos hacer la operaci�n solicitada en el ciclo actual. En esta memoria vale siempre '1'.
	Dout : out std_logic_vector (31 downto 0)); --dato que se env�a al Mips
end Data_Memory_Subsystem;

architecture Behavioral of Data_Memory_Subsystem is
type RamType is array(0 to 127) of std_logic_vector(31 downto 0);
signal RAM : RamType := (  X"00000000", X"00000118", X"00000001", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", -- palabras 0,1,2,3,4,5,6,7
									X"000000BB", X"11220044", X"FFFFFFFF", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --palabras 8,9,...
									X"00000000", X"20000000", X"30018001", X"00000000", X"30008001", X"00000000", X"00000000", X"00000000", --palabras 16,17,18,19,20,21,22,23
									X"00000000", X"20000000", X"30004000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000002",
									X"00000000", X"00000002", X"00000000", X"00000000", X"00000000", X"00000002", X"00000000", X"00000002",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"000C3500", X"0000C350", ---palabras 64,65,66,67,68,69,70,71
									X"000003E8", X"000002BC", X"0000003C", X"00000009", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000800", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000800", X"00000000", X"00080800", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00080000", X"00000000", X"00080000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");
signal dir_7:  std_logic_vector(6 downto 0); 
begin
 
 dir_7 <= ADDR(8 downto 2); -- como la memoria es de 128 plalabras no usamos la direcci�n completa sino s�lo 7 bits. Como se direccionan los bytes, pero damos palabras no usamos los 2 bits menos significativos
 MEM_ready <= '1'; --En esta versi�n la memoria siempre est� preparada
 process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE = '1') then -- s�lo se escribe si WE vale 1
                RAM(conv_integer(dir_7)) <= Din;
                -- la siguiente l�nea saca un aviso por pantalla con el dato que se ha escrito
                report "Simulation time : " & time'IMAGE(now) & ".  Data written: " & integer'image(to_integer(unsigned(Din))) & ", in ADDR = " & integer'image(to_integer(unsigned(ADDR)));
            end if;
        end if;
    end process;

    Dout <= RAM(conv_integer(dir_7)) when (RE='1') else "00000000000000000000000000000000"; --s�lo se lee si RE vale 1

end Behavioral;

