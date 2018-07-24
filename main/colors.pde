static class Color {
  static color BACKGROUND = #E6E6E6;
  static color EMPTY = #D7D7D7;
  static color CABLE_OFF = #B4B4B4;
  static color CABLE_ON = #DBD44E;
  static color SOURCE = #F2E24F;
  static color INVERTER_OFF = #CE4E4A;
  static color INVERTER_ON = #F95E59;
  static color VIA_OFF = #589EC9;
  static color VIA_ON = #75BDEA;
  static color DELAY_OFF = #59C664;
  static color DELAY_ON = #62DB6E;

  static color getFromType(BlockType type, boolean charge) {
    if (charge) {
      switch (type) {
        case CABLE: return CABLE_ON;
        case SOURCE: return SOURCE;
        case INVERTER: return INVERTER_ON;
        case VIA: return VIA_ON;
        case DELAY: return DELAY_ON;
        default: return EMPTY;
      }
    } else {
      switch(type) {
        case CABLE: return CABLE_OFF;
        case SOURCE: return SOURCE;
        case INVERTER: return INVERTER_OFF;
        case VIA: return VIA_OFF;
        case DELAY: return DELAY_OFF;
        default: return EMPTY;
      }
    }
  }
}