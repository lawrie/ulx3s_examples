library IEEE;
library std;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity top is
  port(
    led : out std_logic_vector(7 downto 0);
    btn : in std_logic_vector(6 downto 0)
  );
end top;

architecture rtl of top is
    type byte_array is array (0 to 7) of std_logic_vector(7 downto 0);
    signal arr : byte_array := (X"00", X"01", X"02", X"03", X"04", X"05", X"06", X"07");
begin
    main: process(btn)
        variable sum : std_logic_vector(7 downto 0);
    begin
        sum := (others => '0');

        for n in arr'range loop
           sum := unsigned(sum) + unsigned(arr(n));
        end loop;

	led <= sum;
    end process;
end;

