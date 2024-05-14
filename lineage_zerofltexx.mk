#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# Product API level
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n.mk)

# Inherit from zerofltexx device
$(call inherit-product, device/samsung/zerofltexx/device.mk)

# Boot Animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

## Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier, this must come after all inclusions
PRODUCT_NAME := lineage_zerofltexx
PRODUCT_DEVICE := zerofltexx
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-G920F
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

BUILD_FINGERPRINT := "samsung/zerofltexx/zeroflte:7.0/NRD90M/G920FXXS6ETK:user/release-keys"

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=zerofltexx \
    PRIVATE_BUILD_DESC="zerofltexx-user 7.0 QP1A.190711.020 G960FXXUHFVK1 release-keys"

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.PDA=G960FXXUHFVK1 \
    ro.build.fingerprint=samsung/starltexx/starlte:10/QP1A.190711.020/G960FXXUHFVK1:user/release-keys
