{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Client
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = withSocketsDo $ runClient "localhost" 16544 $ do
  res1 <- add 5 10
  liftIO $ print res1
  res2 <- minus 5 10
  liftIO $ print res2
  res3 <- add res1 res2
  liftIO $ print res3

add :: Int -> Int -> Client Int
add = call "add"

minus :: Int -> Int -> Client Int
minus = call "minus"
