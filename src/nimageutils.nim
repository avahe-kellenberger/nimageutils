import math

proc rotateBySampling*(data: openArray[uint8], width, height: int, radians: float): seq[uint8] =
  ## Rotates the image data via RSamp.
  if width < 1 or height < 1:
    raise newException(Exception, "Width and height must be positive.")

  let
    maxComponent = max(width, height)
    centerIndex = (maxComponent - 1) / 2
    # Offset is from new to old
    offsetX = (width - maxComponent) div 2
    offsetY = (height - maxComponent) div 2
    cosRadians = cos(radians)
    sinRadians = sin(radians)

  result = newSeq[uint8](maxComponent * maxComponent)

  for y in 0 ..< maxComponent:
    for x in 0 ..< maxComponent:
      let
        dx = x.float - centerIndex
        dy = y.float - centerIndex
        # Pixel location in the old image, if it were square.
        xi = round(cosRadians * dx - sinRadians * dy + centerIndex).int
        yi = round(cosRadians * dy + sinRadians * dx + centerIndex).int

      # Index of the pixel in the new image
      let
        newIndex = y * width + x
        currOffsetX = xi + offsetX
        currOffsetY = yi + offsetY

      var oldIndex: int = -1
      if currOffsetX >= 0 and currOffsetX < data.len and
         currOffsetY >= 0 and currOffsetY < data.len:
        oldIndex = xi + yi * width + (offsetY * width)

      if oldIndex >= 0 and oldIndex < data.len:
        result[newIndex] = data[oldIndex]

