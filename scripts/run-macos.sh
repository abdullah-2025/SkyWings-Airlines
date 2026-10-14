#!/bin/zsh

set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_dir="$repo_dir/SkyWingsAirlines"
port="${SKYWINGS_PORT:-50421}"
url="http://127.0.0.1:$port/Booking.aspx"

for command_name in mono xbuild xsp4; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        print -u2 "Missing required command: $command_name"
        print -u2 "See SETUP.md for the macOS installation steps."
        exit 1
    fi
done

print "Building SkyWings Airlines..."
xbuild "$repo_dir/SkyWingsAirlines.sln" /p:Configuration=Debug

print
print "SkyWings Airlines is starting at:"
print "  $url"
print
print "Press Control-C to stop the server."

if [[ "${1:-}" == "--open" ]]; then
    (
        sleep 1
        open "$url"
    ) &
fi

cd "$app_dir"
exec xsp4 --address 127.0.0.1 --port "$port" --nonstop
