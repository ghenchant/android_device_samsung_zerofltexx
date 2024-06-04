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
            "${PATCHELF}" --replace-needed libgui.so libsensor.so "${BLOB_ROOT}/bin/gpsd "${2}"
            ;;
        vendor/lib/libsec-ril.so)
            "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so "${BLOB_ROOT}/vendor/lib/libsec-ril.so "${2}"
            sed -i "s/libprotobuf-cpp-full/libprotobuf-cpp-fl24/" "${BLOB_ROOT}/vendor/lib64/libsec-ril.so"
            ;;
        vendor/lib/libsec-ril-dsds.so)
            "${PATCHELF}" --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-fl24.so "${BLOB_ROOT}/vendor/lib/libsec-ril-dsds.so "${2}"
            sed -i "s/libprotobuf-cpp-full/libprotobuf-cpp-fl24/" "${BLOB_ROOT}/vendor/lib64/libsec-ril-dsds.so"
            ;;
        vendor/lib/hw/nfc_nci.default.so)
            "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so "${BLOB_ROOT}/vendor/lib/hw/nfc_nci.default.so "${2}"
            "${PATCHELF}" --remove-needed vendor.samsung.hardware.nfc@1.0.so "${BLOB_ROOT}/vendor/lib64/hw/nfc_nci.default.so "${2}"
            ;;
        vendor/bin/mcDriverDaemon)
            sed -i "s/\/system\/app/\/vendor\/app/g" "${BLOB_ROOT}/vendor/bin/mcDriverDaemon"
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
