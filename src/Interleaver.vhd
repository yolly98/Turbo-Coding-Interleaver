library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Interleaver is
    port(
        clk : in std_logic;
        rst : in std_logic;
        x : in std_logic;
        y : out std_logic
    );
end Interleaver;

architecture rtl of Interleaver is

    signal r1_out : std_logic;
    signal q_s : std_logic_vector(1023 downto 0);
    signal r2_out : std_logic_vector(1023 downto 0);
    signal r2_en : std_logic;
    signal count_out : std_logic_vector(9 downto 0);
    signal j_mux : std_logic_vector(9 downto 0);
    signal out_mux : std_logic;

    component DFC is
        port(
            clk : in std_logic;
            rst : in std_logic;
            d : in std_logic;
            q : out std_logic
        );
    end component;

    component dff_n is
        generic (N : positive := 8);
        port(
            clk : in std_logic;
            en : in std_logic;
            rst_n : in std_logic;
            d : in std_logic_vector(N - 1 downto 0);
            q : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component counter is
        generic (Nbit : positive :=8);
        port(
            clk : in std_logic;
            rst : in std_logic;
            en : in std_logic;
            q : out std_logic_vector(Nbit-1 downto 0)
        );
    end component;

    component IndexGenerator is
        generic(Nbit : positive := 10);
        port(
            i : in std_logic_vector(Nbit-1 downto 0);
            j : out std_logic_vector(Nbit-1 downto 0)
        );
    end component;

    begin

        R1: DFC 
            port map(
                clk => clk,
                rst => rst,
                d => x,
                q => r1_out
            );

        SHIFT: for i in 0 to 1023 generate
            FIRST: if i = 0 generate
                SR1: DFC port map(
                    clk => clk,
                    rst => rst,
                    d => r1_out,
                    q => q_s(1023-i)
                );
                end generate FIRST;
            INTERNAL:if i > 0 generate
                SRI: DFC port map(
                    clk => clk,
                    rst => rst,
                    d => q_s(1023-(i-1)),
                    q => q_s(1023-i)
                );
                end generate INTERNAL;
        end generate SHIFT;

        R2: dff_n
            generic map(N => 1024)
            port map(
                clk => clk,
                rst_n => rst,
                en => r2_en,
                d => q_s,
                q => r2_out
            );

        ACCUMOLATOR: counter
            generic map(Nbit => 10)
            port map(
                clk => clk,
                rst => rst,
                en => '1',
                q => count_out 
            );

        INDEXGEN: IndexGenerator
            generic map (Nbit => 10)
            port map(
                i => count_out,
                j => j_mux
            );

        R3: DFC 
            port map(
                clk => clk,
                rst => rst,
                d => out_mux,
                q => y
            );

        r2_en <= count_out(0) and count_out(1) and count_out(2) and count_out(3) and count_out(4) and count_out(5) and count_out(6) and count_out(7) and count_out(8) and count_out(9);
        out_mux <= r2_out(to_integer(unsigned(j_mux)));

end rtl;

