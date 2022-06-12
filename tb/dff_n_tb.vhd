library IEEE;
use IEEE.std_logic_1164.all;

entity dff_n_tb is
end dff_n_tb;

architecture bhv of dff_n_tb is

    constant T_CLK : time := 100 ns;
    constant T_RST : time := 25 ns;
    constant DEF_BIT : natural := 10;

    signal clk_tb : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal en_tb : std_logic := '0';
    signal d_tb : std_logic_vector(DEF_BIT-1 downto 0) := (others => '0');
    signal q_tb : std_logic_vector(DEF_BIT-1 downto 0);
    signal end_sim : std_logic := '1';

    component dff_n is
        generic(N : natural);

        port(
            clk     : in std_logic;
            rst_n : in std_logic;
            en      : in std_logic;
            d       : in std_logic_vector(N - 1 downto 0);
            q       : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;
        rst_n <= '1' after T_RST;

        dff_n_dut: dff_n
            generic map(N => DEF_BIT)
            port map(
                clk => clk_tb,
                rst_n => rst_n,
                en => en_tb,
                d => d_tb,
                q => q_tb
            );

        stimuli: process(clk_tb,rst_n)
                variable t : integer := 0;

            begin
                if(rst_n = '0') then 
                    d_tb <= (others => '0');
                    t := 0;
                elsif (rising_edge(clk_tb)) then
                    case(t) is
                            when 1 => d_tb <= "00000000";
                            when 2 => d_tb <= "00000001";
                            when 3 => d_tb <= "00000000";
                            when 4 => en_tb <= '1';
                            when 5 => d_tb <= "00000001";
                            when 6 => d_tb <= "00000000";
                            when 10 => end_sim <= '0';
                            when others => null;
                    end case;
                    t := t+1;
                end if;
        end process;
    end bhv;
