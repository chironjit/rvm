# Changelog

## [0.1.1] - 2025-09-24

### Added
- Automated build and release utilising Github actions

### Fixed
- Build for both x64 and aarch64
- Clippy lints
- Code formatting

### Changed
- New releases are automatic when the version number is Cargo.toml is changed

## [0.1.0] - 2025-09-24

### Added
- Created a standardised Runtime trait with expected functions
- Standardised functions as utils where possible
- Added watcher to enable auto restart on watches
- Removed plans for package manager support
- Added CLI parsing and UI
- Added support for node, go and tailwindcss cli

### Changed
- Completed rewrite to Rust from Shell
