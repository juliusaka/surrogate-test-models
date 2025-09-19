within KoopmanTester.chaotic_lorenz_system;
model chaoticLorenz
  Real x(fixed=true, start = -8);
  Real y(fixed=true, start = 7);
  Real z(fixed=true, start = 27);
  parameter Real sigma = 10.0;
  parameter Real rho = 28.0;
  parameter Real beta = 8/3;

equation
  der(x) = sigma * (y -x);
  der(y) = x * (rho - z) - y;
  der(z) = x * y - beta * z;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>parameter from https://www.pnas.org/action/downloadSupplement?doi=10.1073&percnt;2Fpnas.1517384113&amp;file=pnas.1517384113.sapp.pdf</p>
</html>"));
end chaoticLorenz;
