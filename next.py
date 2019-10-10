# clear;python3 next.py
# clear;python next.py

import Blog

blog = Blog.Blog()

order = 0

order += 1
print(blog._out(("alice","gtcn","This graph theory stuff is not easy", order)))
order += 1
print(blog._out(("bob","gtcn","This graph theory stuff is not easy22", order)))
order += 1
print(blog._out(("alice","gtcn","This graph theory stuff is not easy33", order)))

order = 0
topic = "gtcn"

order += 1
t2 = blog._rd((str,"gtcn",str, order))
print(t2)

order += 1
t2 = blog._rd((str,"gtcn",str, order))
print(t2)

order += 1
t2 = blog._rd((str,"gtcn",str, order))
print(t2)