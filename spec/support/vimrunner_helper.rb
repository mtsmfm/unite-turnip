Vimrunner::RSpec.configure do |c|
  c.start_vim do
    vim =
      if $DEBUG
        Vimrunner.start_gvim
      else
        Vimrunner.start
      end

    vim.tap do |v|
      v.add_plugin( "#{__dir__}/../unite.vim", 'plugin/unite.vim')
      v.add_plugin("#{__dir__}/../../")
    end
  end
end
