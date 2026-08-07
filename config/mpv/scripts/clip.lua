-- Enhanced MPV Clip Script
-- Combines features from both scripts with improvements
--
-- Configure using ~/.config/mpv/script-opts/mpv_clip.conf

local mp = require("mp")
local utils = require("mp.utils")
local options = require("mp.options")

-- Configuration options
local o = {
	-- Key bindings
	key_set_start = "alt+i", -- Set clip start
	key_set_end = "alt+o", -- Set clip end
	key_save_clip = "alt+s", -- Save the clip
	key_toggle_clip = "ctrl+r", -- Toggle clip mode (start/stop in one key)
	key_clear_markers = "alt+c", -- Clear clip markers

	-- Output settings
	output_directory = "", -- Empty = use default
	default_directory = "~/Videos/mpv_clips",
	filename_format = "{title}_{start}-{end}_{timestamp}",

	-- Encoding settings
	use_encoding = false, -- false = copy streams, true = re-encode
	video_codec = "libx265",
	video_crf = "24",
	video_preset = "medium",
	video_framerate = "keep", -- keep, 30, 60, 24, 23.976, etc.
	audio_codec = "copy", -- copy, aac, libopus, ac3, etc.
	audio_bitrate = "192k", -- only used when audio_codec is not "copy"
	audio_channels = "keep", -- keep, auto, 1, 2 (only used when audio_codec is not "copy")
	container_format = "mp4", -- mkv, mp4, webm, etc.

	-- Hardware acceleration settings
	use_hwaccel = false, -- Enable hardware acceleration
	hwaccel_api = "auto", -- auto, vaapi, nvenc, qsv, videotoolbox, amf
	hwaccel_device = "", -- Device to use (empty = default)
	-- Codec mappings for different hardware APIs
	nvenc_codec = "hevc_nvenc", -- h264_nvenc, hevc_nvenc, av1_nvenc
	vaapi_codec = "hevc_vaapi", -- h264_vaapi, hevc_vaapi, av1_vaapi
	qsv_codec = "hevc_qsv", -- h264_qsv, hevc_qsv, av1_qsv
	amf_codec = "hevc_amf", -- h264_amf, hevc_amf
	videotoolbox_codec = "hevc_videotoolbox", -- h264_videotoolbox, hevc_videotoolbox

	-- Behavior settings
	clear_markers_after_clip = true,
	show_osd_messages = true,
	osd_duration = 3,
	create_directory = true, -- Auto-create output directory if missing
}

-- Read user options
options.read_options(o, "mpv_clip")

-- State variables
local clip_start = nil
local clip_end = nil
local is_toggle_mode = false

-- Utility functions
local function expand_path(path)
	if path:sub(1, 1) == "~" then
		local home = os.getenv("HOME") or os.getenv("USERPROFILE")
		return home .. path:sub(2)
	end
	return path
end

local function get_output_directory()
	local dir = o.output_directory
	if dir == "" then
		dir = o.default_directory
	end
	dir = expand_path(dir)

	if o.create_directory then
		local mkdir_cmd
		if package.config:sub(1, 1) == "\\" then
			-- Windows
			mkdir_cmd = string.format('mkdir "%s" 2>NUL', dir:gsub("/", "\\"))
		else
			-- Unix-like
			mkdir_cmd = string.format("mkdir -p '%s'", dir)
		end
		os.execute(mkdir_cmd)
	end

	return dir
end

local function format_time(seconds)
	if not seconds then
		return "00:00:00"
	end
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = math.floor(seconds % 60)
	return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

