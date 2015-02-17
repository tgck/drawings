public enum MyBlendModes {
  BLEND, 
  ADD,
  SUBTRACT,
  DARKEST,
  LIGHTEST,
  DIFFERENCE,
  EXCLUSION,
  MULTIPLY,
  SCREEN,
  REPLACE
}

//BLEND - linear interpolation of colours: C = A*factor + B. This is the default blending mode.
//ADD - additive blending with white clip: C = min(A*factor + B, 255)
//SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
//DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
//LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
//DIFFERENCE - subtract colors from underlying image.
//EXCLUSION - similar to DIFFERENCE, but less extreme.
//MULTIPLY - multiply the colors, result will always be darker.
//SCREEN - opposite multiply, uses inverse values of the colors.
//REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values
