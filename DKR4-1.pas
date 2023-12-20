uses Crt, GraphABC;

function f(x: real): real;
begin
  result := 1 * Power(x, 3) + (-2) * Power(x, 2) + 4 * x + 18;
end;
function f1(x: real): real;
begin
  result :=( 1 * Power(x, 4)/4) + (-2) * (Power(x, 3)/3) + 4 * (Power(x, 2)/2) + 18*x;
end;
function left(a, b:real):real;
var
  h, x, sum:real;
begin
  left:=f1(a)-f1(b);
end;
procedure casemenu (a, b: real; var area, error: real);
var
  n, i: integer;
  x, h: real;
sum1, sum2, sum: real;
begin
  n := 100; 
  h := (b - a) / n; 

  sum1 := 0;
  sum2 := 0;

  for i := 1 to n div 2 do
  begin
    x := a + (2 * i - 2) * h; 
    sum1 := sum1 + f(x); 
    x := a + (2 * i - 1) * h; 
    sum2 := sum2 + f(x); 
  end;

  sum := h / 3 * (f(a) + 4 * sum1 + 2 * sum2 + f(b)); 
  area := sum; 
  error := abs(sum) - ABS(left(a, b)); 
end;

var
  S: Real; 
  a, b, n, x, y, option, scale: Integer; 
  ch: char;
area, error: Real;
procedure draw_plane(scale, a, b: integer);
var
  i, x, y: integer;
begin
  x := 30; 
  y := 770; 
  SetWindowSize((b + 1) * 20 * scale + 800, 800); 
  SetWindowTitle('График вычесленного интеграла'); 
  SetPenColor(clBlack); 
  Line(30, 770, (b + 1) * 20 * scale + 30, 770); // Ось X 
  Line(30, 30, 30, 770); // Ось Y 
  line((b + 1) * 20 * scale + 25, y - 5, (b + 1) * 20 * scale + 30, y); 
  line((b + 1) * 20 * scale + 25, y + 5, (b + 1) * 20 * scale + 30, y); 
  line(25, 35, 30, 30); 
  line(35, 35, 30, 30); 
  TextOut(15, 25, 'Y'); 
  TextOut((b + 1) * 20 * scale + 25, 780, 'X'); 
  TextOut(20, 775, '0'); 
  for i := 1 to b do 
  begin
    line(x + (20 * scale * i), y + 5, x + (20 * scale * i), y - 5); 
    TextOut(x + (20 * i * scale - 4), y + 10, i); 
  end; 
  for i := 1 to 36 do 
  begin
    line(25, y - (20 * i * scale), 35, y - (20 * scale * i)); 
    TextOut(13, y - (20 * i * scale) - 7, i); 
  end; 
end;

function graph(a, b, x, y, scale: integer): boolean;
var
  i: integer; 
  h: Real;
begin
  n:= 10; 
  h := (b - a) / n; 
  for i := 0 to n - 1 do 
  begin
    SetPenColor(clRed); 
    setpenwidth(2);
    line(trunc(x + a * 20 * scale + h * i * 20 * scale), y - trunc(F(a + i * h)) * 20 * scale, trunc(x + a * 20 * scale + h * i * 20 * scale + h * 20 * scale), y - trunc(F(a + i * h + h)) * 20 * scale); 
  end; 
end;

function rects(a, b, x, y, scale: integer): boolean;
var
  i: integer; 
  h: Real;
begin
  n:= 100; 
  h := (b - a) / n; 
  for i := 0 to n - 1 do 
  begin
    SetBrushColor(clBlue); 
    rectangle(trunc(x + a * 20 * scale + h * i * 20 * scale), y, trunc(x + a * 20 * scale + h * i * 20 * scale + h * 20 * scale), y- trunc(F(a + i * h + h - h / 2)) * 20 * scale); 
  end; 
end;

begin
  x := 30; 
  y := 770; 
  scale := 1; 
  SetConsoleIO; 
  repeat
    Writeln('Выберите действие:'); 
    Writeln('1. Рассчитать площадь фигуры'); 
    Writeln('2. Выйти из программы'); 
    Readln(option); 
    ClrScr; 
    case option of 
      1: 
        begin
          n:=100;
          Writeln('Введите пределы интегрирования a и b:'); 
          Readln(a, b); 
          ClrScr;  
          casemenu(a, b, area, error); 
          Writeln('Площадь фигуры:', area:0:3); 
          Writeln('Вычисленная погрешность: ', error); 
          window.Clear; 
          draw_plane(scale, a, b); 
          rects(a, b, x, y, scale); 
          graph(a, b, x, y, scale); 
          repeat
            ch := ReadKey; 
            begin
              ch := ReadKey; 
              case ch of 
                #40: 
                  begin
                    window.Clear; 
                    scale := scale - 1; 
                    draw_plane(scale, a, b); 
                    rects(a, b, x, y, scale); 
                    graph(a, b, x, y, scale); 
                  end; 
                #38: 
                  begin
                    window.Clear; 
                    scale := scale + 1; 
                    draw_plane(scale, a, b); 
                    rects(a, b, x, y, scale); 
                    graph(a, b, x, y, scale); 
                  end; 
              end; 
            end; 
          until ch = #27; 
        end; 
      2: Writeln('До свидание!'); 
    end; 
  until option = 2; 
end.