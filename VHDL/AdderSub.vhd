LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

entity AdderSub is
    GENERIC (n : INTEGER := 8); -- a generic parameter that controls bit-width.
    PORT (
        sub_cont : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        x, y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        cout : OUT STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
END AdderSub;

ARCHITECTURE df1 of AdderSub IS
    SIGNAL reg : std_logic_vector(n-1 DOWNTO 0);
    SIGNAL x_FA : std_logic_vector(n-1 DOWNTO 0);
    SIGNAL y_FA : std_logic_vector(n-1 DOWNTO 0);
    SIGNAL cin : std_logic;
BEGIN 

    -- Set carry-in based on sub_cont
 cin <= '1' when (sub_cont = "001" or sub_cont = "010" or sub_cont = "011") else '0';

gen_x_FA : for i in 0 to n-1 generate
    process(x, y, sub_cont)
    begin
        if sub_cont = "000" then
            x_FA(i) <= x(i) xor '0';
        elsif sub_cont = "001" or sub_cont = "010" then
            x_FA(i) <= x(i) xor '1';
        elsif sub_cont = "100" then
            x_FA(i) <= '1';
        elsif sub_cont = "101" then
            if (n/2 + i) < n then
                x_FA(i) <= y((n/2) + i);
            else
                x_FA(i) <= '0';
            end if;
        else
            x_FA(i) <= '0';
        end if;
    end process;
end generate;

    -- edit 111 for C=B in ALU lab 3
    -- Set y_FA based on sub_cont
    gen_y_FA : FOR i IN 0 TO n-1 generate
	        process(y,sub_cont)
			BEGIN 
			    if sub_cont = "000" or sub_cont = "001" or sub_cont = "011" or sub_cont = "100" or sub_cont="111" then
				     y_FA(i) <= y(i);
                elsif sub_cont="101" then
                    if i>=(n/2) then
                        y_FA(i) <=y(i-n/2);
                    else 
                        y_FA(i) <= '0';	
                    end if;
                else 	
                    y_FA(i) <= '0';
                end if;					
			end process;
		end generate;


    -- Full Adder for first bit
    first : FA port map(
        xi => x_FA(0),
        yi => y_FA(0),
        cin => cin,
        s => s(0),
        cout => reg(0)
    );

    -- Generate Full Adder for remaining bits
    rest : for i in 1 to n-1 generate
        chain : FA port map(
            xi => x_FA(i),
            yi => y_FA(i),
            cin => reg(i-1),
            s => s(i),
            cout => reg(i)
        );
    end generate;

    cout <= reg(n-1); 

END df1;



			
		   