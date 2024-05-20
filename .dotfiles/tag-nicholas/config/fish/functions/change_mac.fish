# Randomize MAC address on MacOS
function change_mac
  # Check if npx is installed
  if ! command -v npx &> /dev/null
  then
    echo "'npx' could not be found"
    return
  end

  sudo npx spoof randomize en0
end
