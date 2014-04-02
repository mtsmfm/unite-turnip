unite_dir = "#{__dir__}/unite.vim"
unless Dir.exists? unite_dir
  `git clone --depth 1 https://github.com/Shougo/unite.vim #{unite_dir}`
end

Vimrunner::RSpec.configure do |c|
  c.start_vim do
    vim =
      if $DEBUG
        Vimrunner.start_gvim
      else
        Vimrunner.start
      end

    vim.tap do |v|
      v.add_plugin(unite_dir, 'plugin/unite.vim')
      v.add_plugin("#{__dir__}/../../")
    end
  end
end
