library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Top is
end tb_Top;

architecture sim of tb_Top is
    -- DUT signals
    signal clk_i     : std_logic := '0';
    signal enable_i  : std_logic := '1';  -- Always enabled
    signal reset_i   : std_logic := '1';
    signal Y_i       : std_logic_vector(15 downto 0) := (others => '0');
    signal X_i       : std_logic_vector(15 downto 0) := (others => '0');
    signal ALUFN_i   : std_logic_vector(4 downto 0) := "00000";
    signal PWM_o     : std_logic;
    signal ALUout_o  : std_logic_vector(7 downto 0);
    signal Nflag_o   : std_logic;
    signal Cflag_o   : std_logic;
    signal Zflag_o   : std_logic;
    signal Vflag_o   : std_logic;

    constant CLK_PERIOD : time := 20 ns;

begin

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk_i <= '0';
            wait for CLK_PERIOD / 2;
            clk_i <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- DUT instantiation
    uut: entity work.Top
        generic map (
            n => 8,
            k => 3,
            m => 4
        )
        port map (
            clk_i     => clk_i,
            enable_i  => enable_i,
            reset_i   => reset_i,
            Y_i       => Y_i,
            X_i       => X_i,
            ALUFN_i   => ALUFN_i,
            PWM_o     => PWM_o,
            ALUout_o  => ALUout_o,
            Nflag_o   => Nflag_o,
            Cflag_o   => Cflag_o,
            Zflag_o   => Zflag_o,
            Vflag_o   => Vflag_o
        );

    -- Stimulus process
    stimulus : process
    begin
        -- Initial reset
        wait for 100 ns;
        reset_i <= '1';
        wait for CLK_PERIOD;
        reset_i <= '0';

        -- Set inputs for PWM mode "00000"
        Y_i <= x"FFFF";  -- Full scale
        X_i <= x"7FFF";  -- Half of Y (duty cycle ≈ 50%)
        ALUFN_i <= "00010";

        -- Run simulation
        wait for 2000 ns;

        -- Simulation end
        wait;
    end process;

end sim;
