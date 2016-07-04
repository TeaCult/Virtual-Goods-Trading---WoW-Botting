$u0 =    "xxxx@hotmail.com"
$u1 =    "xxxx@hotmail.com"
$u2 =    "xxxx@hotmail.com"
$u3 =    "xxxx@hotmail.com"
$u4 =    "xxxx@hotmail.com";dummy
$u5 =    "xxxx@windowslive.com" ;dummy

$p0 =    "xxxx"
$p1 =    "xxxx"
$p2 =    "xxxx"
$p3 =    "xxxx"
$p4 =    "xxxx";dummy
$p5 =    "xxxx" ;dummy

$NumberOfAccounts = 6
$NumberOfExcludes = 2
dim $Exclude[$NumberOfExcludes] = [4,5] ;NumberOfExcludes'a dikkat! EN az 2 exclude gerekiyor array cunku (Yukarida güncelle); dim $Exclude[$NumberOfExcludes] = [0,1,2,3,4,5,6]

dim $UserNames [$NumberOfAccounts] = [$u0,$u1,$u2,$u3,$u4,$u5]
dim $Passwords [$NumberOfAccounts] = [$p0,$p1,$p2,$p3,$p4,$p5]

