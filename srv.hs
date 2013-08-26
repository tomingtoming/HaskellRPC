{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Server
import Data.MessagePack

main :: IO ()
main = withSocketsDo $ do
  serve 16544 $
    [
      ("add", add)
    ]

add :: RpcMethod IO
add []    = print "EMPTY!" >> return (toObject ())
add [_]   = print "1ARG!"  >> return (toObject ())
add [x,y] = print "2ARGS!" >> return (toObject ((fromObject x :: Int) + (fromObject y :: Int)))
