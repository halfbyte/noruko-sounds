require 'fileutils'

sound_rb_files = FileList.new('sounds/*.rb')

samples = sound_rb_files.map {|f| b = File.basename(f, '.rb'); "samples/#{b}.wav"}

sound_rb_files.each do |file|
  base_name = File.basename(file, '.rb')
  file "samples/#{base_name}.wav" => ["sounds/#{base_name}.rb"] do |t|
    sh "bundle exec ruby #{t.prerequisites.first} #{t.name}"
  end
end

task :ensure_samples_dir do
  FileUtils.mkdir_p "samples"
end

desc "update samples"
task :update_samples => [:ensure_samples_dir] + samples

task :default => [:update_samples]