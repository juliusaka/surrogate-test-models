within SeriesResonanceTesters;
model AdvancedSeriesResonance "Advaned Series Resonance with multiple parallel capacitors"
  extends BaseClasses.BaseSeriesResonance;
  import Modelica.Constants.pi;
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(v(fixed=true), C=0.001/(2*pi)) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor3(v(fixed=true), C=0.001/(2*pi)) annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Interfaces.RealInput u(start=0) annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(inductor1.n, capacitor2.p) annotation (Line(points={{-10,20},{6,20},{6,50},{10,50}}, color={0,0,255}));
  connect(inductor1.n, capacitor3.p) annotation (Line(points={{-10,20},{6,20},{6,80},{10,80}}, color={0,0,255}));
  connect(capacitor2.n, resistor1.p) annotation (Line(points={{30,50},{40,50},{40,10}}, color={0,0,255}));
  connect(u, signalVoltage.v) annotation (Line(points={{-100,0},{-78,0},{-78,0},{-52,0}}, color={0,0,127}));
  connect(capacitor3.n, resistor1.p) annotation (Line(points={{30,80},{40,80},{40,10}}, color={0,0,255}));
end AdvancedSeriesResonance;
