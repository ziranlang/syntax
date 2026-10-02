# Syntax

Syntax is a small [Ziran](https://github.com/ziranlang/ziran) package that
tokenizes Ziran, C, and Make source. It reports each token's byte range and
kind (keyword, string, number, path, comment, whitespace, or plain text) and
can color the tokens for a light or dark background. It allocates nothing:
callers pass the text and own the output spans.

## Use it

```sh
ziran add https://github.com/ziranlang/syntax.git
```

```zi
#import "syntax/Syntax"

using SyntaxMode;

spans: [256]SyntaxColorSpan
result: SyntaxSpansResult = SyntaxColorSpans(source, cast(SyntaxMode)SyntaxZiran,
    background, foreground, spans[:])
// spans[0:result.count] cover the text; result.complete is false when the
// output was too short.
```

`SyntaxTokenAt` scans one token at a time for editors that keep their own
line state. A `SyntaxColorSpan` has the same `start`, `end`, and `color`
fields as a Kryon `TextAreaColorSpan`, so a Kryon app copies them into its
TextArea props.

## Develop

`make check` checks the package and runs its tests as C and as a portable
bundle. It uses the `ziran` launcher and the compiler pinned in `ziran.lock`.
To test against the local compiler at `ziranlang/ziran`, put this in an
ignored `ziran.local.toml`:

```toml
[overrides]
ziran = "../../ziran"
```
