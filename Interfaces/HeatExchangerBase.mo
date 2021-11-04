within PL_Lib.Interfaces;
partial model HeatExchangerBase
  outer ThermoPower.System system "System wide properties";
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching = true);

  ThermoPower.Gas.FlangeA infl_1(redeclare package Medium = Medium) annotation (Placement(transformation(rotation=0, extent={{-110,40},{-90,60}}), iconTransformation(extent={{-110,40},{-90,60}})));
  ThermoPower.Gas.FlangeA infl_2(redeclare package Medium = Medium) annotation (Placement(transformation(rotation=0, extent={{-110,-60},{-90,-40}}), iconTransformation(extent={{-110,-60},{-90,-40}})));
  ThermoPower.Gas.FlangeB outfl_1(redeclare package Medium = Medium) annotation (Placement(transformation(rotation=0, extent={{90,40},{110,60}}), iconTransformation(extent={{90,40},{110,60}})));
  ThermoPower.Gas.FlangeB outfl_2(redeclare package Medium = Medium) annotation (Placement(transformation(rotation=0, extent={{90,-60},{110,-40}}), iconTransformation(extent={{90,-60},{110,-40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatExchangerBase;
