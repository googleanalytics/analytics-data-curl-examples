#!/bin/bash

# Copyright 2021 Google Inc. All Rights Reserved.
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

# Google Analytics Data API sample application demonstrating the batch creation
# of multiple reports.
#
# See https://developers.google.com/analytics/devguides/reporting/data/v1/rest/v1beta/properties/batchRunReports
# for more information.

# [START analyticsdata_run_batch_report]
# TODO(developer): Replace this variable with your Google Analytics 4
#  property ID before running the sample.
export GA4_PROPERTY_ID=[YOUR-GA4-PROPERTY-ID]

# TODO(developer): Replace this variable with a path to your OAuth2 credentials
#  JSON file. See https://developers.google.com/analytics/devguides/reporting/data/v1/quickstart-cli
#  for instructions on generating and downloading the OAuth2 credentials file.
export CREDENTIALS_JSON_PATH="[PATH/TO/credentials.json]"

# Login using your OAuth2 credentials.
gcloud auth application-default login \
    --scopes=https://www.googleapis.com/auth/analytics.readonly \
    --client-id-file=$CREDENTIALS_JSON_PATH

# This variable contains the JSON request text that will be passed to the API
# method.
# Runs a batch report on a Google Analytics 4 property.
read -r -d '' REQUEST_JSON_DATA << EOM
{
  "requests": [
    {
      "dimensions": [
        {
          "name": "country"
        },
        {
          "name": "region"
        },
        {
          "name": "city"
        }
      ],
      "metrics": [
        {
          "name": "activeUsers"
        }
      ],
      "dateRanges": [
        {
          "startDate": "2021-01-03",
          "endDate": "2021-01-09"
        }
      ]
    },
    {
      "dimensions": [
        {
          "name": "browser"
        }
      ],
      "metrics": [
        {
          "name": "activeUsers"
        }
      ],
      "dateRanges": [
        {
          "startDate": "2021-01-01",
          "endDate": "2021-01-31"
        }
      ]
    }
  ]
}
EOM

curl -X POST \
  -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  https://analyticsdata.googleapis.com/v1beta/properties/$GA4_PROPERTY_ID:runBatchReport \
  -d  "$REQUEST_JSON_DATA"
# [END analyticsdata_run_batch_report]
