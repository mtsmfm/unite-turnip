require 'spec_helper'

describe 'unite-turnip' do
  before do
    FileUtils.mkdir_p 'spec/steps'

    write_file('spec/steps/step.rb', step)
  end

  subject {
    vim.edit('test')
    vim.type(':Unite turnip<CR>')
    sleep 1
    vim.type('yG<C-w>jpggdd')
    sleep 1
    vim.write
    File.read('test').gsub(/^ *(.*?) *\n/, "\\1\n")
  }

  context 'when calling step' do
    let(:step) {
      <<-EOS.strip_heredoc
        step 'define step' do
          step 'call step'
        end
      EOS
    }

    it {
      is_expected.to eq <<-EOS.strip_heredoc
        define step                                        -- (./spec/steps/step.rb:1)
      EOS
    }
  end
end
