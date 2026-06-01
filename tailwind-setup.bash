#!/usr/bin/env bash

set -e

echo "🚀 Setting up full Tailwind project..."

# 1. Init npm
if [ ! -f package.json ]; then
  npm init -y > /dev/null
fi

# 2. Install Tailwind v4
echo "📥 Installing dependencies..."
npm install -D tailwindcss @tailwindcss/cli

# 3. Create folders
echo "📁 Creating structure..."
mkdir -p assets/images
mkdir -p assets/fonts
mkdir -p src/style
mkdir -p src/views
mkdir -p src/components
mkdir -p utils
mkdir -p dist

# 4. CSS entry
echo "🎨 Creating global.css..."
cat > src/style/global.css <<EOF
@import "tailwindcss";
EOF

# 5. JS utils
echo "🧠 Creating utils/main.js..."
cat > utils/main.js <<EOF
// Your global JS utilities go here

console.log("JS loaded");
EOF

# 6. index.html
if [ ! -f index.html ]; then
  echo "🌐 Creating index.html..."
  cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tailwind Project</title>
  <link href="./dist/output.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

  <div class="bg-blue-500 text-white p-6 rounded-xl shadow-lg">
    Tailwind is working 🚀
  </div>

  <script src="./utils/main.js"></script>
</body>
</html>
EOF
fi

# 7. Tailwind config
echo "⚙️ Creating tailwind.config.js..."
cat > tailwind.config.js <<EOF
export default {
  content: [
    './index.html',
    './src/views/**/*.html',
    './src/components/**/*.html'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# 8. Add npm script safely
echo "🧩 Updating package.json..."
node <<EOF
const fs = require('fs');

const pkg = JSON.parse(fs.readFileSync('package.json', 'utf-8'));

pkg.scripts = pkg.scripts || {};
pkg.scripts.dev = "tailwindcss -i ./src/style/global.css -o ./dist/output.css --watch";

fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
EOF

echo ""
echo "✅ Done."
echo "👉 Run: npm run dev"
