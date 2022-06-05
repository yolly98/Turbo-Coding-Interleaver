library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
    port(
        clk : in std_logic;
        rst : in std_logic;
        d : in std_logic;
        q : out std_logic
    );
end DFF;

architecture rtl of DFF is
    begin
        dfc_p: process(rst, clk)
        begin
            if (rst = '0') then
                q <= '0';
            elsif (rising_edge(clk)) then 
                q <= d;
            end if;
        end process;
end rtl;
