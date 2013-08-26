{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Client
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = withSocketsDo $ runClient "localhost" 16544 mainLoop

mainLoop :: Client ()
mainLoop = do
  a:b:c:d:_ <- sequence $ take 10 $ repeat $ rand
  x:y:_     <- sequence [add a b, minus c d]
  _         <- sequence [push x, push y]
  _         <- pop
  res       <- sequence [pop, pop]
  liftIO $ print res
  mainLoop

add :: Int -> Int -> Client Int
add = call "add"

minus :: Int -> Int -> Client Int
minus = call "minus"

push :: Int -> Client ()
push = call "push"

pop :: Client (Maybe Int)
pop = call "pop"

rand :: Client Int
rand = call "rand"
