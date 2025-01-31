{ lib, config, ... }:
let
  cfg = config.walnix;
in
rec {
  noHashTagAttrs = attrs: builtins.mapAttrs(color: value: builtins.replaceStrings ["#"] [""] value) attrs;
  rgbStringAttrs = attrs: builtins.mapAttrs(color: value: toRGBString value) (noHashTagAttrs attrs);

  # toRGBString: str -> str
  toRGBString = s: 
      if (builtins.stringLength s) != 6
      then throw "invalid hex color code"
      else lib.concatStrings [
        "rgb(${builtins.toString (fromHexString (builtins.substring 0 2 s))},"
        "${builtins.toString (fromHexString (builtins.substring 2 2 s))},"
        "${builtins.toString (fromHexString (builtins.substring 4 2 s))}) "
      ];
 
  # fromHexString: str -> int 
  fromHexString = 
    let
      con = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "A" = 10;
        "a" = 10;
        "B" = 11;
        "b" = 11;
        "C" = 12;
        "c" = 12;
        "D" = 13;
        "d" = 13;
        "E" = 14;
        "e" = 14;
        "F" = 15;
        "f" = 15;
      }; 
      validateHexString = s: 
        lib.strings.stringAsChars (c: if !builtins.hasAttr c con then builtins.throw "invalid hex string" else c) s;

      # fromHexString': str -> [int] -> int -> int -> int
      fromHexString' = s: a: n: i:
      if i <= 0 then a
      else fromHexString'
        s 
        (a + (con.${builtins.substring (i - 1) 1 s} * (exp 16 n)))
        (n + 1) 
        (i - 1);
    in s: fromHexString' (validateHexString s) 0 0 (builtins.stringLength s);

  # exp: int -> int -> int
  exp = b: e: 
    if e == 0 then 1 
    else if e == 1 then b
    else b * (exp b (e - 1));

}
