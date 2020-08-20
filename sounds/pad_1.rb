require 'synth_blocks'

#
# Simple Demo of the PolySynth
#

SRATE = 44100

polysynth = SynthBlocks::Synth::Polysynth.new(SRATE, {
  amp_env_attack: 0.001,
  amp_env_release: 0.1,
  flt_env_attack: 0.001,
  flt_env_decay: 0.05,
  flt_env_sustain: 0.8,
  flt_frequency: 300,
  flt_envmod: 4000,
  flt_Q: 1,
  osc_waveform: :square
})

BASE_NOTE = 48

CHORDS = [0, 3, 7, -12]

CHORDS.each do |ch|
  polysynth.start(0, BASE_NOTE + ch)  
  polysynth.stop(0.25, BASE_NOTE + ch)  
end

out = SRATE.times.map{ |i| 0.6 * polysynth.run(i) }

SynthBlocks::Core::WaveWriter.write_if_name_given(out)