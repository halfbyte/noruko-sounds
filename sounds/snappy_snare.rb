require 'synth_blocks'

#
# Let's generate a snare drum sound
#


def frequency(note)
  (2.0 ** ((note.to_f - 69.0) / 12.0)) * 440.0
end

SRATE = 44100

BASE_FREQ = frequency(48)
UPPER_FREQ = frequency(72)
MOD = UPPER_FREQ - BASE_FREQ

drum = SynthBlocks::Drum::SnareDrum.new(SRATE, {
  flt_attack: 0.00001,
  flt_decay: 0.03,
  flt_envmod: 7000,
  flt_frequency: 2000,
  flt_Q: 2,
  base_frequency: BASE_FREQ,
  pitch_mod: MOD,
  pitch_decay: 0.02,
  amp_decay: 0.03,
})

drum.start(0.0)

out = SRATE.times.map {|i| 0.5 * drum.run(i) }

SynthBlocks::Core::WaveWriter.write_if_name_given(out)