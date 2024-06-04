#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

    "${PATCHELF}" --replace-needed libgui.so libsensor.so $BLOB_ROOT/bin/gpsd
    "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so $BLOB_ROOT/vendor/lib/libsec-ril.so
    sed -i "s/libprotobuf-cpp-full/libprotobuf-cpp-fl24/" $BLOB_ROOT/vendor/lib64/libsec-ril.so
    "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so $BLOB_ROOT/vendor/lib/libsec-ril-dsds.so
    sed -i "s/libprotobuf-cpp-full/libprotobuf-cpp-fl24/" $BLOB_ROOT/vendor/lib64/libsec-ril-dsds.so

    "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so $BLOB_ROOT/vendor/lib/hw/nfc_nci.default.so
    "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so $BLOB_ROOT/vendor/lib64/hw/nfc_nci.default.so
    sed -i "s/\/system\/app/\/vendor\/app/g" $BLOB_ROOT/vendor/bin/mcDriverDaemon
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=zerofltexx
export DEVICE_COMMON=exynos7420-common
export VENDOR=samsung

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
