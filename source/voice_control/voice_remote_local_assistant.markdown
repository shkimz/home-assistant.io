---
title: "Installing a local Assist pipeline"
---

In Home Assistant, the Assist pipelines are made up of various components that together form a voice assistant.

For each component you can choose from different options. There is a speech-to-text and text-to-speech option that runs entirely local.

The speech-to-text option is [Whisper](https://github.com/openai/whisper). It's an open source AI model that supports [various languages](https://github.com/openai/whisper#available-models-and-languages). We use a forked version called
For text-to-speech we have developed [Piper](https://github.com/rhasspy/piper). Piper is a fast, local neural text-to-speech system that sounds great and is optimized for the Raspberry Pi 4