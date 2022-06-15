library IEEE;
use IEEE.std_logic_1164.all;

entity dff_tb is
end dff_tb;

architecture bhv of dff_tb is

    constant T_CLK : time := 100 ns;
    constant T_RST : time := 25 ns;

    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal d_tb : std_logic := '0';
    signal q_tb : std_logic;
    signal end_sim : std_logic := '1';

    component DFF is

        port(
            clk     : in std_logic;
            rst     : in std_logic;
            d       : in std_logic;
            q       : out std_logic
        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;
        rst_tb <= '1' after T_RST;

        dff_1: DFF
            port map(
                clk => clk_tb,
                rst => rst_tb,
                d => d_tb,
                q => q_tb
            );

        stimuli: process(clk_tb,rst_tb)
                variable t : integer := 0;

            begin
                if(rst_tb = '0') then 
                    d_tb <= '0';
                    t := 0;
                elsif (rising_edge(clk_tb)) then
                    case(t) is
                            when 1 => d_tb <= '0';
                            when 2 => d_tb <= '1';
                            when 3 => d_tb <= '0';
                            when 5 => d_tb <= '1';
                            when 6 => d_tb <= '1';
                            when 7 => d_tb <= '0';
                            when 8 => d_tb <= '0';
                            when 9 => d_tb <= '1';
                            when 10 => end_sim <= '0';
                            when others => null;
                    end case;
                    t := t+1;
                end if;
        end process;
    end bhv;
