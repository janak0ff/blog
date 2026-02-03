# Blog Project

This is a Jekyll-based blog.

## Prerequisites

You need **Ruby** and **Bundler** installed. 
Since you are on Linux (Debian/Ubuntu likely), run:

```bash
# 1. Update package lists
sudo apt-get update

# 2. Install Ruby and development tools (required for Jekyll extensions)
sudo apt-get install ruby-full build-essential zlib1g-dev

# 3. Configure gem installation path (avoid sudo for gems)
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 4. Install Jekyll and Bundler
gem install jekyll bundler
```

## How to Run

1. **Install Dependencies** (run this once):
   ```bash
   bundle install
   ```

2. **Start the local server**:
   ```bash
   bundle exec jekyll serve
   ```

3. Open your browser to: `http://127.0.0.1:4000/blog/`

## Writing Posts

Create new markdown files in `_posts/` with the format `YYYY-MM-DD-title.md`.
