within MechanicalTesters;
model CartPole_polar "cart pole"
  // From the lecture system simulation by Johannes Brunnemann at University of Technolog Hamburg (2024)
  import Modelica.Units.SI;
  constant SI.Acceleration g = Modelica.Constants.g_n "Erdbeschleunigung";
  constant SI.Acceleration pi = Modelica.Constants.pi;

  parameter SI.Mass m = 1 "Masse des Körpers";
  parameter SI.Mass M = 1 "Masse des Schlittens";
  parameter SI.Length L = 1 "Länge des Pendels";

  parameter Real pendulum_start_rel(min=-1.0, max=1.0) = 0.9 "relative tart position of pendulum in [-1, 1]";
  parameter SI.Position y_start = pendulum_start_rel * L "y start position of pendulum in [-L,L]";
  parameter SI.Velocity vy_start = 0 "start velocity of pendulum in y-direction";
  parameter SI.Velocity vx_start = 0 "start velocity of pendulum in x-direction";
  parameter SI.Position xs_start = 0;
  parameter SI.Velocity vs_start = 0;

  final parameter Real theta_start = acos(-y_start/L);
  final parameter Real omega_start = if y_start <=0.9*L and y_start >=-0.9*L then vy_start/L/sin(theta_start) else (vx_start-vs_start)/L/cos(theta_start);

  SI.Position x "Position in x-Richtung";
  SI.Position y "Position in y-Richtung";
  SI.Velocity vx "Geschwindigkeit in x-Richtung";
  SI.Velocity vy "Geschwindigkeit in y-Richtung";

  Real omega  "Winkelgeschwindigkeit";
  Real theta  "Drehwinkel";

 // SI.Force Fp "Kraft entlang starrem Pendel";

  SI.Position xs "x-Position of slid ";

  SI.Velocity vs "Geschwindigkeit des Schlittens in x-Richtung";

  Modelica.Blocks.Interfaces.RealInput  Fs_x "Kraft auf den Schlitten" annotation (Placement(transformation(extent={{-128,50},{-88,90}}), iconTransformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealOutput outp_position[6] "{'x','y','xs','vx','vy','vs'}" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110}),                                                                                                                                  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
initial equation
  theta = theta_start;
  vs=vs_start;
  omega = omega_start;
  xs=xs_start;
equation
  x-xs =   L * sin(theta);
  y = - L * cos(theta);

  vx -vs = L*cos(theta)*omega;
  vy = L*sin(theta)*omega;

  der(xs)=vs;
  der(theta) = omega;

  (M+m)*der(vs)=Fs_x + L*(sin(theta)*omega^2 - cos(theta)*der(omega));
  L*der(omega) +cos(theta)*der(vs)+sin(theta)*g=0;

  outp_position={x,y,xs,vx,vy,vs};
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={231,230,236},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-54,2},{52,-42}},
          lineColor={28,108,200},
          fillColor={231,230,236},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Line(
          points={{-6,2},{38,80}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-48,-70},{0,-70},{46,-70}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Filled,Arrow.Filled}),
        Line(
          points={{14,36},{22,30},{26,26},{28,24},{32,18},{36,10},{36,0}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.Filled}),
        Ellipse(
          extent={{-10,8},{0,-2}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={231,230,236},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,90},{46,74}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={231,230,236},
          fillPattern=FillPattern.Solid)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end CartPole_polar;
