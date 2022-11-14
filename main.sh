#!/bin/sh -e
cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit

if [ "${INPUT_USE_BUNDLER}" = "false" ]; then
  BUNDLE_EXEC=""
else
  BUNDLE_EXEC="bundle exec "
fi

echo '::group:: Preflight ...'

final_rc=$?
echo '::endgroup::'
exit $final_rc
