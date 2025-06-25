LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.aux_package.all;

entity IO_Interface is
    port (
        clk_i: IN std_logic;
        KEY0_i, KEY1_i, KEY2_i, KEY3_i: in std_logic;
        SW_i: in std_logic_vector(9 downto 0);
        HEX0_o, HEX1_o, HEX2_o, HEX3_o, HEX4_o, HEX5_o: out std_logic_vector(6 downto 0);
        LEDs_o: out std_logic_vector(9 downto 0);
        GPIO_o: out std_logic
    );
end IO_Interface;

architecture behave of IO_Interface is
    signal X_r : std_logic_vector(15 downto 0);
    signal Y_r : std_logic_vector(15 downto 0);
    signal ALUout_w : std_logic_vector(7 downto 0);
    signal ALUFN_r : std_logic_vector(4 downto 0);
    signal rst_w : std_logic;
    signal ena_w : std_logic;
    signal TOPclk_w : std_logic;
    signal N_w, C_w, Z_w, V_w : std_logic;
    signal ByteX_show_v : std_logic_vector(7 downto 0);
    signal ByteY_show_v : std_logic_vector(7 downto 0);
    signal PWM_o : std_logic;
begin

    ena_w <= SW_i(8);
    rst_w <= not KEY3_i;

    -- Digital system mapping
    Top_inst: Top 
        generic map (16, 4, 8) 
        port map (TOPclk_w, ena_w, rst_w, Y_r, X_r,ALUFN_r, PWM_o, ALUout_w, N_w, C_w, Z_w, V_w);
	--PLL
	m0: PLL port map(
	inclk0=>clk_i,
	c0=>TOPclk_w
	);
    -- Show on FPGA
    X_lowerNipple: SVNSeg port map (ByteX_show_v(3 downto 0), HEX0_o);
    X_higherNipple: SVNSeg port map (ByteX_show_v(7 downto 4), HEX1_o);   
    Y_lowerNipple: SVNSeg port map (ByteY_show_v(3 downto 0), HEX2_o);
    Y_higherNipple: SVNSeg port map (ByteY_show_v(7 downto 4), HEX3_o);   

    LEDs_o(9 downto 5) <= ALUFN_r;

    lowerNippleRes_low: SVNSeg port map (ALUout_w(3 downto 0), HEX4_o); 
    lowerNippleRes_high: SVNSeg port map (ALUout_w(7 downto 4), HEX5_o); 

    LEDs_o(0) <= V_w;
    LEDs_o(1) <= Z_w;
    LEDs_o(2) <= C_w;
    LEDs_o(3) <= N_w;
    GPIO_o <= PWM_o;
    ByteX_show_v <= X_r(15 downto 8) when (SW_i(9) = '1') else X_r(7 downto 0); 
    ByteY_show_v <= Y_r(15 downto 8) when (SW_i(9) = '1') else Y_r(7 downto 0); 

    -- XY loading process
    XY_loading: process(SW_i, KEY1_i, KEY0_i, KEY2_i)
    begin
        if KEY1_i = '0' and SW_i(9) = '1' then
            X_r(15 downto 8) <= SW_i(7 downto 0);
        elsif KEY1_i = '0' and SW_i(9) = '0' then
            X_r(7 downto 0) <= SW_i(7 downto 0);
        elsif KEY0_i = '0' and SW_i(9) = '1' then  
            Y_r(15 downto 8) <= SW_i(7 downto 0);
        elsif KEY0_i = '0' and SW_i(9) = '0' then  
            Y_r(7 downto 0) <= SW_i(7 downto 0);
        elsif KEY2_i = '0' then
            ALUFN_r <= SW_i(4 downto 0);			
        end if;
    end process;

end behave;
