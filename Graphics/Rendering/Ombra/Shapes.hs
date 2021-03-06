module Graphics.Rendering.Ombra.Shapes where

import Data.Vect.Float
import Graphics.Rendering.Ombra.Geometry
import Graphics.Rendering.Ombra.Types
import Graphics.Rendering.Ombra.Internal.GL (GLES)

rectGeometry :: GLES => Vec2 -> Geometry Geometry2D
rectGeometry (Vec2 w h) = mkGeometry2D [ Vec2 (-hw) (-hh)
                                       , Vec2 hw    (-hh)
                                       , Vec2 hw    hh
                                       , Vec2 (-hw) hh ]
                                       [ Vec2 0 0
                                       , Vec2 1 0
                                       , Vec2 1 1
                                       , Vec2 0 1 ]
                                       [ 0, 1, 2, 0, 3, 2 ]
        where (hw, hh) = (w / 2, h / 2)

cubeGeometry :: GLES => Geometry Geometry3D
cubeGeometry =
        mkGeometry3D
                [ Vec3 1.0 1.0 (-0.999999), 
                  Vec3 1.0 (-1.0) (-1.0), 
                  Vec3 (-1.0) 1.0 (-1.0), 
                  Vec3 (-1.0) (-1.0) 1.0, 
                  Vec3 (-1.0) 1.0 1.0, 
                  Vec3 (-1.0) (-1.0) (-1.0), 
                  Vec3 (-1.0) (-1.0) 1.0, 
                  Vec3 1.0 (-1.0) 1.0, 
                  Vec3 (-1.0) 1.0 1.0, 
                  Vec3 1.0 (-1.0) 1.0, 
                  Vec3 1.0 (-1.0) (-1.0), 
                  Vec3 0.999999 1.0 1.000001, 
                  Vec3 1.0 1.0 (-0.999999), 
                  Vec3 (-1.0) 1.0 (-1.0), 
                  Vec3 0.999999 1.0 1.000001, 
                  Vec3 1.0 (-1.0) (-1.0), 
                  Vec3 1.0 (-1.0) 1.0, 
                  Vec3 (-1.0) (-1.0) (-1.0), 
                  Vec3 (-1.0) (-1.0) (-1.0), 
                  Vec3 (-1.0) 1.0 (-1.0), 
                  Vec3 0.999999 1.0 1.000001, 
                  Vec3 1.0 1.0 (-0.999999), 
                  Vec3 (-1.0) 1.0 1.0, 
                  Vec3 (-1.0) (-1.0) 1.0 ]
                [ Vec2 0.9999 1.0e-4, 
                  Vec2 0.9999 0.9999, 
                  Vec2 1.0e-4 1.0e-4, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 1.0e-4 1.0e-4, 
                  Vec2 0.9999 0.9999, 
                  Vec2 1.0e-4 1.0e-4, 
                  Vec2 0.9999 1.0e-4, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 1.0e-4 1.0e-4, 
                  Vec2 0.9999 1.0e-4, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 0.9999 0.9999, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 0.9999 1.0e-4, 
                  Vec2 0.9999 0.9999, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 0.9999 1.0e-4, 
                  Vec2 1.0e-4 0.9999, 
                  Vec2 0.9999 1.0e-4, 
                  Vec2 0.9999 0.9999, 
                  Vec2 0.9999 0.9999, 
                  Vec2 1.0e-4 1.0e-4, 
                  Vec2 1.0e-4 1.0e-4 ]
                [ Vec3 0.0 0.0 (-1.0), 
                  Vec3 0.0 0.0 (-1.0), 
                  Vec3 0.0 0.0 (-1.0), 
                  Vec3 (-1.0) (-0.0) (-0.0), 
                  Vec3 (-1.0) (-0.0) (-0.0), 
                  Vec3 (-1.0) (-0.0) (-0.0), 
                  Vec3 (-0.0) (-0.0) 1.0, 
                  Vec3 (-0.0) (-0.0) 1.0, 
                  Vec3 (-0.0) (-0.0) 1.0, 
                  Vec3 1.0 (-0.0) 0.0, 
                  Vec3 1.0 (-0.0) 0.0, 
                  Vec3 1.0 (-0.0) 0.0, 
                  Vec3 0.0 1.0 0.0, 
                  Vec3 0.0 1.0 0.0, 
                  Vec3 0.0 1.0 0.0, 
                  Vec3 0.0 (-1.0) 0.0, 
                  Vec3 0.0 (-1.0) 0.0, 
                  Vec3 0.0 (-1.0) 0.0, 
                  Vec3 0.0 0.0 (-1.0), 
                  Vec3 (-1.0) (-0.0) (-0.0), 
                  Vec3 (-0.0) (-0.0) 1.0, 
                  Vec3 1.0 (-0.0) 0.0, 
                  Vec3 0.0 1.0 0.0, 
                  Vec3 0.0 (-1.0) 0.0 ]
                [ 0, 1, 2,
                  3, 4, 5,
                  6, 7, 8,
                  9, 10, 11,
                  12, 13, 14,
                  15, 16, 17,
                  1, 18, 2,
                  4, 19, 5,
                  7, 20, 8,
                  10, 21, 11,
                  13, 22, 14,
                  16, 23, 17 ]
