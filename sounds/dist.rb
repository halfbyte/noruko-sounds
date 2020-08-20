require 'synth_blocks'

def frequency(note)
  (2.0 ** ((note.to_f - 69.0) / 12.0)) * 440.0
end

SRATE = 44100

filter = SynthBlocks::Core::StateVariableFilter.new(SRATE)
ws = SynthBlocks::Fx::Waveshaper.new(20)
osc = SynthBlocks::Core::Oscillator.new(SRATE)

freq = frequency(36)

out = (SRATE * 2).times.map do |i| 
  o = osc.run(freq, waveform: :sawtooth)
  o = filter.run(o, 100.0 + (i.to_f/15.to_f), 8, type: :highpass)
  o = ws.run(o)
  o * 0.5
end

SynthBlocks::Core::WaveWriter.write_if_name_given(out)