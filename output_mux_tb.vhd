library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;
use pck_lib.types.all;

library output_mux_lib;

entity output_mux_tb is
end output_mux_tb;

architecture sim of output_mux_tb is

  signal digit_sel : std_logic;
  signal digits : digits_type;
  signal digit : digit_type;

begin

  DUT : entity output_mux_lib.output_mux(rtl)
  port map (
    digit_sel => digit_sel,
    digits => digits,
    digit => digit
  );

  SEQUENCER_PROC : process
    
    procedure check (
      sel : in std_logic;
      tens : in digit_type;
      ones : in digit_type
    ) is
    begin
      digit_sel <= sel;
      digits <= (ones, tens);
      wait for 1 ns;
      wait for 1 ns;

      report "Checking input digits = (" & integer'image(tens) & ", " &
        integer'image(ones) & "), digit_sel = " & std_logic'image(digit_sel);

      assert digit = digits(to_integer(unsigned'("" & digit_sel)))
        report "The DUT didn't output the expected digit"
        severity failure;
    end procedure;

  begin

    for tens in 0 to 9 loop
      for ones in 0 to 9 loop

        check('0', tens, ones);
        check('1', tens, ones);

      end loop;
    end loop;

    print_ok_and_finish;
  end process;

end architecture;