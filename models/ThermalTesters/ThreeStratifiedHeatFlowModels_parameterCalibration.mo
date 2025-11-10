within ThermalTesters;
model ThreeStratifiedHeatFlowModels_parameterCalibration
  ThermalTesters.ThreeStratifiedHeatFlowModels threeStratifiedHeatFlowModels(
    temperature_K_a(fixed=true, start=temperature_K_a_start),
    temperature_K_b(fixed=true, start=temperature_K_b_start),
    C1=C1,
    R1=R1,
    C2=C2,
    R2=R2,
    C3=C3,
    R3=R3) annotation (Placement(transformation(extent={{-38,-20},{42,6}})));
  parameter Modelica.Units.SI.HeatCapacity C1=0.2 "Heat capacity of all elements (= cp*m)";
  parameter Modelica.Units.SI.ThermalResistance R1=0.3 "Constant thermal resistance of one element";
  parameter Modelica.Units.SI.HeatCapacity C2=1.0 "Heat capacity of all elements (= cp*m)";
  parameter Modelica.Units.SI.ThermalResistance R2=0.1 "Constant thermal resistance of one element";
  parameter Modelica.Units.SI.HeatCapacity C3=0.6 "Heat capacity of all elements (= cp*m)";
  parameter Modelica.Units.SI.ThermalResistance R3=0.6 "Constant thermal resistance of one element";
  parameter Modelica.Blocks.Interfaces.RealInput temperature_K_a_start=393.15;
  parameter Modelica.Blocks.Interfaces.RealInput temperature_K_b_start=393.15;
  Modelica.Blocks.Sources.Step step(
    height=20,
    offset=273.15,
    startTime=0.5)                                         annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15)
                                                              annotation (Placement(transformation(extent={{60,-20},{40,0}})));
equation
  connect(realExpression.y, threeStratifiedHeatFlowModels.temperature_K_b) annotation (Line(points={{39,-10},{39,-24},{24.2222,-24},{24.2222,-7}}, color={0,0,127}));
  connect(step.y, threeStratifiedHeatFlowModels.temperature_K_a) annotation (Line(points={{-79,-10},{-20.2222,-10},{-20.2222,-7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ThreeStratifiedHeatFlowModels_parameterCalibration;
