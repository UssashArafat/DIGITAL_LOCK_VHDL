----------------------------------------
-- Company: CSUN
-- Semester: Spring 2020
-- Course: ECE420
-- Designer: Ussash Arafat

-- Project Name: Computer_Assignment_4
-- Design Name: TB_Digital_Lock
--             (Testbench for digital lock)
----------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Digital_Lock is
--  Port ( );
end TB_Digital_Lock;

architecture Behavioral of TB_Digital_Lock is
component Digital_Lock is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           NEW_VALUE : in STD_LOGIC;
           VALUE : in STD_LOGIC_VECTOR (3 downto 0);
           LOCK : out STD_LOGIC);
end component Digital_Lock;
signal CLOCK, RESET, NEW_VALUE, LOCK: STD_LOGIC;
signal VALUE: STD_LOGIC_VECTOR (3 downto 0);
begin
UUT: Digital_Lock port map (CLOCK=>CLOCK, RESET=>RESET, NEW_VALUE=>NEW_VALUE, VALUE=>VALUE, LOCK=>LOCK);

process begin -- Clock with 10ns period
CLOCK <= '0';
wait for 5ns;
CLOCK <='1';
wait for 5ns;
end process;

process begin
RESET<='0'; NEW_VALUE<='0'; VALUE<="0000";
wait for 7 ns;
RESET<='1';
wait for 4ns;
RESET<='0';
wait for 1ns;
VALUE<="0001";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE <= '0';
wait for 5ns;
VALUE <= "0010";
wait for 1ns;
NEW_VALUE<='1';
wait for 5ns;
NEW_VALUE<='0';
wait for 4ns;
VALUE <= "0100";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE<='0';
-- 3 correct combination
-- Lock will open

wait for 5ns;
RESET <= '1'; -- insert RESET to initialize the LOCK at its primary state
wait for 5ns;
RESET<='0';
wait for 1ns;
VALUE<="1001";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE <= '0';
wait for 5ns;
VALUE <= "0010";
wait for 1ns;
NEW_VALUE<='1';
wait for 5ns;
NEW_VALUE<='0';
wait for 4ns;
VALUE <= "0100";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE<='0';
-- First value input is wrong
-- Lock will not open and go to ERROR state after inputing first value

wait for 5ns;
RESET <= '1'; -- insert RESET to initialize the LOCK at its primary state
wait for 5ns;
RESET<='0';
wait for 1ns;
VALUE<="0001";
wait for 3ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE <= '0';
wait for 5ns;
VALUE <= "0011";
wait for 1ns;
NEW_VALUE<='1';
wait for 5ns;
NEW_VALUE<='0';
wait for 4ns;
VALUE <= "0100";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE<='0';
-- Second value input is wrong
-- Lock will not open and go to ERROR state after inputing second value

wait for 5ns;
RESET <= '1'; -- insert RESET to initialize the LOCK at its primary state
wait for 5ns;
RESET<='0';
wait for 1ns;
VALUE<="0001";
wait for 3ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE <= '0';
wait for 5ns;
VALUE <= "0010";
wait for 1ns;
NEW_VALUE<='1';
wait for 5ns;
NEW_VALUE<='0';
wait for 4ns;
VALUE <= "0110";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE<='0';
-- Third value input is wrong
-- Lock will not open and go to ERROR state after inputing Third value

wait for 5ns;
RESET <= '1'; -- insert RESET to initialize the LOCK at its primary state
wait for 5ns;
RESET<='0';
wait for 1ns;
VALUE<="0001";
wait for 3ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE <= '0';
wait for 5ns;
VALUE <= "0010";
wait for 1ns;
NEW_VALUE<='1';
wait for 5ns;
NEW_VALUE<='0';
wait for 4ns;
VALUE <= "0100";
wait for 1ns;
NEW_VALUE<='1';
wait for 5 ns;
NEW_VALUE<='0';
wait;
-- 3 correct combination
-- Lock will open
end process;

end Behavioral;
