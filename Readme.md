# identity-uw-deploy-scripts

A collection of scripts for kicking off an ansible deploy from CI.

Each deploy-{target}.sh script can get paired with an ssh key and added to
iamnsspr's authorized_keys such as the following...

```
command="deploy-scripts/deploy-dev.sh" ssh-rsa AAAAB3... iamnsspr-dev-deploy@build.s.uw.edu
command="deploy-scripts/deploy-eval.sh" ssh-rsa AAAAB3... iamnsspr-eval-deploy@build.s.uw.edu
```

Having given the ssh key/passphrase to CI such as Bamboo, it can connect
to iamnsspr@rivera-dev1 and run that command only.