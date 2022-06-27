**Do not use this library (at least not yet). I'm just playing with it**

# Binary search last

This is a binary search implementation that returns the _last_ element found.

[CRuby API reference](https://silverhammermba.github.io/emberb/c/)

## Build

Run `rake build`. This takes the steps:
- create _Makefile_ with `ruby extconf.rb`
- create _.so_ file with `make`
- the _.so_ file can be imported into Ruby with `require bsearch_last.so` (normally the extension is not needed, Ruby checks these files automatically, but here there's another file with the same name and the `rb` extension, which takes precedence).

## Run

```ruby
require 'bsearch_last'

[1, 1, 2, 2, 3, 4].bsearch_last_index(2) # => 3
```

## Specs

Run `rake`

## Benchmarks

`rake bench`

The C version is about 0.7 faster than the Ruby one for the given array. If the `Check_Type(val, T_FIXNUM);` check is added when accessing each Array element, the speedup is about 0.64.


