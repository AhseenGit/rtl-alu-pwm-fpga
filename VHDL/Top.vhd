LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;  -- Standard arithmetic library
USE work.aux_package.all;

ENTITY Top IS
  GENERIC (
    n : INTEGER := 8;
    k : INTEGER := 3;   -- k=log2(n)
    m : INTEGER := 4    -- m=2^(k-1)
  );
  PORT (
    clk_i, enable_i, reset_i: in STD_LOGIC;
	Y_i, X_i : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	PWM_o:out STD_LOGIC;
    ALUout_o : out STD_LOGIC_VECTOR(7 DOWNTO 0);
    Nflag_o, Cflag_o, Zflag_o, Vflag_o : OUT STD_LOGIC
  );
END Top;

architecture behave of Top is
  signal PWM_result : std_logic := '0';
  signal ALU_result : std_logic_vector(7 downto 0);
  signal Neg, C, Z, V : std_logic;
begin


  PWM_unit: PWM 
    generic map(16) 
    port map(clk_i, enable_i, reset_i, ALUFN_i(1 downto 0), X_i, Y_i, PWM_result);

 
  ALU_unit: ALU 
    generic map(8, 3, 4)
    port map(Y_i(7 downto 0), X_i(7 downto 0), ALUFN_i, ALU_result, Neg, C, Z, V);

  -- Output selection based on ALUFN_i(4 downto 3)
  PWM_o     <= PWM_result when ALUFN_i(4 downto 3) = "00" else '0';
  ALUout_o  <= ALU_result when ALUFN_i(4 downto 3) /= "00" else (others => '0');
  Nflag_o     <= Neg when ALUFN_i(4 downto 3) /= "00" else '0';
  Cflag_o     <= C when ALUFN_i(4 downto 3) /= "00" else '0';
  Zflag_o     <= Z when ALUFN_i(4 downto 3) /= "00" else '0';
  Vflag_o     <= V when ALUFN_i(4 downto 3) /= "00" else '0';

end behave;