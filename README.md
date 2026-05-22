# Binary Format Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Human-readable integer formatting in the binary domain — `Binary.Format.Bytes` (byte-count notation: "4.1 KB", "4 KiB") and `Binary.Format.Radix` (hex/octal/bits notation with optional prefix + zero-padding + sign strategy).

Sibling extraction of swift-binary-primitives. Composes over [swift-format-primitives](https://github.com/swift-primitives/swift-format-primitives) and exposes binary-domain formats consumable via `value.formatted(Binary.Format.bytes)` / `value.formatted(Binary.Format.hex)`. Subject-first naming per `[API-NAME-001b]` — Binary is the subject (data domain), Format is the role.

---
