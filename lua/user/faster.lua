local faster_status_ok, faster = pcall(require, "faster")
if not faster_status_ok then
	return
end

faster.setup({
  behaviours = {
    bigfile = {
      filesize = 1
    }
  }
})
