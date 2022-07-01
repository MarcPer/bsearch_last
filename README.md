# Binary search last

This is a binary search implementation that returns the _last_ element found.

[CRuby API reference](https://silverhammermba.github.io/emberb/c/)

The behavior is very similar to that of the existing
[`Array#bsearch` and `Array#bsearch_index`][binary searching] methods,
except _Find-minimum mode_ is replaced by a _Find-maximum mode_.

In _Find-maximum mode_, the **last** element/index for which the block
evaluates to `true` is returned, as opposed to the first.

Analogously to the conditions in the block for the normal `bsearch` and
`bsearch_index` methods, in `bsearch_last` and `bsearch_last_index` the block
needs to satisfy the following in the _Find-maximum mode_:

The block is such that all `true`-evaluating elements precede all
`false`-evaluating elements. This is the exact opposite of the condition for
`bsearch`.

Examples:

```ruby
a = [0, 4, 7, 10, 12]
a.bsearch_last {|x| x<=4 } # => 4
a.bsearch_last {|x| x<=6 } # => 4
a.bsearch_last {|x| x<=-1 } # => nil
a.bsearch_last {|x| x>=100 } # => nil
```

The _Find-any mode_ behaves the same as in the `Array#bsearch` methods.

## Build

Run `rake build`. This takes the steps:
- create _Makefile_ with `ruby extconf.rb`
- create _.so_ file with `make`
- the _.so_ file can be imported into Ruby with `require bsearch_last.so` (normally the extension is not needed, Ruby checks these files automatically, but here there's another file with the same name and the `rb` extension, which takes precedence).

## Run

```ruby
require 'bsearch_last'

[1, 1, 2, 2, 3, 4].bsearch_last_index {|x| x <= 2 } # => 3
```

## Specs

Run `rake`. This tests the Ruby and C versions of the functions.

## Benchmarks

`rake bench`

The C version is about 30% faster than the Ruby one for the somewhat long array
used in the benchmark.

[binary searching]: https://ruby-doc.org/core-3.1.1/doc/bsearch_rdoc.html
