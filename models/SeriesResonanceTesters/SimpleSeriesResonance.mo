within SeriesResonanceTesters;
model SimpleSeriesResonance
  extends BaseClasses.BaseSeriesResonance;
  Modelica.Blocks.Interfaces.RealInput u(start=0) annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(signalVoltage.v, u) annotation (Line(points={{-52,0},{-100,0}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.5,
      Interval=0.0002,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end SimpleSeriesResonance;
