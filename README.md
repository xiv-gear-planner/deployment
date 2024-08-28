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

## Structure

The structure of a real deployment involves:
- Static files
- Preview API (social media previews)
- Stat calculator API (allows calculating of actual set stats via API)
- Storage API (stores and retrieves shared sets, also handles the legacy social media previews)
- Math corner static files
- Data API (ingests from xivapi and holds data)

By default, k8s ingress rules are used to control routing. If your domain is foo.com, then the typical way you would set this up is:
- foo.com/(.+) is routed to the static files
- foo.com/ is routed to the preview API, which proxies through to the static files but injects the preview info
- api.foo.com/(.*) is routed to the API
- api.foo.com/fulldata/(.*) is routed to the stat calculator API
- foo.com/math/(.+) is routed to the math corner

In addition, there are several subdomains for beta releases, such as atest.xivgear.app, btest.xivgear.app, etc.

Finally, in terms of storage:
- Data API uses OCI object storage (or local storage for testing)
- Storage API uses Oracle NoSQL (this will be changed to object storage at some point)