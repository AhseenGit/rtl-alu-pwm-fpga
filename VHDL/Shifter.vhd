library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter is 
  generic (
    n : integer := 8;
    k : integer := 3
  );
  port( 
    y    : in  std_logic_vector(n-1 downto 0);  
    x    : in  std_logic_vector(n-1 downto 0);  
    dir  : in  std_logic_vector(2 downto 0);    
    res  : out std_logic_vector(n-1 downto 0);  
    cout : out std_logic
  );
end Shifter;

architecture Behavioral of Shifter is
  signal q : integer range 0 to (2**k)-1;
  signal valid_shift : std_logic;
  signal x_k : std_logic_vector(k-1 downto 0);
  signal temp : std_logic_vector(n-1 downto 0);
begin

  valid_shift <= '1' when (n = 2**k) else '0';
  x_k <= x(k-1 downto 0);
  q <= to_integer(unsigned(x_k));

  process(y, q, dir, valid_shift)
  begin
    temp <= (others => '0');
    cout <= '0';

    if valid_shift = '1' then
      if dir = "000" then  -- Logical left shift
        if q < n then
          temp <= std_logic_vector(shift_left(unsigned(y), q));
          cout <= y(n - q - 1);
        else
          temp <= (others => '0');
          cout <= '0';
        end if;
      elsif dir = "001" then  -- Logical right shift
        if q < n then
          temp <= std_logic_vector(shift_right(unsigned(y), q));
          cout <= y(q - 1);
        else
          temp <= (others => '0');
          cout <= '0';
        end if;
      else
        temp <= (others => '0');
        cout <= '0';
      end if;
    end if;

    res <= temp;
  end process;

end Behavioral;





