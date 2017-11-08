{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_SimpleSignalExample (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/bin"
libdir     = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/lib/x86_64-linux-ghc-8.0.2/SimpleSignalExample-0.1.0.0"
dynlibdir  = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/share/x86_64-linux-ghc-8.0.2/SimpleSignalExample-0.1.0.0"
libexecdir = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/libexec"
sysconfdir = "/users/ugrad/lfarrel6/Desktop/haskell/SimpleSignalExample-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "SimpleSignalExample_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "SimpleSignalExample_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "SimpleSignalExample_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "SimpleSignalExample_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "SimpleSignalExample_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "SimpleSignalExample_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
