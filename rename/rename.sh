# find and replace file name with space to underscore
find -name "* *" -type f | rename 's/ /_/g'
find -name "*a*" -type f | rename 's/a/_/g'
find -name "*'*" -type f | rename "s/'//g"