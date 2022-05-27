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
    constant DEF_BIT : natural := 1024;

    signal x_tb : std_logic := '0';
    signal y_tb : std_logic;
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal end_sim : std_logic := '1';

    component Interleaver is
        port(
            clk : in std_logic;
            rst : in std_logic;
            x : in std_logic;
            y : out std_logic

        );
    end component;

    begin
        clk_tb <= ((not clk_tb) and end_sim ) after T_CLK/2;
        rst_tb <= '1' after T_CLK;
        file_open(INPUT_FILE, "input.txt", read_mode);
        file_open(OUTPUT_FILE, "output_vhdl.txt", write_mode);

        INTER: Interleaver
            port map(
                clk => clk_tb,
                rst => rst_tb,
                x => x_tb,
                y => y_tb
            );

        stimuli : process(clk_tb)
            variable t : natural := 0;
            variable input_line : line;
            variable output_line : line;
            variable input_bit : std_logic;

            begin 
                if(rst_tb = '0') then
                    t := 0;
                    x_tb <= '0';
                else
                    if(rising_edge(clk_tb)) then
                        --if( (t mod 2) = 0) then
                        --    x_tb <= '0';
                        --else
                        --    x_tb <= '1';
                        --end if;
                        if( endfile(INPUT_FILE)) then
                            file_close(INPUT_FILE);
                            file_open(INPUT_FILE, "input.txt", read_mode);
                        end if;
                        readline(INPUT_FILE, input_line);
                        read(input_line, input_bit);
                        x_tb <= input_bit;

                        if(t >= 1024 + 2) then
                        write(output_line, y_tb);
                        writeline(OUTPUT_FILE, output_line);
                        end if;

                        if(t = 1024*2 + 2) then
                            end_sim <= '0';
                            file_close(INPUT_FILE);
                            file_close(OUTPUT_FILE);
                        end if;
                        t := t+1;
                    end if;
                end if;
        end process;

end beh;