---
title: "Installing a local Assist pipeline"
---

In Home Assistant, the Assist pipelines are made up of various components that together form a voice assistant.

For each component you can choose from different options. There is a speech-to-text and text-to-speech option that runs entirely local.

The speech-to-text option is [Whisper](https://github.com/openai/whisper). It's an open source AI model that supports [various languages](https://github.com/openai/whisper#available-models-and-languages). We use a forked version called [faster-whisper](https://github.com/guillaumekln/faster-whisper). On a Raspberry Pi 4, it takes around 8 seconds to process incoming voice commands. On an Intel NUC it is done in under a second.

For text-to-speech we have developed [Piper](https://github.com/rhasspy/piper). Piper is a fast, local neural text-to-speech system that sounds great and is optimized for the Raspberry Pi 4. It supports [many languages](https://rhasspy.github.io/piper-samples/). On a Raspberry Pi, using medium quality models, it can generate 1.6s of voice in a second