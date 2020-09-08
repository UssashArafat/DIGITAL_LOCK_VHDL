----------------------------------------
-- Company: CSUN
-- Semester: Spring 2020
-- Course: ECE420
-- Designer: Ussash Arafat

-- Project Name: Computer_Assignment_4
-- Design Name: Digital_Lock
--             (FSM design of digital lock)
----------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Digital_Lock is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           NEW_VALUE : in STD_LOGIC;
           VALUE : in STD_LOGIC_VECTOR (3 downto 0);
           LOCK : out STD_LOGIC);
end Digital_Lock;

architecture Behavioral of Digital_Lock is

type STATE_TYPE is (STATE_0, STATE_1, STATE_2, STATE_3, ERROR);
signal CURRENT_STATE, NEXT_STATE: STATE_TYPE;
signal PIN_0, PIN_1, PIN_2 : STD_LOGIC_VECTOR (3 downto 0);

begin
PIN_0 <= "0001";
PIN_1 <= "0010";
PIN_2 <= "0100";

-- NEXT_STATE LOGIC
process(CURRENT_STATE,NEW_VALUE)
begin
case CURRENT_STATE is
when STATE_0 =>
    if(VALUE = PIN_0) then
        if(NEW_VALUE = '1') then
            NEXT_STATE <= STATE_1;
        else NEXT_STATE <= STATE_0;
        end if;
     else NEXT_STATE <= ERROR;
     end if;
when STATE_1 =>
    if(VALUE = PIN_1) then
        if(NEW_VALUE = '1') then
            NEXT_STATE <= STATE_2;
        else NEXT_STATE <= STATE_1;
        end if;
    else NEXT_STATE <= ERROR;
    end if;
when STATE_2 =>
    if(VALUE = PIN_2) then
        if(NEW_VALUE = '1') then
            NEXT_STATE <= STATE_3;
        else NEXT_STATE <= STATE_2;
        end if;
    else NEXT_STATE <= ERROR;
    end if;
when STATE_3 =>
       NEXT_STATE <= STATE_3;
when others =>
    NEXT_STATE <= STATE_0;
end case;
end process;

-- CURRENT_STATE LOGIC
process(RESET, CLOCK)
begin
if(RESET='1') then
    CURRENT_STATE <= STATE_0;
elsif(rising_edge(CLOCK)) then
    CURRENT_STATE <= NEXT_STATE;
end if;
end process;

-- OUTPUT LOGIC
with CURRENT_STATE select
LOCK <= '1' when STATE_3,
        '0' when others;
        
end Behavioral;
