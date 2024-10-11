from pymongo.operations import IndexModel

import code
import readline

readfunc = readline.parse_and_bind("tab: complete")
banner = ""

# PYTHON-4834
hello = IndexModel("hello")
print(hello)

code.interact(local=globals(), readfunc=readfunc, banner=banner)
