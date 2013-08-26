{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Server

main :: IO ()
main = withSocketsDo $ do
  serve 16544 $
    [
      ("add",   toMethod add),
      ("minus", toMethod minus)
    ]

add :: Int -> Int -> Method Int
add x y = return $ x + y

minus :: Int -> Int -> Method Int
minus x y = return $ x - y
