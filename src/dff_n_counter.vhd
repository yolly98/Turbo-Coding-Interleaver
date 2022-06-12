library ieee;
use ieee.std_logic_1164.all;

entity dff_n_counter is
    generic (N : natural := 8);

    port(
        clk : in std_logic;
        rst_n : in std_logic;
        d : in std_logic_vector(N - 1 downto 0);
        q : out std_logic_vector(N - 1 downto 0)
    );
end dff_n_counter;

architecture struct of dff_n_counter is
    begin
        ddf_n_proc: process(clk,rst_n)
        begin 
            if (rst_n = '0') then
                q <= (others => '1');
                q(0) <= '0';
                q(1) <= '1';
            elsif(rising_edge(clk)) then
                q <= d;
            end if;
        end process;
end struct;