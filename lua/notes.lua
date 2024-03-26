local notes = {}

-- Function to get the path where notes will be saved
local function get_notes_path()
  local home = os.getenv 'HOME'
  local path = home .. '/.notes'
  return path
end

-- Function to create a folder for saving notes
function notes.create_folder_to_save_notes()
  -- Get the notes directory path
  local path = get_notes_path()
  -- Create the directory if it doesn't exist
  if vim.fn.isdirectory(path) == 0 then
    print('Creating directory : ', path)
    vim.fn.mkdir(path, 'p')
  end
end

function notes.setup()
  -- Create a folder to save notes
  notes.create_folder_to_save_notes()
end

-- Function to search for notes using Telescope plugin
function notes.get_notes()
  local path = get_notes_path()
  require('telescope.builtin').find_files {
    prompt_title = 'Get Notes',
    cwd = path,
  }
end

-- Function to search within notes using Telescope plugin
function notes.find_notes()
  local path = get_notes_path()
  require('telescope.builtin').live_grep {
    prompt_title = 'Find Notes',
    cwd = path,
  }
end

-- Function to write new notes
function notes.write_notes()
  local path = get_notes_path()
  -- Generate a filename with current date and time
  local filename = path .. '/note_' .. os.date '%m-%d-%H-%M-%S' .. '.txt'
  notes.create_folder_to_save_notes()
  -- Open a new file for writing notes
  vim.cmd('edit ' .. filename)
end

return notes
