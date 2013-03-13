require File.absolute_path(File.join(File.dirname(__FILE__), '..', 'lib', 'simple_config'))

describe 'Basic Functionality' do
  it 'should work properly via load_file() [File]' do
    example_file = example1_path
    config = SimpleConfig.load_file(example_file)
    verify_example1(config)
  end

  it 'should work properly via load() [String]' do
    example_string = File.read(example1_path)
    config = SimpleConfig.load(example_string)
    verify_example1(config)
  end

  it 'should raise an exception when encountering invalid input [File]' do
    malformed = malformed_example_path
    lambda{SimpleConfig.load_file(malformed)}.should raise_error SimpleConfig::InputError
  end  

  it 'should raise an exception when encountering invalid input [String]' do
    # test all of the lines in the malformed config file
    malformed = File.read(malformed_example_path)
    malformed.split("\n").each do |line|
      next if line =~ /^\s*\#/ || line == ''
      lambda{SimpleConfig.load(line)}.should raise_error SimpleConfig::InputError
    end
  end

  it 'should allow for the use of a custom delimiter character/pattern' do
    SimpleConfig::SETTINGS.delimiter = ':'
    config = SimpleConfig.load('gandalf : grey')
    config.gandalf.should be == 'grey'
    SimpleConfig::SETTINGS.delimiter = '!--^^--!'
    config = SimpleConfig.load('gandalf !--^^--! white')
    config.gandalf.should be == 'white'
  end


  def example1_path
    File.join(File.dirname(__FILE__), 'examples', 'example1.cfg')
  end
  
  def malformed_example_path
    File.join(File.dirname(__FILE__), 'examples', 'malformed.cfg')
  end

  def verify_example1(config)
    config.host.should be == 'test.com'
    config.user.should be == 'user'
    config.log_file_path.should be == '/tmp/logfile.log'
    config.verbose.should be == true
    config.test_mode.should be == 'on'
    config.answer.should be == 42
    config.send('preserve=nils').should be == false
    config.password.should be == 'wdc^=46UkmKe'
    config.send('first name').should be == 'meowth'
    config.variety.should be == 'tea tree' 
  end
end
