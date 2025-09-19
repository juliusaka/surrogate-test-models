within SeriesResonanceTesters.Testbeds;
model SimpleSeriesResonanceTestbed
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine1 annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=200,
    duration=10,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=50) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  SimpleSeriesResonance simpleSeriesResonance annotation (Placement(transformation(extent={{16,20},{36,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=10) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(realExpression.y, sine1.amplitude) annotation (Line(points={{-79,50},{-70,50},{-70,36},{-62,36}}, color={0,0,127}));
  connect(sine1.y, simpleSeriesResonance.u) annotation (Line(points={{-39,30},{6,30},{6,30},{16,30}}, color={0,0,127}));
  connect(realExpression1.y, sine1.f) annotation (Line(points={{-79,-30},{-70,-30},{-70,24},{-62,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SimpleSeriesResonanceTestbed;
