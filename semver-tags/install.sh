#!/bin/sh
# shellcheck disable=SC2034
# "'pkg_cmd_name' appears unused. Verify it or export it."

set -e
set -u

__init_semver_tags() {

    #######################
    # Install semver-tags #
    #######################

    WEBI_SINGLE=true

    # Every package should define these 6 variables
    pkg_cmd_name="semver-tags"

    # pkg_get_current_version is intentionally NOT defined.
    # 'semver-tags' (as of v0.6.1) has no '--version' flag and no 'version'
    # subcommand, so there is no output to parse. Without this function,
    # webi cannot skip a reinstall of the same version, but every other
    # part of the install still works correctly.
    # TODO: ask upstream to add a '--version' flag.

    # pkg_install must be defined by every package
    pkg_install() {
        # ~/.local/opt/semver-tags-v0.6.1/bin
        mkdir -p "$(dirname "$pkg_src_cmd")"

        # the archive contains a single bare binary at its root:
        #     semver-tags-0.6.1-linux-amd64.tar.gz -> ./semver-tags
        if test -f ./semver-tags; then
            # mv ./semver-tags ~/.local/opt/semver-tags-v0.6.1/bin/semver-tags
            mv ./semver-tags "$pkg_src_cmd"
        elif test -e ./semver-tags-*/semver-tags; then
            mv ./semver-tags-*/semver-tags "$pkg_src_cmd"
        else
            echo >&2 "failed to find 'semver-tags' executable"
            return 1
        fi
    }

}

__init_semver_tags
