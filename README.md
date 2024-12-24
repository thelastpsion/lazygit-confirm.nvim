# lazygit-confirm.nvim

A hacked-together plugin to check if there are any unsaved buffers before running [Snacks](https://github.com/folke/snacks.nvim).lazygit.

![](img/confirm.png)

## Why?

As a LazyVim user, I use Snacks.lazygit regularly to launch lazygit in a NeoVim window by using `<leader>gg`.
However, I kept forgetting to save all my work before running lazygit.
I would commit my changes, realise that I hadn't saved everything, and then have to amend my last commit.

## Usage

For Lazy.nvim:
```lua
return {
  {
    "thelastpsion/lazygit-confirm.nvim",
    opts = {
      -- options
    }
  },
}
```

In `keymaps.lua` (if using LazyVim):
```lua
keymap.set("n", "<leader>gg", function()
  require("lazygit-confirm").confirm()
end, { noremap = true })
```

## Options

```lua
{
  show_saveall = true            -- Shows the "Save All and Continue" option. You will also be asked to confirm.
  show_saveall_noconfirm = true  -- Same as above, but without the extra confirmation dialog. Overrides show_saveall.
}
```

## Notes

By default, lazygit-confirm doesn't ask you if you want to save all buffers before continuing.
This was a deliberate choice -- I wanted to force myself to check the modified buffers, just in case the change to the buffer was an accident.
However, a few people have suggested that I should add it, so I've included it as an option.

Also, lazygit-confirm doesn't check for any dependencies.
If Snacks or fzf-lua are installed, lazygit-confirm will fail ungracefully.

