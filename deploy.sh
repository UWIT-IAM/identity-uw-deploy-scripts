TARGET=$1
GIT_REPO=git@github.com:UWIT-IAM/identity-uw.git
BASEDIR=$HOME
DEPLOYDIR=identity-uw-${TARGET}
LOCKFILE=${BASEDIR}/deploys/${DEPLOYDIR}.lock

function error {
    echo $1 >&2
    rm -f ${LOCKFILE}
    exit 1
}

[[ -d ${BASEDIR}/deploys ]] || mkdir ${BASEDIR}/deploys

[[ $TARGET =~ ^(dev|eval|prod)$ ]] || error "usage: deploy.sh [ dev | eval | prod]"
cd ${BASEDIR}/deploys || error "can't cd to ${BASEDIR}/deploys"
[[ ! -f ${LOCKFILE} ]] || error "${LOCKFILE} exists"
touch ${LOCKFILE}

source ${BASEDIR}/venv-ansible/bin/activate
cd ${BASEDIR}/deploys || error "no deploys directory"
rm -rf $DEPLOYDIR
git clone ${GIT_REPO} $DEPLOYDIR
cd $DEPLOYDIR/ansible || error "${DEPLOYDIR}/ansible doesn't exist"
ansible-playbook -i hosts identity_uw.yml --extra-vars "target=rivera_${TARGET}"
RC=$?
rm -f ${LOCKFILE}
exit ${RC}
