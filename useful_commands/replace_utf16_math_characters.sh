#/bin/bash


sed 's/\xEF\x80\xAD/-/g' | # soft hyphen
sed 's/\xEF\x80\xBD/=/g' | # double hyphen
sed 's/\xEF\x83\x9E/⇒/g' | # arrow
sed 's/\xEF\x83\x97/·/g' | # dot
sed 's/\xEF\x81\x9B/[/g' | # open bracket
sed 's/\xEF\x81\x9D/]/g' | # close bracket
sed 's/\xEF\x82\xB1/±/g' | # plus minus
sed 's/\xEF\x81\x84/∆/g' | # capital delta
sed 's/\xEF\x81\xB0/π/g' | # pi
sed 's/\xEF\x81\xB1/θ/g' | # theta
sed "s/\xEF\x82\xA2/'/g" | # apostrophe
sed 's/\xEF\x80\xA8/(/g' | # open parenthesis
sed 's/\xEF\x83\xA7/(/g' | # open parenthesis
sed 's/\xEF\x83\xA8/ /g' | # not sure
sed 's/\xEF\x80\xA9/)/g' | # close parenthesis
sed 's/\xEF\x83\xB7/)/g' | # close parenthesis
sed 's/\xEF\x83\xB8/ /g' | # not sure
sed 's/\xEF\x82\xB6/δ/g' | # delta
sed 's/\xEF\x82\xB0/°/g' | # delta
sed 's/\xEF\x80\xAB/+/g' # plus sign
