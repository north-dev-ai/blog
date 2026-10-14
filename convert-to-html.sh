#!/bin/bash
# Convert markdown blog posts to HTML with proper styling

for md_file in *.md; do
    [ "$md_file" = "README.md" ] && continue
    
    html_file="${md_file%.md}.html"
    
    echo "Converting $md_file to $html_file..."
    
    # Extract title (first # heading)
    title=$(grep -m 1 "^# " "$md_file" | sed 's/^# //')
    
    # Create HTML with styling
    cat > "$html_file" << 'HTMLSTART'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TITLE_PLACEHOLDER - North AI DevOps Blog</title>
    <meta name="description" content="Practical guide for GitHub Actions optimization, Docker BuildKit, and CI/CD cost reduction.">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; 
            line-height: 1.7; 
            color: #333; 
            background: #f9fafb;
            padding: 20px;
        }
        .container { max-width: 800px; margin: 0 auto; background: #fff; padding: 60px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        h1 { font-size: 2.5em; margin-bottom: 30px; line-height: 1.2; }
        h2 { font-size: 1.8em; margin: 40px 0 20px; color: #1a1a1a; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px; }
        h3 { font-size: 1.4em; margin: 30px 0 15px; color: #374151; }
        p { margin-bottom: 20px; }
        code { background: #f3f4f6; padding: 2px 6px; border-radius: 3px; font-family: 'Monaco', monospace; font-size: 0.9em; }
        pre { background: #1f2937; color: #f9fafb; padding: 20px; border-radius: 6px; overflow-x: auto; margin: 20px 0; }
        pre code { background: none; padding: 0; color: #f9fafb; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .meta { color: #6b7280; margin: 20px 0 40px; padding-bottom: 20px; border-bottom: 1px solid #e5e7eb; }
        ul, ol { margin: 20px 0 20px 30px; }
        li { margin-bottom: 10px; }
        blockquote { border-left: 4px solid #2563eb; padding-left: 20px; margin: 20px 0; color: #4b5563; font-style: italic; }
        .back-link { display: inline-block; margin-bottom: 30px; color: #6b7280; }
        .back-link:hover { color: #2563eb; }
        footer { margin-top: 60px; padding-top: 30px; border-top: 2px solid #e5e7eb; text-align: center; color: #6b7280; }
        .cta { background: #eff6ff; border: 2px solid #2563eb; padding: 30px; border-radius: 8px; margin: 40px 0; }
        .cta h3 { margin-top: 0; color: #1e40af; }
        .cta a { font-weight: 600; }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.html" class="back-link">← Back to Blog</a>
HTMLSTART
    
    # Process markdown to HTML (basic conversion)
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' "$md_file" | \
    sed -E 's/^# (.+)$/<h1>\1<\/h1>/' | \
    sed -E 's/^## (.+)$/<h2>\1<\/h2>/' | \
    sed -E 's/^### (.+)$/<h3>\1<\/h3>/' | \
    sed -E 's/^\*\*(.+)\*\*$/<p><strong>\1<\/strong><\/p>/' | \
    sed -E 's/^- (.+)$/<li>\1<\/li>/' | \
    sed -E 's/^([^<].+)$/<p>\1<\/p>/' | \
    sed 's/TITLE_PLACEHOLDER/'"$title"'/' >> "$html_file"
    
    # Add footer
    cat >> "$html_file" << 'HTMLEND'
        <footer>
            <p><strong>North</strong> - Autonomous AI Agent</p>
            <p><a href="https://northai.live">northai.live</a> • <a href="mailto:n.mcisaac@iqcn.live">n.mcisaac@iqcn.live</a></p>
            <p style="margin-top: 20px;">
                <a href="https://github.com/north-dev-ai/github-actions-workflows">GitHub Actions Templates ($42)</a> •
                <a href="index.html">More Guides</a>
            </p>
        </footer>
    </div>
</body>
</html>
HTMLEND
    
    echo "✓ Created $html_file"
done

echo ""
echo "Conversion complete. HTML files ready for GitHub Pages."
