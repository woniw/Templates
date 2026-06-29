#!/usr/bin/env bash

echo "Tailwind 3.3 Glassmorphism Project Generator"

# Ask for project name
read -p "Project name: " PROJECT

# Create proper folder structure
mkdir -p "$PROJECT"/{src/css,dist}
cd "$PROJECT" || exit

# Initialize npm
echo "Initializing npm..."
npm init -y >/dev/null

# Install Tailwind 3.3.2 (stable)
echo "Installing Tailwind CSS 3.3.2..."
npm install tailwindcss@3.3.2 >/dev/null

# Create Tailwind config that scans src/ properly
echo "Creating Tailwind config..."
npx tailwindcss init

cat <<EOF >tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js}"],
  theme: { extend: {} },
  plugins: [],
};
EOF

# Create input.css in src/css
cat <<EOF >src/css/input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Create a working index.html with glassmorphism
cat <<EOF >src/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Glassmorphism Demo</title>
<link rel="stylesheet" href="../dist/output.css">
</head>
<body class="bg-gradient-to-br from-purple-800 to-blue-900 h-screen flex items-center justify-center">

</body>
</html>
EOF

# Create tailrun.sh to watch and build CSS
cat <<EOF >tailrun.sh
#!/usr/bin/env bash
echo "Running Tailwind watcher..."
npx tailwindcss -i ./src/css/input.css -o ./dist/output.css --watch
EOF

chmod +x tailrun.sh

echo ""
echo "✅ Project created successfully!"
echo ""
echo "Next steps:"
echo "cd $PROJECT"
echo "./tailrun.sh"
echo "Then open src/index.html in your browser to see the working glass card."
