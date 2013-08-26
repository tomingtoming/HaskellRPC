{-# LANGUAGE OverloadedStrings #-}

import Network
import Network.MessagePackRpc.Server
import Control.Concurrent.STM
import Control.Monad.IO.Class (liftIO)
import System.Random

main :: IO ()
main = withSocketsDo $ do
  stack <- newTVarIO [] :: IO (TVar [Int])
  serve 16544 $
    [
      ("add",   toMethod add),
      ("minus", toMethod minus),
      ("push",  toMethod $ push stack),
      ("pop",   toMethod $ pop stack),
      ("rand",  toMethod rand)
    ]

add :: Int -> Int -> Method Int
add x y = return $ x + y

minus :: Int -> Int -> Method Int
minus x y = return $ x - y

push :: TVar [Int] -> Int -> Method ()
push stack x = liftIO $ atomically $ modifyTVar stack ((:) x)

pop :: TVar [Int] -> Method (Maybe Int)
pop stack = liftIO $ atomically $ do
  ss <- readTVar stack
  case ss of []   -> return Nothing
             x:xs -> writeTVar stack xs >> return (Just x)

rand :: Method Int
rand = liftIO randomIO
