# Begin.com GitHub Actions

## Deploy

This action deploys an app to Begin.com

[Official documentation.](https://begin.com/deploy/docs/getting-started/github-actions)

### Example: Tag-based deployment

```yaml
name: Begin deploy

on: [ push, pull_request ]

defaults:
  run:
    shell: bash

jobs:
  # Deploy the build
  deploy:
    runs-on: ubuntu-latest
    if: github.event_name == 'push'

    steps:
      - name: Check out repo
        uses: actions/checkout@v4

      - name: Deploy to staging
        if: github.ref == 'refs/heads/main'
        uses: beginner-corp/actions/deploy@main
        with:
          begin_token: ${{ secrets.BEGIN_TOKEN }}
          begin_env_name: staging

      - name: Deploy to production
        if: startsWith(github.ref, 'refs/tags/v')
        uses: beginner-corp/actions/deploy@main
        with:
          begin_token: ${{ secrets.BEGIN_TOKEN }}
          begin_env_name: production
```

### Example: Branch-based deployment

```yaml
name: Begin deploy

on: [ push, pull_request ]

defaults:
  run:
    shell: bash

jobs:
  # Deploy the build
  deploy:
    runs-on: ubuntu-latest
    if: github.event_name == 'push'

    steps:
      - name: Check out repo
        uses: actions/checkout@v4

      - name: Deploy to staging
        if: github.ref == 'refs/heads/main'
        uses: beginner-corp/actions/deploy@main
        with:
          begin_token: ${{ secrets.BEGIN_TOKEN }}
          begin_env_name: staging

      - name: Deploy to production
        if: github.ref == 'refs/heads/production'
        uses: beginner-corp/actions/deploy@main
        with:
          begin_token: ${{ secrets.BEGIN_TOKEN }}
          begin_env_name: production
```

# Maintainer's Notes

## Releasing

GitHub Actions releases can be a pain. The key is to remove the previous `vN` tag. So if you want to update `v1`, delete the current `v1` tag and then create a new one. You can use the GitHub.com interface to do this.
