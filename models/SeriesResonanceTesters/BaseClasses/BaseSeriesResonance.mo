within SeriesResonanceTesters.BaseClasses;
model BaseSeriesResonance "Base Series resonance circuit, adapted from Modelica Standard Library Modelica.Electrical.Analog.Examples.SeriesResonance"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(i(fixed=true), L=L)           annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(v(fixed=true), C=C)             annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  parameter Modelica.Units.SI.Inductance L=0.1/(2*pi) "Inductance";
  parameter Modelica.Units.SI.Capacitance C=0.001/(2*pi) "Capacitance";
  parameter Modelica.Units.SI.Resistance R=0.5 "Resistance at temperature T_ref";
equation
  connect(inductor1.n, capacitor1.p)
    annotation (Line(points={{-10,20},{10,20}}, color={0,0,255}));
  connect(capacitor1.n, resistor1.p)
    annotation (Line(points={{30,20},{40,20},{40,10}}, color={0,0,255}));
  connect(resistor1.n, ground1.p) annotation (Line(points={{40,-10},{40,-20},{-40,-20}}, color={0,0,255}));
  connect(signalVoltage.n, inductor1.p) annotation (Line(points={{-40,10},{-40,20},{-30,20}}, color={0,0,255}));
  connect(signalVoltage.p, ground1.p) annotation (Line(points={{-40,-10},{-40,-20}}, color={0,0,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=100000,
      __Dymola_Algorithm="Dassl"),                       Documentation(info="<html>
<p>
This model demonstrates the transient behaviour of a series resonant circuit:
A sine or cosine voltage with variable frequency and constant amplitude is applied to a series connection of L, C and R.
The parameter values result in a resonance frequency of 100 Hz.
</p>
</html>"));
end BaseSeriesResonance;
