# Tests for RSamp rotation.
import unittest, math

import nimageutils

const 
  # 90 degrees
  halfPI = PI * 0.5
  # 45 degrees
  quarterPI = PI * 0.25

proc printImageData(data: openArray[uint8], width, height: int) =
  let maxComponent = max(width, height)
  for y in 0 ..< maxComponent:
    var row = ""
    for x in 0 ..< maxComponent:
      row &= $data[y * maxComponent + x] & " "
    echo row

test "can rotate 1x7 by 90 degrees":
  let
    imageData: array[7, uint8] =
      [
        1u8, 2, 3, 4, 5, 6, 7
      ]
    width = 7
    height = 1
    rotated = rotateBySampling(imageData, width, height, halfPI)

  check rotated == [
    0u8, 0, 0, 7, 0, 0, 0,
    0,   0, 0, 6, 0, 0, 0,
    0,   0, 0, 5, 0, 0, 0,
    0,   0, 0, 4, 0, 0, 0,
    0,   0, 0, 3, 0, 0, 0,
    0,   0, 0, 2, 0, 0, 0,
    0,   0, 0, 1, 0, 0, 0
  ]

test "can rotate 1x7 45 degrees":
  let
    imageData: array[7, uint8] =
      [
        1u8, 2, 3, 4, 5, 6, 7
      ]
    width = 7
    height = 1
    rotated = rotateBySampling(imageData, width, height, quarterPI)
  check rotated == [
    0u8, 0, 0, 0, 0, 0, 0,
    0,   0, 0, 0, 0, 7, 0,
    0,   0, 0, 0, 5, 0, 0,
    0,   0, 0, 4, 0, 0, 0,
    0,   0, 3, 0, 0, 0, 0,
    0,   1, 0, 0, 0, 0, 0,
    0,   0, 0, 0, 0, 0, 0
  ]

test "can rotate 4x3 by 90 degrees":
  let
    imageData: array[12, uint8] =
      [
        1u8, 2, 3, 4,
        1,   2, 3, 4,
        1,   2, 3, 4
      ]
    width = 4
    height = 3
    rotated = rotateBySampling(imageData, width, height, halfPI)
  check rotated == [
    4u8, 4, 4, 0,
    3,   3, 3, 0,
    2,   2, 2, 0,
    1,   1, 1, 0
  ]

