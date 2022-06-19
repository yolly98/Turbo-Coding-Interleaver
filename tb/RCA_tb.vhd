library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity RCA_tb is
end RCA_tb;

architecture beh of RCA_tb is

    constant clk_period : time := 100 ns;
    constant N : positive := 10;

    component RCA
    generic (Nbit : positive);
    port (
        a : in std_logic_vector(Nbit-1 downto 0);
        b : in std_logic_vector(Nbit-1 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(Nbit-1 downto 0);
        cout : out std_logic
    );
    end component;

    signal clk : std_logic := '0';
    signal a_ext : std_logic_vector(N-1 downto 0) := (others => '0');
    signal b_ext : std_logic_vector(N-1 downto 0) := (others => '0');
    signal cin_ext : std_logic := '0';
    signal s_ext : std_logic_vector(N-1 downto 0);
    signal cout_ext : std_logic;
    signal end_sim : boolean := true;

    begin 
        clk <= not clk after clk_period/2 when end_sim else '0';

        dut: RCA
            generic map ( Nbit => N)
            port map(
                a => a_ext,
                b => b_ext,
                cin => cin_ext,
                s => s_ext,
                cout => cout_ext
            );

            stimulus : process
            begin 
                a_ext <= (others => '0');
                b_ext <= (others => '0');
                cin_ext <= '0';
                wait for 200 ns;
                a_ext <= "0000000110";
                b_ext <= "0000100110";
                cin_ext <= '0';
                wait until rising_edge(clk);
                a_ext <= "0001110110";
                b_ext <= "0000011001";
                cin_ext <= '1';
                wait until rising_edge(clk);
                a_ext <= (others => '0');
                b_ext <= (others => '0');
                cin_ext <= '0';
                wait until rising_edge(clk);
                a_ext <= "1111111111";
                b_ext <= "1111111111";
                cin_ext <= '0';
                wait until rising_edge(clk);
                a_ext <= "1111111111";
                b_ext <= "1111111111";
                cin_ext <= '1';
                wait until rising_edge(clk);
                end_sim <= false;
	 end process;
end beh;




