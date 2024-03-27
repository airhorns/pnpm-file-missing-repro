# pnpm file: missing changes reproduction

The issue: `file:` dependencies reflect changes made to the contents of files that exist when `pnpm install` is run, but it doesn't reflect newly added files, or files that are removed then added.

## The test

- Setup an outer package that depends on an inner package via `file:`. 
- Install when the inner package has only one file, `a.js`, and try to require `inner/a` and `inner/b`. As expected, because b.js doesn't exist yet, this fails.
- Add `inner/b.js`
- Try to require `inner/a` and `inner/b`, and it should work, because we're targeting the folder that has the file now, but it doesn't work, b is still not found. this is because no new hardlink has been set up from `node_modules/inner` to the real location of `inner`.

With `link:`, this works fine, because the whole folder is symlinked. But, `link:`'d packages don't install dependencies, which motivates the use of `file:` in the first place.