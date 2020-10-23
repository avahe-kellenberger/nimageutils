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

  for y in countup(0, maxComponent - 1):
    for x in countup(0, maxComponent - 1):
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

converter c(a: array[7, int]): array[7, uint8] = 
  for i, x in a:
    result[i] = x.uint8

if isMainModule:
  const data: array[7, uint8] =
    [
      1, 1, 1, 1, 1, 1, 1
    ]

  let
    # 45 degrees
    radians = math.PI / 4
    width = 7
    height = 1
    maxComponent = max(width, height)
    rotated = rotateBySampling(data, width, height, radians)

  for y in 0 ..< maxComponent:
    var row = ""
    for x in 0 ..< maxComponent:
      row &= $rotated[y * maxComponent + x] & " "
    echo row

