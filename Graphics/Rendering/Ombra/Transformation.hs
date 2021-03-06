module Graphics.Rendering.Ombra.Transformation (
        transMat4,
        rotXMat4,
        rotYMat4,
        rotZMat4,
        rotMat4,
        scaleMat4,
        orthoMat4,
        perspectiveMat4,
        cameraMat4,
        lookAtMat4,
        transMat3,
        rotMat3,
        scaleMat3
) where

import Control.Applicative
import Data.Vect.Float
import Foreign.Storable
import Foreign.Ptr (castPtr)

-- | 4x4 translation matrix.
transMat4 :: Vec3 -> Mat4
transMat4 (Vec3 x y z) = Mat4 (Vec4 1 0 0 0)
                              (Vec4 0 1 0 0)
                              (Vec4 0 0 1 0)
                              (Vec4 x y z 1)

-- | 4x4 rotation matrix (X axis).
rotXMat4 :: Float -> Mat4
rotXMat4 a = Mat4 (Vec4 1 0 0 0)
                  (Vec4 0 (cos a) (- sin a) 0)
                  (Vec4 0 (sin a) (cos a) 0)
                  (Vec4 0 0 0 1)

-- | 4x4 rotation matrix (Y axis).
rotYMat4 :: Float -> Mat4
rotYMat4 a = Mat4 (Vec4 (cos a) 0 (sin a) 0)
                  (Vec4 0 1 0 0)
                  (Vec4 (- sin a) 0 (cos a) 0)
                  (Vec4 0 0 0 1)

-- | 4x4 rotation matrix (Z axis).
rotZMat4 :: Float -> Mat4
rotZMat4 a = Mat4 (Vec4 (cos a) (- sin a) 0 0)
                  (Vec4 (sin a) (cos a) 0 0)
                  (Vec4 0 0 1 0)
                  (Vec4 0 0 0 1)

-- | 4x4 rotation matrix.
rotMat4 :: Vec3         -- ^ Axis.
        -> Float        -- ^ Angle
        -> Mat4
rotMat4 v a = let (Mat3 x y z) = rotMatrix3 v a
              in Mat4 (extendZero x)
                      (extendZero y)
                      (extendZero z)
                      (Vec4 0 0 0 1)

-- | 4x4 scale matrix.
scaleMat4 :: Vec3 -> Mat4
scaleMat4 (Vec3 x y z) = Mat4 (Vec4 x 0 0 0)
                              (Vec4 0 y 0 0)
                              (Vec4 0 0 z 0)
                              (Vec4 0 0 0 1)

-- | 4x4 perspective projection matrix.
perspectiveMat4 :: Float        -- ^ Near
                -> Float        -- ^ Far
                -> Float        -- ^ FOV
                -> Float        -- ^ Aspect ratio
                -> Mat4
perspectiveMat4 n f fov ar =
        Mat4 (Vec4 (s / ar) 0 0 0)
             (Vec4 0 s 0 0)
             (Vec4 0 0 ((f + n) / (n - f)) ((2 * f * n) / (n - f)))
             (Vec4 0 0 (- 1) 0)
        where s = 1 / tan (fov * pi / 360)

-- | 4x4 orthographic projection matrix.
orthoMat4 :: Float      -- ^ Near
          -> Float      -- ^ Far
          -> Float      -- ^ Left
          -> Float      -- ^ Right
          -> Float      -- ^ Bottom
          -> Float      -- ^ Top
          -> Mat4
orthoMat4 n f l r b t =
        Mat4 (Vec4 (2 / (r - l)) 0 0 ((r + l) / (r - l)))
             (Vec4 0 (2 / (t - b)) 0 ((t + b) / (t - b)))
             (Vec4 0 0 (2 / (n - f)) (( f + n) / (n - f)))
             (Vec4 0 0 0 1)

-- | 4x4 FPS camera matrix.
cameraMat4 :: Vec3        -- ^ Eye
           -> Float     -- ^ Pitch
           -> Float     -- ^ Yaw
           -> Mat4
cameraMat4 eye pitch yaw =
        Mat4 (Vec4 xx yx zx 0)
             (Vec4 xy yy zy 0)
             (Vec4 xz yz zz 0)
             (Vec4 (- dotprod xv eye) (- dotprod yv eye) (- dotprod zv eye) 1)
        where cosPitch = cos pitch
              sinPitch = sin pitch
              cosYaw = cos yaw
              sinYaw = sin yaw
              xv@(Vec3 xx xy xz) = Vec3 cosYaw 0 $ -sinYaw
              yv@(Vec3 yx yy yz) = Vec3 (sinYaw * sinPitch) cosPitch $
                                        cosYaw * sinPitch
              zv@(Vec3 zx zy zz) = Vec3 (sinYaw * cosPitch) (-sinPitch) $
                                        cosPitch * cosYaw

-- | 4x4 "look at" camera matrix.
lookAtMat4 :: Vec3        -- ^ Eye
           -> Vec3        -- ^ Target
           -> Vec3        -- ^ Up
           -> Mat4
lookAtMat4 eye target up =
        Mat4 (Vec4 xx yx zx 0)
             (Vec4 xy yy zy 0)
             (Vec4 xz yz zz 0)
             (Vec4 (- dotprod xv eye) (- dotprod yv eye) (- dotprod zv eye) 1)
        where zv@(Vec3 zx zy zz) = normalize $ eye &- target
              xv@(Vec3 xx xy xz) = normalize $ crossprod up zv
              yv@(Vec3 yx yy yz) = crossprod zv xv

-- | 3x3 translation matrix.
transMat3 :: Vec2 -> Mat3
transMat3 (Vec2 x y) = Mat3 (Vec3 1 0 0)
                            (Vec3 0 1 0)
                            (Vec3 x y 1)

-- | 3x3 rotation matrix.
rotMat3 :: Float -> Mat3
rotMat3 a = Mat3 (Vec3 (cos a) (sin a) 0)
                 (Vec3 (- sin a) (cos a) 0)
                 (Vec3 0 0 1)

-- | 3x3 scale matrix.
scaleMat3 :: Vec2 -> Mat3
scaleMat3 (Vec2 x y) = Mat3 (Vec3 x 0 0)
                            (Vec3 0 y 0)
                            (Vec3 0 0 1)

zipWithM_ :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m ()
zipWithM_ f xs = sequence_ . zipWith f xs
