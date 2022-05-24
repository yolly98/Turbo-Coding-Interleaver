library IEEE;
use IEEE.std_logic_1164.all;

entity counter is
    generic (Nbit : positive :=8);
    port(
        clk : in std_logic;
        rst : in std_logic;
        en : in std_logic;
        q : out std_logic_vector(Nbit-1 downto 0)
    );
end counter;

architecture struct of counter is
        component RCA is
            generic (Nbit : positive := Nbit);
            port(
                a : in std_logic_vector(Nbit-1 downto 0);
                b : in std_logic_vector(Nbit-1 downto 0);
                cin : in std_logic;
                s : out std_logic_vector(Nbit-1 downto 0);
                cout :out std_logic
            );
        end component;

        component dff_n is
            generic (N : positive :=Nbit);
            port(
                clk : in std_logic;
                en : in std_logic;
                rst_n : in std_logic;
                d : in std_logic_vector(N - 1 downto 0);
                q : out std_logic_vector(N - 1 downto 0)
            );
        end component;

    signal b_s : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal cout_s : std_logic;
    signal sum_s : std_logic_vector(Nbit-1 downto 0) := (others => '0');
    begin        
        ADDER : RCA 
            port map(
                a =>  b_s,
                b => (others => '0'),
                cin => '1',
                s => sum_s,
                cout => cout_s
            );

        REG : dff_n
            port map(
                clk => clk,
                rst_n => rst,
                en => en,
                d => sum_s,
                q => b_s
            );
     
        q <= b_s;
    end struct;