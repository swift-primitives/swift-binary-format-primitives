# Binary Format Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Human-readable integer formatting in the binary domain — `Binary.Format.Bytes` for byte-count notation ("4.1 KB", "4 KiB") and `Binary.Format.Radix` for hexadecimal, octal, and binary spellings with optional prefix, zero-padding, and sign strategy.

---

## Quick Start

`Binary.Format` is a vocabulary of format styles that turn a raw integer into the string a human reads: a byte count becomes `1.5 KB` or `1 KiB`, and an integer becomes its hexadecimal, octal, or binary spelling. Every style is applied through one uniform `value.formatted(_:)` entry point and configured by chaining — no Foundation, no `String(_:radix:)` boilerplate, no formatter objects to allocate.

```swift
import Binary_Format_Primitives

// Byte counts: decimal (SI) or binary (IEC) units, chosen explicitly.
print(1500.formatted(Binary.Format.bytes))               // "1.5 KB"
print(1024.formatted(Binary.Format.bytes(.binary)))      // "1 KiB"
print(1024.formatted(Binary.Format.bytes.precision(2)))  // "1.02 KB"

// Radix spellings: hex / octal / bits, with optional prefix and padding.
print(255.formatted(Binary.Format.hex))                       // "ff"
print(255.formatted(Binary.Format.hex.prefix))                // "0xff"
print(42.formatted(Binary.Format.bits))                       // "101010"
print(5.formatted(Binary.Format.decimal.zeroPadded(width: 3)))  // "005"
```

Both families work with any `BinaryInteger` — `Int`, `UInt8`, `Int64`, and the rest. The companion `Binary Format Primitives Standard Library Integration` product extends the same `.formatted(_:)` surface to any `RawRepresentable` whose `RawValue` is an integer, so a tagged offset or a raw permission mask formats exactly like a plain `Int`:

```swift
import Binary_Format_Primitives_Standard_Library_Integration

enum Permission: UInt16 { case readWriteExecute = 0o755 }

print(Permission.readWriteExecute.formatted(Binary.Format.octal))  // "755"
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-binary-format-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Binary Format Primitives", package: "swift-binary-format-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Three library products. Composes over [swift-format-primitives](https://github.com/swift-primitives/swift-format-primitives) and [swift-binary-primitives](https://github.com/swift-primitives/swift-binary-primitives).

| Product | Target | Purpose |
|---------|--------|---------|
| `Binary Format Primitives` | `Sources/Binary Format Primitives/` | The `Binary.Format` namespace: `Binary.Format.Bytes` (byte-count notation with decimal/binary units, spaced/compact notation, and precision control) and `Binary.Format.Radix` (decimal/hex/octal/binary spellings with prefix, sign, and zero-padding), applied through `BinaryInteger.formatted(_:)`. |
| `Binary Format Primitives Standard Library Integration` | `Sources/Binary Format Primitives Standard Library Integration/` | Extends `.formatted(_:)` to any `RawRepresentable` whose `RawValue` is a `BinaryInteger`. |
| `Binary Format Primitives Test Support` | `Tests/Support/` | Re-exports the main target (with binary-primitives test support) for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
