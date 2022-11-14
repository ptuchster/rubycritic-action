#!/bin/sh -e
cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

if [ "${INPUT_USE_BUNDLER}" = "false" ]; then
  BUNDLE_EXEC=""
else
  BUNDLE_EXEC="bundle exec "
fi

echo '::group:: Preflight ...'

sudo gem install bundler rubycritic

${BUNDLE_EXEC}rubycritic -v || exit 1

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Seems like RubyCritic are not installed at your project :("
fi
echo '::endgroup::'

echo '::group:: RubyCritic run'

${BUNDLE_EXEC}rubycritic --mode-ci --format json --minimum-score ${INPUT_MIN_SCORE_THRESHOLD} -b master --maximum-decrease 0

final_rc=$?
echo '::endgroup::'
exit $final_rc
