#!/bin/bash
# Script to check for HTML code in the repository
# This verifies that no HTML files or HTML code exists in the codebase

echo "Checking for HTML files and code in the repository..."
echo "=================================================="

# Check for HTML files
echo "1. Checking for HTML files (.html, .htm)..."
html_files=$(find . -type f \( -name "*.html" -o -name "*.htm" \) ! -path "./.git/*" 2>/dev/null)
if [ -z "$html_files" ]; then
    echo "   ✓ No HTML files found"
else
    echo "   ✗ HTML files found:"
    echo "$html_files"
fi

# Check for HTML tags in other files (excluding documentation about HTML)
echo "2. Checking for HTML tags in files..."
html_tags=$(grep -r -i -l "<!DOCTYPE\|<html\|<head\|<body" . --exclude-dir=.git --exclude="*.sh" --exclude="HTML_VERIFICATION.md" 2>/dev/null)
if [ -z "$html_tags" ]; then
    echo "   ✓ No HTML tags found in files"
else
    echo "   ✗ HTML tags found in:"
    echo "$html_tags"
fi

echo "=================================================="
if [ -z "$html_files" ] && [ -z "$html_tags" ]; then
    echo "✓ VERIFICATION PASSED: No HTML code found in repository"
    exit 0
else
    echo "✗ VERIFICATION FAILED: HTML code detected in repository"
    exit 1
fi
