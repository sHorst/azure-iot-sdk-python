#!/bin/bash
# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.

build_root=$(cd "$(dirname "$0")/.." && pwd)
cd $build_root

# -- Python C wrapper --
./build_all/linux/build.sh --use-websockets $*
[ $? -eq 0 ] || exit $?

cd device/tests
python2 ./iothub_client_e2e.py
[ $? -eq 0 ] || exit $?

cd service/tests
python2 ./iothub_service_client_e2e.py
[ $? -eq 0 ] || exit $?

