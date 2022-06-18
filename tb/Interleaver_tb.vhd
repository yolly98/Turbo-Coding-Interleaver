library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity Interleaver_tb is
end entity Interleaver_tb;

architecture beh of Interleaver_tb is

    file INPUT_FILE : text;
    file OUTPUT_FILE : text;
    
    constant T_CLK : time := 100 ns;
    constant T_RESET : time := 25 ns;
    constant DEF_BIT : natural := 1024;
    constant TX_CYCLES : natural := 4;

    signal x_in_tb : std_logic := '0';
    signal x_out_tb : std_logic;
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal end_sim : std_logic := '1';

    component Interleaver is
        port(
            clk : in std_logic;
            rst : in std_logic;
            x_in : in std_logic;
            x_out : out std_logic

        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;
        rst_tb <= '1' after T_RESET;

        file_open(INPUT_FILE, "input0.txt", read_mode);
        file_open(OUTPUT_FILE, "output_vhdl0.txt", write_mode);

        INTER: Interleaver
            port map(
                clk => clk_tb,
                rst => rst_tb,
                x_in => x_in_tb,
                x_out => x_out_tb
            );

        stimuli : process(clk_tb)
            variable t : natural := 0;
            variable input_line : line;
            variable output_line : line;
            variable input_bit : std_logic;
            variable m : natural := 0;
            variable n : natural := 0;

            begin 

                if(rst_tb = '0') then
                    t := 0;
                    x_in_tb <= '0';
                else
                    if(rising_edge(clk_tb)) then

                        if( endfile(INPUT_FILE)) then

                            report "change input file";

                            m := m + 1;
                            if (m = TX_CYCLES) then
                                m := 0;
                            end if;
                            file_close(INPUT_FILE);
                            file_open(INPUT_FILE, "input" & natural'image(m) & ".txt", read_mode);
                        end if;

                        readline(INPUT_FILE, input_line);
                        read(input_line, input_bit);
                        x_in_tb <= input_bit;

                        if(t = (1024*2 + 3) + (1024 * n)) then

                            report "change output file";
                            n := n + 1;
                            file_close(OUTPUT_FILE);
                            file_open(OUTPUT_FILE, "output_vhdl" & natural'image(n) & ".txt", write_mode);
                        end if;

                        if(t >= 1024 + 3) then
                            write(output_line, x_out_tb);
                            writeline(OUTPUT_FILE, output_line);
                        end if;

                        if(n = TX_CYCLES) then
                            end_sim <= '0';
                            file_close(INPUT_FILE);
                            file_close(OUTPUT_FILE);
                        end if;

                        t := t + 1;
                    end if;
                end if;
        end process;
end beh;