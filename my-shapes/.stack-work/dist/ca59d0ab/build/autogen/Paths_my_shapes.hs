{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_my_shapes (
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

bindir     = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\bin"
libdir     = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\lib\\x86_64-windows-ghc-8.0.2\\my-shapes-0.1.0.0-1u8ZCrX5ylSDv8e59Ost1k"
dynlibdir  = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\share\\x86_64-windows-ghc-8.0.2\\my-shapes-0.1.0.0"
libexecdir = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\libexec"
sysconfdir = "C:\\Users\\Liam\\Desktop\\topics-in-func\\my-shapes\\.stack-work\\install\\34070b1b\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_shapes_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_shapes_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "my_shapes_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "my_shapes_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_shapes_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_shapes_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
