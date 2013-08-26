{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Client
import Data.MessagePack
import qualified Data.ByteString.Char8 as C8

main :: IO ()
main = withSocketsDo $ do
  runClient "localhost" 16544 add

add :: Client Int
add = call "add" (1::Int) (1::Int)
