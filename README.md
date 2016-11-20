# rebindable

[![Hackage Status](https://img.shields.io/hackage/v/rebindable.svg)](https://hackage.haskell.org/package/rebindable)

A library to facilitate rebinding of syntax.

## Example:

```haskell
{-# LANGUAGE RebindableSyntax #-}
{-# LANGUAGE RecordWildCards #-}

module Example where

import Control.Monad.Indexed
import Control.Monad.Indexed.State
import Control.Monad.Indexed.Trans
import Control.Monad.IO.Class
import Prelude

import qualified Language.Haskell.Rebindable as Use
import Data.Default

foo :: IxStateT IO String Int ()
foo = let Use.IxMonad{..} = def in do
  ilift . liftIO . print =<< iget

  imodify (length)
  ilift . liftIO . print =<< iget
```
