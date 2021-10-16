{-# OPTIONS_GHC -fwarn-missing-signatures #-}

{-# LANGUAGE ExplicitForAll           #-}
{-# LANGUAGE StandaloneKindSignatures #-}

module Chapter07.Geometry.Sphere
    where
--------------------------------------------------------------------------------

volume :: Float -> Float
volume radius = (4.0 / 3.0) * pi * (radius ^ 3)

--------------------------------------------------------------------------------
area :: Float -> Float
area radius = 4 * pi * (radius ^ 2)

--------------------------------------------------------------------------------
