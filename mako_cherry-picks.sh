#!/bin/bash
# ---------------------------------------------------------
# cherry-picks
# use pushd to enter directories
#
# add cherry-picks like this:
#
# # mkbootimg: support pagesize 8192
# pushd system/core
# git fetch https://github.com/CyanogenMod/android_system_core ics && git cherry-pick 67ffceadeab46d4a43aadac0f574b14e844e01a5
# check_clean
# ---------------------------------------------------------

function check_clean {
  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
    popd
    exit 1
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    popd
    exit 1
  fi
  popd
}

#
# insert cherry-picks below
#

# mako hdpi build
PATCH=mako-hdpi-build
FOLDER=device/lge/mako
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/aospa-lollipop-mr1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# adjust notification led blink rate to sanity
PATCH=mako-adjust-notification-led-blink-rate-to-sanity
FOLDER=device/lge/mako
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/aospa-lollipop-mr1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean


# msm8960: include battery lights
PATCH=msm8960-include-battery-lights
FOLDER=hardware/qcom/display
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/aospa-lollipop-mr1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# minimize softbutton spacing
PATCH=minimize-softbutton-spacing
FOLDER=frameworks/base
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/aospa-lollipop-mr1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

