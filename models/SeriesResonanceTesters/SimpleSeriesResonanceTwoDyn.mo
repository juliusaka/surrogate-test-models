within SeriesResonanceTesters;
model SimpleSeriesResonanceTwoDyn "With two dynamics, a slow is added by modeling a heat port at the resistor\\
  "
  extends BaseClasses.BaseSeriesResonance(resistor1(
      T_ref=293.15,
      alpha=0.01,
      useHeatPort=true));
  import Modelica.Constants.pi;

  Modelica.Blocks.Interfaces.RealInput voltage(start=0) annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C_heat, T(
      fixed=true,
      start=293.15,
      displayUnit="K"))                                                annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=G_heat)
                                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,-50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{-28,-90},{-8,-70}})));
  Modelica.Blocks.Interfaces.RealInput AmbientTemp_K(start=293.15) annotation (Placement(transformation(extent={{-120,-100},{-80,-60}})));
  parameter Real diamResistor=6.5e-3;
  parameter Real lengthResistor=17.5e-3;
  parameter Real rhoResistor=2.335;
  parameter Real c_p_Resistor=703;
  parameter Modelica.Units.SI.HeatCapacity C_heat=10*diamResistor^2/4*pi*lengthResistor*rhoResistor*c_p_Resistor "Heat capacity of element (= cp*m)";
  parameter Modelica.Units.SI.ThermalConductance G_heat=5/75 "Constant thermal conductance of material";
equation
  connect(signalVoltage.v, voltage) annotation (Line(points={{-52,0},{-100,0}}, color={0,0,127}));
  connect(resistor1.heatPort, heatCapacitor.port) annotation (Line(points={{30,0},{26,0},{26,-22},{70,-22},{70,-10}}, color={191,0,0}));
  connect(thermalConductor.port_b, prescribedTemperature.port) annotation (Line(points={{8,-60},{8,-80},{-8,-80}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalConductor.port_a) annotation (Line(points={{70,-10},{70,-22},{8,-22},{8,-40}}, color={191,0,0}));
  connect(AmbientTemp_K, prescribedTemperature.T) annotation (Line(points={{-100,-80},{-30,-80}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>Following&nbsp;https://www.farnell.com/datasheets/3916833.pdf,&nbsp;we&nbsp;assume&nbsp;a&nbsp;5W&nbsp;rated&nbsp;0.5&nbsp;Ohm&nbsp;capacitor&nbsp;for&nbsp;the&nbsp;base&nbsp;case.&nbsp;</p>
<p>As&nbsp;stated&nbsp;there,&nbsp;for&nbsp;5W&nbsp;the&nbsp;temperature&nbsp;rise&nbsp;is&nbsp;75degC,&nbsp;such&nbsp;that&nbsp;alpha=&nbsp;Q_dot&nbsp;/&nbsp;delta&nbsp;T&nbsp;=&nbsp;5/75W&nbsp;W/degC.</p>
<p>We furthermore assume a length of 17.5mm, and a diameter of 6.5mm as described.</p>
<p><br><br>For the thermal properties, we take the properties of silicium, see <a href=\"https://de.wikipedia.org/wiki/Silicium\">https://de.wikipedia.org/wiki/Silicium</a></p>
<p>with rho=2.335kg/m^3 and a heat capacity of 703J/kg K</p>
</html>"), experiment(
      StopTime=0.5,
      Interval=0.0002,
      __Dymola_Algorithm="Dassl"));
end SimpleSeriesResonanceTwoDyn;
