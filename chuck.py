# clear;python3 chuck.py
# clear;python chuck.py

import Blog

blog = Blog.Blog()

t1 = blog._rd(("bob","distsys",str))
print(t1)

t2 = blog._rd(("alice","gtcn",str))
print(t2)

t3 = blog._rd(("bob","gtcn",str))
print(t3)
