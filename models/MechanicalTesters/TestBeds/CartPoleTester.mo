within MechanicalTesters.TestBeds;
model CartPoleTester
  MechanicalTesters.CartPole_polar cartPole_polar(y_start=1)  annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=1, f=0.32/2/3.1415)
                                    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
equation
  connect(sine1.y, cartPole_polar.Fs_x) annotation (Line(points={{1,10},{32,10},{32,8},{40,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000,
      Interval=0.002,
      __Dymola_Algorithm="Dassl"));
end CartPoleTester;
