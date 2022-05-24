library ieee;
use ieee.std_logic_1164.all;

entity IndexGenerator is
    generic (Nbit : natural := 10);

    port(
        i : in std_logic_vector(Nbit-1 downto 0);
        j : out std_logic_vector(Nbit-1 downto 0)
    );

end IndexGenerator;

architecture rtl of IndexGenerator is

    component RCA is
        generic (Nbit : natural := 10);
        port(
            a : in std_logic_vector(Nbit-1 downto 0);
            b : in std_logic_vector(Nbit-1 downto 0);
            cin : in std_logic;
            s : out std_logic_vector(Nbit-1 downto 0);
            cout : out std_logic

        );
    end component;

    signal aRCA1 : std_logic_vector(Nbit-1 downto 0);
    signal sRCA1 : std_logic_vector(Nbit-1 downto 0);
    signal coutRCA1 : std_logic;
    signal aRCA2 : std_logic_vector(Nbit downto 0);
    signal sRCA2 : std_logic_vector(Nbit downto 0);

    begin
        RCA1 : RCA
            generic map(Nbit => 10)
            port map(
                a => aRCA1,
                b => i,
                cin => '0',
                s => sRCA1,
                cout => coutRCA1
            );
        
        RCA2 : RCA
            generic map(Nbit => 11)
            port map(
                a => aRCA2,
                b => "00000101101",
                cin => '0',
                s => sRCA2
            );

        aRCA1 <= i(Nbit-2 downto 0) & '0';
        aRCA2 <= coutRCA1 & sRCA1;
        j <= sRCA2(Nbit-1 downto 0);

end rtl;