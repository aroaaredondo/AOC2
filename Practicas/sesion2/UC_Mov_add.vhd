----------------------------------------------------------------------------------
-- IMPORTANTE: CADA ESTUDIANTE DEBE COMPLETAR SUS DATOS 
-- Name: Aroa Redondo Zamora
-- NIA: 
-- Create Date:    
-- Module Name:    UC_Mov_Add
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC_Mov_Add is
	generic (	propagation_delay: time := 3 ns --propagation delay of the UC; The remaining delays (We asume that the delay of the state register, and its Tsup are negligible)
    		);  
    Port ( 	clk : in  STD_LOGIC;
		   	reset : in  STD_LOGIC;
    		op_code : in  STD_LOGIC_VECTOR (10 downto 0);
			PC_ce : out  STD_LOGIC;
    		load_A : out  STD_LOGIC;
			load_B : out  STD_LOGIC;
			load_ALUout : out  STD_LOGIC;          
    		RegWr : out  STD_LOGIC;
           	MUX_ctrl : out  STD_LOGIC
		   );
end UC_Mov_Add;

architecture Behavioral of UC_Mov_Add is

    -- define constantes para mejorar la legibilidad del c�digo
    -- El valor "01 es un ejemplo. Pon los valores que t� hayas usado. 
	CONSTANT MOV_opcode : STD_LOGIC_VECTOR := "00000000001";
	CONSTANT HALT_opcode :STD_LOGIC_VECTOR := "00000000010"; 
	CONSTANT ADD_opcode : STD_LOGIC_VECTOR := "00000000000";
	-- Asignamos los nombres que queramos a los estados para mejorar la legibilidad del c�digo
	-- Los nombres que aqu� aparecen son ejemplos
	type state_type is (Fetch_Dec, MOV, HALT, ADD_Load, ADD_Aluout, ADD_Cargar ); 
	signal state, next_state : state_type; 
	signal internal_RegWr, internal_MUX_ctrl, internal_load_A, internal_load_B, internal_load_ALUout, internal_PC_ce : STD_LOGIC; 
	begin
	
	-- State Register
	--We do not use the component register because we do not want to codify the states, but use their names instead.
	State_reg: process (clk)
	   begin
	      if (clk'event and clk = '1') then
	         if (reset = '1') then
	            state <= Fetch_Dec;
	         else
	            state <= next_state;
	         end if;        
	      end if;
	   end process;
	
	UC_outputs : process (state)
	begin 
		-- Por defecto ponemos todas las se�ales a 0 que es el valor que garantiza que no alteramos nada
		-- As� luego s�lo hay que poner las se�ales que deben estar a '1'
		internal_PC_ce <= '0'; 
		internal_RegWr <= '0'; 
		internal_MUX_ctrl <= '0'; 
		internal_load_A <= '0'; 
		internal_load_B <= '0'; 
		internal_load_ALUout <= '0';
		CASE state IS
			--Fetch_Dec 
			-- This is an example of possible actions for the first state. 
			-- Modify them, including your own actions 
			WHEN  Fetch_Dec  	=> 
			WHEN  MOV  			=> internal_MUX_ctrl <= '1'; internal_RegWr <= '1'; internal_Pc_ce <= '1';
			WHEN  HALT  		=>  
			WHEN  ADD_Load  	=> internal_load_A <= '1'; internal_load_B <= '1';
			WHEN  ADD_Aluout  	=> internal_load_ALUout <= '1'; 
			WHEN  ADD_Cargar  	=> internal_RegWr <= '1'; internal_Mux_ctrl <= '0'; internal_Pc_ce <= '1';
			-- Add all the states
			-- para asegurarte que se cubren todos los casos 
			WHEN OTHERS 	  	=> 
		END CASE;
	end process;
	
	UC_next_state : process (state, op_code)
	begin 		
		CASE state IS
			-- First state of the execution
			WHEN  Fetch_Dec  	=>  If (op_code = MOV_opcode) then next_state <= MOV;
									ELSIF (op_code = HALT_opcode) then next_state <= HALT;
									ELSE  next_state <= ADD_Load; 
									END IF;
			WHEN  MOV  	=> 	next_state <= Fetch_Dec;
			WHEN  HALT  	=> 	next_state <= HALT;
			WHEN  ADD_Load  	=> 	next_state <= ADD_Aluout;
			WHEN  ADD_Aluout  	=> 	next_state <= ADD_Cargar;
			WHEN  ADD_Cargar  	=> 	next_state <= Fetch_Dec;
			-- Add your states
			-- para asegurarte que se cubren todos los casos 
			WHEN OTHERS 	  	=> next_state <= Fetch_Dec; 
		END CASE;
	end process;
	-- Delays
	RegWr <= internal_RegWr after propagation_delay;
	MUX_ctrl <= internal_MUX_ctrl after propagation_delay;
	PC_ce <= internal_PC_ce after propagation_delay;
    load_A <= internal_load_A after propagation_delay;
    load_B <= internal_load_B after propagation_delay;
	load_ALUout <= internal_load_ALUout after propagation_delay;      

end Behavioral;



