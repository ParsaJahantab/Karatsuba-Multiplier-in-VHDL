library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity kara64bit is
  port (
    clk: IN std_logic;
    start : IN std_logic;
    rst : IN std_logic;
    multiplier : IN unsigned(63 downto 0);
    multiplicand : IN unsigned(63 downto 0);
    p : OUT unsigned(127 downto 0):=(others => '0');
    done : OUT std_logic:='0'
  ) ;
end kara64bit ; 
architecture arch of kara64bit is
  SIGNAL first_half_multiplier:unsigned(31 downto 0):=(others => '0');
  SIGNAL second_half_multiplier:unsigned(31 downto 0) := (others => '0');
  SIGNAL first_half_multiplicand:unsigned(31 downto 0):=(others => '0');
  SIGNAL second_half_multiplicand:unsigned(31 downto 0) := (others => '0');
  SIGNAL multiplier_sum: unsigned(31 downto 0) := (others => '0');
  SIGNAL multiplicand_sum: unsigned(31 downto 0) :=(others => '0');
  SIGNAL product1: unsigned(63 downto 0) := (others => '0');
  SIGNAL product2 : unsigned(63 downto 0) := (others => '0');
  SIGNAL product3 : unsigned(63 downto 0) := (others => '0');
  SIGNAL done1 : std_logic:='0';
  SIGNAL done2 : std_logic:='0';
  SIGNAL done3 : std_logic:='0';
  SIGNAL temp_done:std_logic:='0';
begin
    first_half_multiplier<=multiplier(63 downto 32);
    second_half_multiplier<= multiplier(31 downto 0);
    first_half_multiplicand<=multiplicand(63 downto 32);
    second_half_multiplicand<= multiplicand(31 downto 0);
    multiplier_sum<= first_half_multiplier+  second_half_multiplier;
    multiplicand_sum<= first_half_multiplicand + second_half_multiplicand;
    k1 : entity work.addshift PORT MAP(clk,start,rst,first_half_multiplier,first_half_multiplicand,product1,done1);
    k2 : entity work.addshift PORT MAP(clk,start,rst,second_half_multiplier,second_half_multiplicand,product2,done2);
    k3 : entity work.addshift PORT MAP(clk,start,rst,multiplier_sum,multiplicand_sum,product3,done3);
    temp_done <= done1 AND done2 AND done3;
  seq:process(clk)
  variable z1: unsigned(127 DOWNTO 0) := (others => '0');
  variable z2: unsigned(127 DOWNTO 0) := (others => '0');
  variable z3: unsigned(127 DOWNTO 0) := (others => '0');
  variable counter: integer:=0;
  begin
    if (clk'event AND clk='1') then
      if (counter=2) then
        done <= '0';
        counter:=0;
      elsif (counter=1) then
        done <= '1';
        p <= z1+z2+z3;
        counter:=2;
      elsif (temp_done='1') then
        z1(127 DOWNTO 64) := product1;
        z2(63 DOWNTO 0) := product2;
        z3(95 DOWNTO 32) := product3 - product2 - product1;
        counter:=1;
      end if;
    end if;
  end process;
end architecture ;