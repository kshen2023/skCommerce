# -*- coding: utf-8 -*- #
# Copyright 2024 Google LLC. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Cloud Speech-to-text recognizers run short audio command."""
from __future__ import absolute_import
from __future__ import division
from __future__ import unicode_literals

from googlecloudsdk.api_lib.ml.speech import client
from googlecloudsdk.calliope import base
from googlecloudsdk.command_lib.ml.speech import flag_validations
from googlecloudsdk.command_lib.ml.speech import flags_v2


@base.UniverseCompatible
@base.ReleaseTracks(base.ReleaseTrack.ALPHA)
class RunShort(base.Command):
  """Get transcripts of short (less than 60 seconds) audio from an audio file."""

  def ValidateRunShortFlags(self, args):
    """Validates run short flags."""
    flag_validations.ValidateDecodingConfig(args)
    flag_validations.ValidateAudioSource(args)

  @staticmethod
  def Args(parser):
    """Register flags for this command."""
    flags_v2.AddRecognizeRequestFlagsToParser(parser)

  def Run(self, args):
    resource = args.CONCEPTS.recognizer.Parse()
    speech_client = client.SpeechV2Client()

    self.ValidateRunShortFlags(args)

    recognition_config, features, _ = (
        speech_client.SeparateArgsForRecognizeCommand(
            args, default_to_auto_decoding_config=True
        )
    )

    recognition_config.model = args.model
    recognition_config.languageCodes = args.language_codes

    return speech_client.RunShort(
        resource,
        args.audio,
        args.hints,
        recognition_config,
        features,
    )
