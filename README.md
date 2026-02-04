# Blog Project

This is a Jekyll-based blog, containerized with Docker for easy local development and deployed via GitHub Actions.

## Local Development

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed on your machine.
- That's it! No Ruby or Jekyll installation required on your host.

### Running the App
To start the blog locally:

```bash
./run.sh
```

This will:
1. Build the Docker image.
2. Start the container in the background.
3. Serve the blog at `http://localhost:8081`.

### Stopping the App
To stop the running container:

```bash
./stop.sh
```

## Deployment

The project is configured to deploy automatically to GitHub Pages using **GitHub Actions**.

### Workflow
1. **Push Changes**: When you push code to the `master` (or `main`) branch.
2. **GitHub Action**: The workflow defined in `.github/workflows/pages-deploy.yml` triggers.
3. **Build & Deploy**: It builds the Jekyll site and deploys the artifacts to the `gh-pages` branch (or configured Pages environment).
4. **Live Site**: Your changes go live on your GitHub Pages URL context.

### Configuration
- **_config.yml**: Ensure `url` and `baseurl` are correctly set for your production environment.
- **GitHub Settings**: Go to Repository Settings -> Pages, and ensure the source is set to "GitHub Actions" or the specific branch pushed by the action.

## Writing Posts

Create new markdown files in `_posts/` with the format `YYYY-MM-DD-title.md`.

