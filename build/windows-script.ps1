$NAME = "VapourSynth"
$VS_VER = "R69"
$VS_DIR = "vs-dir"
$VS_PKG = "VapourSynth64-Portable-$VS_VER.zip"

$PY_DIR = "py-dir"
$PY_VER = "3.12.5"
$PY_PKG = "python-$PY_VER-embed-amd64.zip"

# Download Python embeddable and VapourSynth portable
$VS_PATH = "https://github.com/vapoursynth/vapoursynth/releases/download/$VS_VER/$VS_PKG"
curl -LO "https://www.python.org/ftp/python/$PY_VER/$PY_PKG"
curl -LO "$VS_PATH"

# Unzip Python embeddable and VapourSynth portable
7z x "$PY_PKG" -o"$PY_DIR"
Expand-Archive "$VS_PKG" "$VS_DIR"

# Move all VapourSynth files inside the Python ones
Move-Item -Force -Path "$VS_DIR\*" -Destination "$PY_DIR"

# Move the VapourSynth directory into a system directory
Move-Item -Path "$PY_DIR" -Destination "C:\Program Files"
Rename-Item -Path "C:\Program Files\$PY_DIR" -NewName "$NAME"
