library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture bhv of counter_tb is

    constant T_CLK : time := 10 ns;
    constant T_RST : time := 25 ns;
    constant DEF_BIT : natural := 8;

    signal clk_tb : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en_tb : std_logic := '1';
    signal q_tb : std_logic_vector(DEF_BIT-1 downto 0);
    signal end_sim : std_logic := '1';

    component counter is
        generic( Nbit : natural := 8);

        port(
            clk     : in std_logic;
            rst : in std_logic;
            en      : in std_logic;
            q       : out std_logic_vector(Nbit - 1 downto 0)
        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;
        rst_n <= '1' after T_RST;

        counter_dut: counter
            generic map(Nbit => DEF_BIT)
            port map(
                clk => clk_tb,
                rst => rst_n,
                en => en_tb,
                q => q_tb
            );

            stimuli: process(clk_tb,rst_n)
                variable t : integer := 0;

            begin
                if(rst_n = '0') then 
                    t := 0;
                elsif (rising_edge(clk_tb)) then
                    if(t = 100) then
                        end_sim <= '0';
                    end if;
                    t := t+1;
                end if;
        end process;
    end bhv;
