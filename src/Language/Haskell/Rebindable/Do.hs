{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE GADTs #-}

module Language.Haskell.Rebindable.Do where

import           Data.Default.Class
import           Prelude hiding ((>>), (>>=), return, Monad)
import qualified Control.Monad.Indexed as P
import qualified Prelude as P

data Monad = Monad
  { return :: forall a m. (P.Monad m) => a -> m a
  , (>>=) :: forall a b m. (P.Monad m) =>  m a -> (a -> m b) -> m b
  , (>>) :: forall a b m. (P.Monad m) =>  m a -> m b -> m b
  }

data IxMonad = IxMonad
  { return :: forall a i m. (P.IxMonad m) =>  a -> m i i a
  , (>>=) :: forall a b i j k m. (P.IxMonad m) => m i j a -> (a -> m j k b) -> m i k b
  , (>>) :: forall a b i j k m. (P.IxMonad m) => m i j a -> m j k b -> m i k b
  }

instance Default Monad where
  def = Monad
    { return = P.return
    , (>>=) = (P.>>=)
    , (>>) = (P.>>)
    }

instance Default IxMonad where
  def = IxMonad
    { return = P.ireturn
    , (>>=) = (P.>>>=)
    , (>>) = \a b -> a P.>>>= (\_ -> b)
    }
