require 'synth_blocks'

SRATE=44100

filter = SynthBlocks::Core::StateVariableFilter.new(SRATE)



out = SRATE.times.map {|i| 0.2 * filter.run((rand()*2.0-1.0), 6000, 4, type: :bandpass) }

SynthBlocks::Core::WaveWriter.write_if_name_given(out)