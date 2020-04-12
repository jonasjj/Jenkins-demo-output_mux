library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.types.all;

entity output_mux is
  port (
    digit_sel : in std_logic;
    digits : in digits_type;
    digit : out digit_type
  );
end output_mux; 

architecture rtl of output_mux is

begin

    -- Output one of the two digits
    digit <= digits(0) when digit_sel = '0' else digits(1);
  
end architecture;