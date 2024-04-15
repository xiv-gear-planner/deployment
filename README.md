# [Xivgear.app](https://xivgear.app/) Deployment Files

This repo contains the helm chart for deploying static files + the backend.

xivgear-chart is the top-level chart, while the rest are listed as dependencies.

You generally do not need to run this, as it is fine to run a development build of the static files
(which includes the JS/TS that runs the entire browser app) against the live API. The API is mostly
just a k/v store, where the keys are the set/sheet UUIDs and the values are the JSON.

The production deployment uses Keel to keep image versions up to date. Thus, builds do not need to
'deploy' anything, they just need to push the new image to GHCR and it will be deployed automatically.

The tagging strategy is branch-based. The backend uses 'master' as its production branch, thus,
any change to master will be deployed automatically. The frontend uses 'prod' as its production
branch.

To deploy any additional microservices, set up a CI/CD build to publish them as a container image,
and then add another sub-chart here.