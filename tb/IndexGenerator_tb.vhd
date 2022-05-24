library IEEE;
use IEEE.std_logic_1164.all;

entity IndexGenerator_tb is
end IndexGenerator_tb;

architecture beh of IndexGenerator_tb is
    
    constant T_CLK : time := 100 ns;
    constant DEF_BIT : natural := 10;

    signal i_tb : std_logic_vector(DEF_BIT-1 downto 0) := (others => '0');
    signal j_tb : std_logic_vector(DEF_BIT-1 downto 0);
    signal clk_tb : std_logic := '0';
    signal end_sim : std_logic := '1';

    component IndexGenerator is
        generic(Nbit : natural := 10);
        port(
            i : in std_logic_vector(Nbit-1 downto 0);
            j : out std_logic_vector(Nbit-1 downto 0)
        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;

        IndexGen : IndexGenerator
            generic map (Nbit => DEF_BIT)
            port map(
                i => i_tb,
                j => j_tb
            );

        stimuli : process(clk_tb)
            variable t : natural := 0;

            begin
                if(rising_edge(clk_tb)) then
                    case(t) is
                        when 1 => i_tb <= "0000000000";
                        when 2 => i_tb <= "0001010100";
                        when 3 => i_tb <= "0000000110";
                        when 4 => i_tb <= "0001000110";
                        when 5 => i_tb <= "0101000111";
                        when 6 => i_tb <= "1111110001";
                        when 7 => end_sim <= '0';
                        when others => null;
                    end case;
                    t := t+1;
                end if;
        end process;

end beh;