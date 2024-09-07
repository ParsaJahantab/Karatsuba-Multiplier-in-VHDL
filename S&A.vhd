library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity addshift is
  port (
    clk: IN std_logic;
    start : IN std_logic;
    rst : IN std_logic;
    multiplier : IN unsigned(31 downto 0);
    multiplicand : IN unsigned(31 downto 0);
    p : OUT unsigned(63 downto 0):=(others => '0');
    done : OUT std_logic
  ) ;
end addshift ; 

architecture arch of addshift is
signal lock:std_logic:='1';
signal temp1: unsigned(63 downto 0):= (others => '0');
signal temp2: unsigned(63 downto 0):= (others => '0');
begin
    seq: process(clk,rst) 
    variable counter: unsigned(31 downto 0) := (others => '0');
    variable product: unsigned(63 downto 0):= (others => '0');
    begin
        if (rst='1') then
            lock <='1';
            counter:= (others => '0');
            product:= (others => '0');
            temp1<= (others => '0');
            temp2<= (others => '0');
            done <= '0';
            p <= (others => '0');
        elsif (clk'event AND clk='1') then
            if (start='1') then
                lock <= '0';
                temp1(31 downto 0) <= multiplier;
                temp2(31 downto 0) <= multiplicand;
            end if;
            if (lock='1') then
                done <= '0';
            end if;
            if (lock = '0') then
                if temp1(0)='1' then
                    product:= product + temp2;
                end if;
                temp2 <= shift_left(unsigned(temp2), 1);
                temp1 <= shift_right(unsigned(temp1),1);
                counter := counter +1;
                if (counter = 32) then
                    p <= product;
                    lock <='1';
                    done <= '1';
                end if;
            end if;
        end if;
    end process;
end architecture ;