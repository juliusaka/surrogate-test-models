within SeriesResonanceTesters.Testbeds;
model SimpleSeriesResonanceTwoDynTestbed
  Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine1 annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1000,
    duration=10,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=50)
                                                             annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  SimpleSeriesResonanceTwoDyn
                        simpleSeriesResonanceTwoDyn(heatCapacitor(T(fixed=false, start=293.15)))
                                              annotation (Placement(transformation(extent={{16,20},{36,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=293.15)
                                                             annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=200)
                                                             annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
equation
  connect(realExpression1.y, simpleSeriesResonanceTwoDyn.AmbientTemp_K) annotation (Line(points={{-19,-10},{8,-10},{8,22},{16,22}}, color={0,0,127}));
  connect(sine1.y, simpleSeriesResonanceTwoDyn.voltage) annotation (Line(points={{-39,30},{16,30}}, color={0,0,127}));
  connect(realExpression.y, sine1.amplitude) annotation (Line(points={{-79,50},{-70,50},{-70,36},{-62,36}}, color={0,0,127}));
  connect(ramp.y, sine1.f) annotation (Line(points={{-79,10},{-70,10},{-70,24},{-62,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SimpleSeriesResonanceTwoDynTestbed;
