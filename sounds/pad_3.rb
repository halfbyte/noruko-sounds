require 'synth_blocks'

#
# Simple Demo of the PolySynth
#

SRATE = 44100

polysynth = SynthBlocks::Synth::Polysynth.new(SRATE, {
  amp_env_attack: 0.002,
  amp_env_release: 0.002,
  flt_env_attack: 0.2,
  flt_env_decay: 0.5,
  flt_env_sustain: 0.8,
  flt_frequency: 6000,
  flt_envmod: 2000,
  flt_Q: 1,
  osc_waveform: :sawtooth
})
chorus = SynthBlocks::Fx::Chorus.new(SRATE, delay_time: 12)

BASE_NOTE = 60


polysynth.start(0, BASE_NOTE)  
polysynth.stop(2, BASE_NOTE)  

out = (SRATE*3).times.map{ |i| 0.6 * chorus.run(polysynth.run(i)) }

SynthBlocks::Core::WaveWriter.write_if_name_given(out)