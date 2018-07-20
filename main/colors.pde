color COLOR_BACKGROUND = #E6E6E6;
color COLOR_EMPTY = #D7D7D7;
color COLOR_CABLE_OFF = #B4B4B4;
color COLOR_CABLE_ON = #DBD44E;
color COLOR_SOURCE = #F2E24F;
color COLOR_INVERTER_OFF = #CE4E4A;
color COLOR_INVERTER_ON = #F95E59;
color COLOR_VIA_OFF = #589EC9;
color COLOR_VIA_ON = #75BDEA;
color COLOR_DELAY_OFF = #59C664;
color COLOR_DELAY_ON = #62DB6E;

color getColorFromType(BlockType type, boolean charge) {
  if (charge) {
    switch (type) {
      case CABLE: return COLOR_CABLE_ON;
      case SOURCE: return COLOR_SOURCE;
      case INVERTER: return COLOR_INVERTER_ON;
      case VIA: return COLOR_VIA_ON;
      case DELAY: return COLOR_DELAY_ON;
      default: return COLOR_EMPTY;
    }
  } else {
    switch(type) {
      case CABLE: return COLOR_CABLE_OFF;
      case SOURCE: return COLOR_SOURCE;
      case INVERTER: return COLOR_INVERTER_OFF;
      case VIA: return COLOR_VIA_OFF;
      case DELAY: return COLOR_DELAY_OFF;
      default: return COLOR_EMPTY;
    }
  }
}