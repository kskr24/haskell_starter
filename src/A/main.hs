import Data.ByteString.Char8 (drop, getLine, readInt)
import Data.ByteString.Char8 qualified as B
import Data.List (sort, unfoldr)

main :: IO ()
main = do
  list <- list
  print list

list :: IO [Int]
list = unfoldr (B.drop 1 ∴ B.readInt) <$> B.getLine
  where
    (∴) = fmap . fmap . fmap