local function format_time_compact(seconds)
	if not seconds then
		return "0"
	end
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = math.floor(seconds % 60)

	if hours > 0 then
		return string.format("%dh%dm%ds", hours, minutes, secs)
	elseif minutes > 0 then
		return string.format("%dm%ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

local function show_message(msg, duration)
	if o.show_osd_messages then
		mp.osd_message(msg, duration or o.osd_duration)
	end
	mp.msg.info(msg)
end

local function generate_filename(start_time, end_time)
	local media_title = mp.get_property("media-title") or "untitled"
	local filename = mp.get_property("filename") or "video"

	-- Clean up title for filename
	media_title = media_title:gsub('[<>:"/\\|?*]', "_")

	-- Format the filename
	local output = o.filename_format
	output = output:gsub("{title}", media_title)
	output = output:gsub("{filename}", filename:match("(.+)%..+") or filename)
	output = output:gsub("{start}", format_time_compact(start_time))
	output = output:gsub("{end}", format_time_compact(end_time))
	output = output:gsub("{duration}", format_time_compact(end_time - start_time))
	output = output:gsub("{timestamp}", os.date("%Y%m%d_%H%M%S"))

	return output .. "." .. o.container_format
end

local function get_hwaccel_codec()
	-- Determine which hardware codec to use based on settings
	if not o.use_hwaccel then
		return o.video_codec
	end

	local api = o.hwaccel_api

	-- Auto-detect available hardware acceleration
	if api == "auto" then
		-- Try to detect available hardware acceleration
		-- TODO: This is a simplified detection
		local function command_exists(cmd)
			local handle = io.popen("which " .. cmd .. " 2>/dev/null")
			if handle == nil then
				show_message("Could not find cmd: " + cmd)
				return false
			end
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end

		-- Check for NVIDIA
		if command_exists("nvidia-smi") then
			api = "nvenc"
		-- Check for VAAPI (Linux)
		elseif command_exists("vainfo") then
			api = "vaapi"
		-- Check for VideoToolbox (macOS)
		elseif os.execute("sysctl -n machdep.cpu.brand_string 2>/dev/null | grep -q 'Apple'") == 0 then
			api = "videotoolbox"
		else
			-- Fallback to software encoding
			show_message("No hardware acceleration detected, using software encoding")
			return o.video_codec
		end
	end

	-- Return the appropriate codec based on API
	if api == "nvenc" then
		return o.nvenc_codec
	elseif api == "vaapi" then
		return o.vaapi_codec
	elseif api == "qsv" then
		return o.qsv_codec
	elseif api == "amf" then
		return o.amf_codec
	elseif api == "videotoolbox" then
		return o.videotoolbox_codec
	else
		return o.video_codec
	end
end

local function get_hwaccel_args()
	-- Get hardware acceleration specific arguments
	local args = {}

	if not o.use_hwaccel or o.hwaccel_api == "auto" then
		return args
	end

	local api = o.hwaccel_api

	if api == "vaapi" then
		table.insert(args, "-vaapi_device")
		table.insert(args, o.hwaccel_device ~= "" and o.hwaccel_device or "/dev/dri/renderD128")
		table.insert(args, "-vf")
		table.insert(args, "format=nv12,hwupload")
	elseif api == "nvenc" then
		if o.hwaccel_device ~= "" then
			table.insert(args, "-gpu")
			table.insert(args, o.hwaccel_device)
		end
	elseif api == "qsv" then
		table.insert(args, "-init_hw_device")
		table.insert(args, "qsv=hw")
		table.insert(args, "-filter_hw_device")
		table.insert(args, "hw")
	elseif api == "videotoolbox" then
		table.insert(args, "-vf")
		table.insert(args, "format=nv12")
	end

	return args
end

local function save_clip()
	if not clip_start then
		show_message("No clip start set! Use " .. o.key_set_start .. " to set start.")
		return
	end

	if not clip_end then
		show_message("No clip end set! Use " .. o.key_set_end .. " to set end.")
		return
	end

	if clip_start >= clip_end then
		show_message("Invalid clip: start time must be before end time!")
		return
	end

	local input_path = mp.get_property("path")
	if not input_path then
		show_message("No file loaded!")
		return
	end

	local output_dir = get_output_directory()
	local output_filename = generate_filename(clip_start, clip_end)
	local output_path = output_dir .. "/" .. output_filename

	local args

	if o.use_encoding then
		-- Re-encode with specified settings
		local video_codec = get_hwaccel_codec()
		local hwaccel_args = get_hwaccel_args()

		args = {
			"ffmpeg",
			"-hide_banner",
			"-loglevel",
			"error",
			"-ss",
			tostring(clip_start),
			"-i",
			input_path,
			"-t",
			tostring(clip_end - clip_start),
		}

		-- Add hardware acceleration args before output options
		for _, arg in ipairs(hwaccel_args) do
			table.insert(args, arg)
		end

		-- Add encoding options
		table.insert(args, "-c:v")
		table.insert(args, video_codec)

		-- Use appropriate quality setting based on codec
		if
			video_codec:find("nvenc")
			or video_codec:find("vaapi")
			or video_codec:find("qsv")
			or video_codec:find("amf")
			or video_codec:find("videotoolbox")
		then
			-- Hardware encoders typically use different quality parameters
			if video_codec:find("nvenc") then
				table.insert(args, "-rc")
				table.insert(args, "vbr")
				table.insert(args, "-cq")
				table.insert(args, o.video_crf)
				table.insert(args, "-preset")
				table.insert(args, "p4") -- p1-p7 for NVENC, p4 is balanced
			elseif video_codec:find("vaapi") then
				table.insert(args, "-rc_mode")
				table.insert(args, "CQP")
				table.insert(args, "-qp")
				table.insert(args, o.video_crf)
			elseif video_codec:find("videotoolbox") then
				table.insert(args, "-q:v")
				table.insert(args, tostring(tonumber(o.video_crf) * 2)) -- videotoolbox uses different scale
			else
				-- Generic hardware encoder settings
				table.insert(args, "-q:v")
				table.insert(args, o.video_crf)
			end
		else
			-- Software encoder settings
			table.insert(args, "-crf")
			table.insert(args, o.video_crf)
			table.insert(args, "-preset")
			table.insert(args, o.video_preset)
		end

		-- Handle framerate if specified
		if o.video_framerate ~= "keep" then
			table.insert(args, "-r")
			table.insert(args, o.video_framerate)
		end

		table.insert(args, "-c:a")
		table.insert(args, o.audio_codec)

		-- Only add audio encoding options if we're not copying
		if o.audio_codec ~= "copy" then
			table.insert(args, "-b:a")
			table.insert(args, o.audio_bitrate)

			-- Handle audio channels
			if o.audio_channels ~= "auto" and o.audio_channels ~= "keep" then
				table.insert(args, "-ac")
				table.insert(args, o.audio_channels)
			end

			-- Add specific handling for opus with surround sound
			if o.audio_codec == "libopus" and (o.audio_channels == "keep" or o.audio_channels == "auto") then
				-- Opus has issues with 5.1, so downmix to stereo by default
				table.insert(args, "-ac")
				table.insert(args, "2")
			end
		end

		table.insert(args, "-avoid_negative_ts")
		table.insert(args, "make_zero")
		table.insert(args, "-y") -- Overwrite output
		table.insert(args, output_path)
	else
		-- Copy streams without re-encoding (faster)
		args = {
			"ffmpeg",
			"-hide_banner",
			"-loglevel",
			"error",
			"-ss",
			tostring(clip_start),
			"-i",
			input_path,
			"-t",
			tostring(clip_end - clip_start),
			"-c",
			"copy",
			"-avoid_negative_ts",
			"make_zero",
			"-y", -- Overwrite output
			output_path,
		}
	end

	local mode_desc = ""
	if not o.use_encoding then
		mode_desc = " (copy mode - fast)"
	elseif o.use_hwaccel then
		mode_desc = " (hardware accelerated)"
	else
		mode_desc = " (software encoding)"
	end

	show_message(string.format("Saving clip: %s to %s%s", format_time(clip_start), format_time(clip_end), mode_desc), 5)

	-- Run ffmpeg
	local res = utils.subprocess({ args = args, cancellable = false })

	if res.status == 0 then
		show_message(
			string.format("Clip saved: %s\nDuration: %s", output_filename, format_time_compact(clip_end - clip_start)),
			5
		)

		if o.clear_markers_after_clip then
			clip_start = nil
			clip_end = nil
			is_toggle_mode = false
		end
	else
		show_message("Failed to save clip! Check console for errors.", 5)
		if res.stderr then
			show_message("FFmpeg error: " .. res.stderr)
		end
		if res.stderr and res.stderr:find("Invalid channel layout") then
			mp.msg.info("Tip: Try setting audio_codec=copy to preserve original audio")
		end
	end
end

-- Keybinding functions
local function set_clip_start()
	clip_start = mp.get_property_number("time-pos")
	if clip_start then
		show_message("Clip start: " .. format_time(clip_start))
	else
		show_message("Cannot set clip start (no file loaded?)")
	end
end

local function set_clip_end()
	clip_end = mp.get_property_number("time-pos")
	if clip_end then
		show_message("Clip end: " .. format_time(clip_end))
		if clip_start and clip_end > clip_start then
			show_message(
				string.format(
					"Ready to clip: %s (press %s to save)",
					format_time_compact(clip_end - clip_start),
					o.key_save_clip
				)
			)
		end
	else
		show_message("Cannot set clip end (no file loaded?)")
	end
end

local function toggle_clip()
	if not is_toggle_mode then
		-- Start clipping
		clip_start = mp.get_property_number("time-pos")
		is_toggle_mode = true
		if clip_start then
			show_message(
				"Clip started: " .. format_time(clip_start) .. " (press " .. o.key_toggle_clip .. " again to save)"
			)
		else
			show_message("Cannot start clip (no file loaded?)")
			is_toggle_mode = false
		end
	else
		-- End and save clip
		clip_end = mp.get_property_number("time-pos")
		if clip_start and clip_end and clip_end > clip_start then
			save_clip()
		else
			show_message("Invalid clip range!")
		end
		is_toggle_mode = false
	end
end

local function clear_markers()
	clip_start = nil
	clip_end = nil
	is_toggle_mode = false
	show_message("Clip markers cleared")
end

local function show_clip_info()
	if clip_start and clip_end then
		show_message(
			string.format(
				"Clip: %s - %s (%s)",
				format_time(clip_start),
				format_time(clip_end),
				format_time_compact(clip_end - clip_start)
			)
		)
	elseif clip_start then
		show_message("Clip start: " .. format_time(clip_start) .. " (no end set)")
	else
		show_message("No clip markers set")
	end
end

-- Register keybindings
mp.add_key_binding(o.key_set_start, "clip-set-start", set_clip_start)
mp.add_key_binding(o.key_set_end, "clip-set-end", set_clip_end)
mp.add_key_binding(o.key_save_clip, "clip-save", save_clip)
mp.add_key_binding(o.key_toggle_clip, "clip-toggle", toggle_clip)
mp.add_key_binding(o.key_clear_markers, "clip-clear", clear_markers)
mp.add_key_binding("alt+shift+c", "clip-info", show_clip_info)

-- Reset markers when a new file is loaded
mp.register_event("start-file", function()
	clip_start = nil
	clip_end = nil
	is_toggle_mode = false
end)

-- Show help on load
mp.register_event("file-loaded", function()
	mp.add_timeout(0.5, function()
		show_message(
			"Clip keys: "
				.. o.key_toggle_clip
				.. " (quick mode) or "
				.. o.key_set_start
				.. "/"
				.. o.key_set_end
				.. " + "
				.. o.key_save_clip,
			2
		)
	end)
end)
