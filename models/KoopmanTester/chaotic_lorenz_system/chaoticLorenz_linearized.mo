within KoopmanTester.chaotic_lorenz_system;
model chaoticLorenz_linearized
  Modelica_LinearSystems2.Controller.StateSpace stateSpace(system=Modelica_LinearSystems2.StateSpace.Import.fromFile("dslin.mat", "ABCD"), blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Continuous)
                                                           annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Sources.Step step(
    height=0.2,
    offset=0.6,
    startTime=1) annotation (Placement(transformation(extent={{-88,-22},{-68,-2}})));
equation
  connect(step.y, stateSpace.u[1]) annotation (Line(points={{-67,-12},{-30,-12},{-30,-10},{-22,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end chaoticLorenz_linearized;
