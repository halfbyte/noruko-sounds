require 'synth_blocks'

#
# Simple Demo of the Monosyth
#

SFREQ = 44100

synth = SynthBlocks::Drum::TunedDrum.new(SFREQ, {
  amp_decay: 0.5
})
ws = SynthBlocks::Fx::Waveshaper.new(10)
synth.start(0, 48)

out = (2 * SFREQ).times.map { |i|
  ws.run(synth.run(i))
}

SynthBlocks::Core::WaveWriter.write_if_name_given(out)