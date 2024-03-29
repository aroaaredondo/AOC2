-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
	COMPONENT MIPs_segmentado is
		Port ( 	
			clk : in  STD_LOGIC;
           	reset : in  STD_LOGIC
           	);
	END COMPONENT;

          SIGNAL clk, reset :  std_logic;
        
          
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
   	uut: MIPs_segmentado PORT MAP(clk => clk, reset => reset);

-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

 stim_proc: process
   begin		
      reset <= '1';
      wait for CLK_period*2;
		reset <= '0';
		wait for CLK_period*20;
		wait;
   end process;

  END;
