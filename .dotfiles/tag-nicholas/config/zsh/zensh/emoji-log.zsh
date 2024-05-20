## Better Git Logs.
### Using EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log).

# Git Commit, Add all and Push — in one step.
gcap() {
    git add . && git commit -m "$*" && git push
}

# NEW.
gnew() {
    gcap "📦 NEW: $*"
}

# IMPROVE.
gimp() {
    gcap "👌 IMPROVE: $*"
}

# FIX.
gfix() {
    gcap "🐛 FIX: $*"
}

# RELEASE.
grlz() {
    gcap "🚀 RELEASE: $*"
}

# DOC.
gdoc() {
    gcap "📖 DOC: $*"
}

# TEST.
gtst() {
    gcap "🤖 TEST: $*"
}

# BREAKING CHANGE.
gbrk() {
    gcap "‼️ BREAKING: $*"
}
gtype() {
    NORMAL='\033[0;39m'
    GREEN='\033[0;32m'
    echo "$GREEN gnew$NORMAL — 📦 NEW
$GREEN gimp$NORMAL — 👌 IMPROVE
$GREEN gfix$NORMAL — 🐛 FIX
$GREEN grlz$NORMAL — 🚀 RELEASE
$GREEN gdoc$NORMAL — 📖 DOC
$GREEN gtst$NORMAL — 🧪️ TEST
$GREEN gbrk$NORMAL — ‼️ BREAKING"
}
