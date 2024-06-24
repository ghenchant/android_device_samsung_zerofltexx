#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/bin/gpsd)
            "${PATCHELF}" --replace-needed libgui.so libsensor.so "${2}"
            ;;
        vendor/lib/libsec-ril.so)
            "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so "${2}"
            sed -i 's/libprotobuf-cpp-full/libprotobuf-cpp-fl24' "${2}"
            ;;
        vendor/lib/libsec-ril-dsds.so)
            "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so "${2}"
            sed -i 's/libprotobuf-cpp-full/libprotobuf-cpp-fl24/' "${2}"
            ;;
        vendor/lib/hw/nfc_nci.default.so)
            "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so "${2}"
            "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so "${2}"
            ;;
        vendor/bin/mcDriverDaemon)
            sed -i 's/\/system\/app/\/vendor\/app/g' "${2}"
            ;;
    esac
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
