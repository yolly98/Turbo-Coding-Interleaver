library IEEE;
use IEEE.std_logic_1164.all;

entity DFC is
    port(
        clk : in std_logic;
        rst : in std_logic;
        d : in std_logic;
        q : out std_logic
    );
end DFC;

architecture rtl of DFC is
    begin
        dfc_p: process(rst, clk)
        begin
            if rst = '0' then
                q <= '0';
            elsif (clk'event and clk = '1') then 
                q <= d;
            end if;
        end process dfc_p;
end rtl;
