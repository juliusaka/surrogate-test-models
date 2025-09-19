within SeriesResonanceTesters.Testbeds;
model AdvancedSeriesResonanceTestbed
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine1 annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=200,
    duration=10,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  AdvancedSeriesResonance
                        advancedSeriesResonance
                                              annotation (Placement(transformation(extent={{16,20},{36,40}})));
equation
  connect(ramp.y, sine1.f) annotation (Line(points={{-79,10},{-70,10},{-70,24},{-62,24}}, color={0,0,127}));
  connect(realExpression.y, sine1.amplitude) annotation (Line(points={{-79,50},{-70,50},{-70,36},{-62,36}}, color={0,0,127}));
  connect(sine1.y, advancedSeriesResonance.u) annotation (Line(points={{-39,30},{16,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end AdvancedSeriesResonanceTestbed;
