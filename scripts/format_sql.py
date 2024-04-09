import sys
import sqlparse
import re

content = sys.stdin.read()
content = re.sub(r'\$([0-9]+)', r'__id__\g<1>__', content)


content = sqlparse.format(content,
                          reindent=True,
                          indent_width=4,
                          keyword_case='upper',
                          identifier_case='lower',
                          indent_after_first=True,
                          wrap_after=80,
                          use_space_around_operators=True,
)


content = re.sub(r'__id__([0-9]+)__', r'$\g<1>', content)
print(content.strip())
