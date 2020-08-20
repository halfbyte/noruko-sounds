require 'synth_blocks'

#
# Simple Demo of the Monosyth
#

SFREQ = 44100

synth = SynthBlocks::Synth::Monosynth.new(SFREQ, {
  flt_frequency: 400,
  flt_envmod: 2000,
  flt_decay: 0.1,
  flt_Q: 3,
})

synth.start(0, 36)
synth.stop(1, 36)

out = (2 * SFREQ).times.map { |i|
  synth.run(i)
}

SynthBlocks::Core::WaveWriter.write_if_name_given(out)