library ieee;
use ieee.std_logic_1164.all;

entity IndexGenerator is
    generic (Nbit : natural := 10);

    port(
        i : in std_logic_vector(Nbit-1 downto 0);
        j : out std_logic_vector(Nbit-1 downto 0);
    );

end IndexGenerator;

architecture beh of IndexGenerator is

    component RCA is
        generic (Nbit : natural := 10)
        port(
            a : in std_logic_vector(Nbit-1 downto 0);
            b : in std_logic_vector(Nbit-1 downto 0);
            cin : in std_logic;
            s : out std_logic_vector(Nbit-1 downto 0);
            cout : out std_logic

        );
    end component;

    signal coutToRCA : std_logic_vector(11 downto 0);
    
    begin:
        RCA1 : RCA
            generic map(Nbit => 10)
            port map(
                a => i(Nbit-1 downto 1) & "0";
                b => i;
                cin => "0";
                s => coutToRCA(9 downto 0);
                cout => coutToRCA(10);
            );
        
        RCA2 : RCA
            generic map(Nbit => 11)
            port map(
                a => coutToRCA;
                b => "00000101101";
                cin => "0";
                s => j;
            );

end beh;