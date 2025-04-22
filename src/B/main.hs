import Data.ByteString (ByteString)
import Data.ByteString qualified as B
import Data.ByteString.Char8 (readInt)
import Data.List (unfoldr)
import Data.Maybe (isNothing)

main :: IO ()
main = do
  arr <- array
  print arr

array :: IO [Int]
array = unfoldr cleaner <$> B.getLine

-- need a function that extracts an int and cleans the rest of the bytestring
cleaner :: ByteString -> Maybe (Int, ByteString)
cleaner token =
  if isNothing (readInt token)
    then Nothing
    else B.drop 1 .: readInt token
  where
    (.:) = fmap . fmap
