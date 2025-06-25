library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
component Top IS
  GENERIC (
    n : INTEGER := 8;
    k : INTEGER := 3;   -- k=log2(n)
    m : INTEGER := 4    -- m=2^(k-1)
  );
  PORT (
    clk_i, enable_i, reset_i: in STD_LOGIC;
	Y_i, X_i : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	PWM_o:out STD_LOGIC;
    ALUout_o : out STD_LOGIC_VECTOR((n/2)-1 DOWNTO 0);
    Nflag_o, Cflag_o, Zflag_o, Vflag_o : OUT STD_LOGIC
  );
END component;
--------------------------------------------------------
	component ALU is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC 
	); -- Zflag,Cflag,Nflag,Vflag
	end component;	
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
----------------------------------------------------------

  COMPONENT AdderSub
    GENERIC (n : INTEGER := 8);
    PORT (
      sub_cont : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      x, y     : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
      cout     : OUT STD_LOGIC;
      s        : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Shifter
    GENERIC (n : INTEGER := 8; k : INTEGER := 3);
    PORT (
      y    : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      x    : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      dir  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
      res  : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      cout : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT Logic
    GENERIC (n : INTEGER := 8);
    PORT (
      X, Y     : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      Alufn    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
      LogicOut : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      cout     : OUT STD_LOGIC
    );
  END COMPONENT;
---------------------------------------------------------	
component PWM is
Generic (n: integer :=16);
 port (
 clk,enable,reset : in std_logic;
 PWM_Mode : in std_logic_vector(1 downto 0);
 x,y: in std_logic_vector(n-1 downto 0);
 PWM_Out: out std_logic
 );
end component;
----------------------------------------------------------
component Timer is
Generic (n: integer :=16);
 port (
	clk,enable,reset : in std_logic;	
	q          : out std_logic_vector (n-1 downto 0)); 
end component;
----------------------------------------------------------
COMPONENT SVNSeg is 
        port ( data: in std_logic_vector( 3 downto 0);
		       seg : out std_logic_vector(6 downto 0)
			  );
end COMPONENT;
----------------------------------------------------------
COMPONENT ALUTimingAnalysis IS

  PORT (
		  clk : in std_logic; 
		  X, Y : in std_logic_vector(7 downto 0);
		  ALUFN: in std_logic_vector(4 downto 0);
		  ALUout : out std_logic_vector(7 downto 0);
		  Zflag, Cflag, Nflag,Vflag : out std_logic
  );
END COMPONENT;
-----------------------------------------------------------
COMPONENT PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
END COMPONENT;
------------------------------------------------------------
COMPONENT TopTimingAnalyzing IS
  GENERIC (
    n : INTEGER := 8;
    k : INTEGER := 3;  -- k = log2(n)
    m : INTEGER := 4   -- m = 2^(k - 1)
  );
  PORT (
    clk_i, enable_i, reset_i : in  STD_LOGIC;
    Y_i, X_i                 : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
    ALUFN_i                  : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
    PWM_o                    : out STD_LOGIC;
    ALUout_o                 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
    Nflag_o, Cflag_o, Zflag_o, Vflag_o : out STD_LOGIC
  );
END COMPONENT;

end aux_package;

