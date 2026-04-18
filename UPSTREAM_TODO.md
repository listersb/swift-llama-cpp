# Upstream TODO

Patches carried in this fork that should eventually be proposed to their
upstreams. Keep this list short and concrete; delete entries once merged.

## ggml-org/llama.cpp

- **Missing `typedef struct mtmd_decoder_pos mtmd_decoder_pos;` in
  `tools/mtmd/mtmd.h`.** All sibling opaque types (`mtmd_context`,
  `mtmd_bitmap`, `mtmd_image_tokens`, `mtmd_input_chunk`,
  `mtmd_input_chunks`, `mtmd_input_text`) have forward-typedefs right below
  their `#ifdef __cplusplus` block; `mtmd_decoder_pos` was missed. That
  breaks Xcode's strict-C module precompilation of any xcframework that
  ships these headers, because `mtmd-helper.h` uses the bare name
  `mtmd_decoder_pos *` in a function signature.

  The workflow patches this inline — see `.github/workflows/build-xcframework.yml`
  step "4b". A one-line PR to llama.cpp would let us delete that patch.

- **`build-xcframework.sh` can't coexist with `LLAMA_BUILD_TOOLS=ON` on
  iOS / visionOS / tvOS.** Several CLI targets under `tools/` are
  `MACOSX_BUNDLE` executables whose `install(TARGETS ...)` lacks a
  `BUNDLE DESTINATION`, which is fatal at configure time on those
  platforms. The workflow works around it by replacing
  `tools/CMakeLists.txt` with `add_subdirectory(mtmd)` and truncating
  `tools/mtmd/CMakeLists.txt` after the library install. An upstream fix
  could either gate those CLI targets on `APPLE AND NOT IOS/TVOS/XROS` or
  add `BUNDLE DESTINATION bin` to their installs.

  Less urgent than the typedef — the `LLAMA_BUILD_TOOLS=ON` config is a
  niche one (most xcframework consumers only want libllama/libggml), so
  upstream may reasonably decline. Mention only if the first PR lands well.
