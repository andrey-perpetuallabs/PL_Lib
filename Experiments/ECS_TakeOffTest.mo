within PL_Lib.Experiments;
model ECS_TakeOffTest
  extends Modelica.Icons.Example;
  import SI = Modelica.SIunits;
  replaceable package HotFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package ColdFluid = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;

  parameter SI.Time t_takeoff=300;
  parameter SI.Time t_startCruise=600;
  parameter SI.MassFlowRate whex_RA=0.025 "nominal (and initial) mass flow rate";
  parameter SI.MassFlowRate whex_BA=0.025 "nominal (and initial) mass flow rate";
  parameter SI.Pressure phex_RA_00km=101325 "Initial pressure";
  parameter SI.Pressure phex_RA_10km=26500 "Atmospheric pressure at 10km elevation";
  parameter SI.Pressure phex_BA_00km=206843 "Bleed air pressure (minimum)";
  parameter SI.Pressure phex_BA_10km=344748 "Bleed air pressure (maximum)";
  parameter SI.Temperature Thex_in_RA_00km=273.15 + 20 "initial inlet temperature at ground level";
  parameter SI.Temperature Thex_in_RA_10km=273.15 - 25 "Inlet ram air temperature at 10km elevation";
  parameter SI.Temperature Thex_in_BA_00km=273.15 + 300 "Bleed air temperature (minimum)";
  parameter SI.Temperature Thex_in_BA_10km=273.15 + 400 "Bleed air temperature (maximum)";

  inner ThermoPower.System system annotation (Placement(transformation(extent={{80,80},{100,100}})));
  replaceable Configurations.ECS_hybridConfig ECS_config(
    redeclare package ColdFluid = ColdFluid,
    redeclare package HotFluid = HotFluid,
    whex_cold=whex_RA,
    whex_hot=whex_BA) constrainedby Interfaces.ConfigurationBase annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  replaceable Modelica.Blocks.Sources.Ramp inputT_cold_in(
    height=Thex_in_RA_10km - Thex_in_RA_00km,
    duration=t_startCruise,
    offset=Thex_in_RA_00km,
    startTime=t_takeoff) constrainedby Modelica.Blocks.Interfaces.SO annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  replaceable Modelica.Blocks.Sources.Ramp inputP_cold_in(
    height=phex_RA_10km - phex_RA_00km,
    duration=t_startCruise,
    offset=phex_RA_00km,
    startTime=t_takeoff) constrainedby Modelica.Blocks.Interfaces.SO annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  replaceable Modelica.Blocks.Sources.Constant inputT_hot_in(k=Thex_in_BA_00km) constrainedby Modelica.Blocks.Interfaces.SO annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  replaceable Modelica.Blocks.Sources.Constant inputP_hot_in(k=phex_BA_00km) constrainedby Modelica.Blocks.Interfaces.SO annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  replaceable Modelica.Blocks.Sources.Step Tcabin_set(
    height=4,
    offset=273.15 + 20,
    startTime= 1000) constrainedby Modelica.Blocks.Interfaces.SO annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  PL_Lib.Interfaces.SignalBus DataLogger annotation (Placement(transformation(extent={{40,-20},{80,20}}), iconTransformation(extent={{80,-20},{120,20}})));
equation
  connect(inputT_cold_in.y, ECS_config.T_cold_in) annotation (Line(points={{-69,60},{-40,60},{-40,24},{-30,24}}, color={0,0,127}));
  connect(inputP_cold_in.y, ECS_config.p_cold_in) annotation (Line(points={{-69,20},{-42,20},{-42,9},{-30,9}}, color={0,0,127}));
  connect(inputP_hot_in.y, ECS_config.p_hot_in) annotation (Line(points={{-69,-60},{-40,-60},{-40,-24},{-30,-24}}, color={0,0,127}));
  connect(inputT_hot_in.y, ECS_config.T_hot_in) annotation (Line(points={{-69,-20},{-42,-20},{-42,-9},{-30,-9}}, color={0,0,127}));
  connect(Tcabin_set.y, ECS_config.Tcabin_set) annotation (Line(points={{1,70},{12,70},{12,30}}, color={0,0,127}));
  connect(ECS_config.signalBus, DataLogger) annotation (Line(
      points={{30,0},{60,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StartTime=0,
      StopTime=1500,
      Tolerance=1e-06,
      Interval=3));
end ECS_TakeOffTest;