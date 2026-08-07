#!/usr/bin/env lua

-- Standalone Video Converter
-- Convert videos for social media and other platforms
-- Usage: lua convert-video.lua <input_file> [preset] [options]

-- Preset definitions
local presets = {
	twitter = {
		name = "Twitter/X",
		width = 1280,
		height = 720,
		video_codec = "libx264",
		video_bitrate = "2M",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = 30,
		format = "mp4",
		max_duration = 140,
		note = "Optimized for Twitter (max 512MB, 2:20 duration)",
	},
	instagram = {
		name = "Instagram Feed",
		width = 1080,
		height = 1080,
		video_codec = "libx264",
		video_bitrate = "3.5M",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = 30,
		format = "mp4",
		max_duration = 60,
		note = "Square format for Instagram feed (max 60s)",
	},
	reel = {
		name = "Instagram Reel",
		width = 1080,
		height = 1920,
		video_codec = "libx264",
		video_bitrate = "5M",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = 30,
		format = "mp4",
		max_duration = 90,
		note = "Vertical 9:16 for Instagram Reels (max 90s)",
	},
	youtube = {
		name = "YouTube 1080p",
		width = 1920,
		height = 1080,
		video_codec = "libx264",
		video_crf = "18",
		audio_codec = "aac",
		audio_bitrate = "192k",
		framerate = "source",
		format = "mp4",
		note = "High quality for YouTube uploads",
	},
	discord = {
		name = "Discord 8MB",
		width = 1280,
		height = 720,
		video_codec = "libx264",
		video_bitrate = "800k",
		audio_codec = "aac",
		audio_bitrate = "96k",
		framerate = 30,
		format = "mp4",
		target_size_mb = 8,
		note = "Compressed for Discord 8MB limit",
	},
	discord_nitro = {
		name = "Discord Nitro",
		width = 1920,
		height = 1080,
		video_codec = "libx264",
		video_bitrate = "4M",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = 30,
		format = "mp4",
		target_size_mb = 50,
		note = "For Discord Nitro users (50MB limit)",
	},
	whatsapp = {
		name = "WhatsApp",
		width = 640,
		height = 480,
		video_codec = "libx264",
		video_bitrate = "400k",
		audio_codec = "aac",
		audio_bitrate = "64k",
		framerate = 25,
		format = "mp4",
		target_size_mb = 16,
		note = "Optimized for WhatsApp (max 16MB)",
	},
	web = {
		name = "Web Standard",
		width = 1280,
		height = 720,
		video_codec = "libx264",
		video_crf = "23",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = 30,
		format = "mp4",
		note = "Good balance for web sharing",
	},
	compress = {
		name = "Compressed",
		width = "source",
		height = "source",
		video_codec = "libx265",
		video_crf = "28",
		audio_codec = "aac",
		audio_bitrate = "128k",
		framerate = "source",
		format = "mp4",
		note = "Smaller file size with H.265",
	},
}

-- Configuration
local config = {
	use_hwaccel = true,
	hwaccel_api = "auto",
	preserve_aspect_ratio = true,
	output_suffix = "_converted",
	verbose = false,
}

-- Utility functions
local function file_exists(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

local function get_video_info(input_file)
	local cmd = string.format('ffprobe -v quiet -print_format json -show_streams -show_format "%s"', input_file)
	local handle = io.popen(cmd)
	if handle == nil then
		print("Could not run cmd: " + cmd)
		return
	end
	local result = handle:read("*a")
	handle:close()

	-- Parse JSON manually (basic parsing)
	local info = {
		duration = tonumber(result:match('"duration": "([%d%.]+)"')) or 0,
		width = tonumber(result:match('"width": (%d+)')) or 0,
		height = tonumber(result:match('"height": (%d+)')) or 0,
		fps = 30, -- Default, would need more complex parsing for actual fps
	}

	-- Try to get fps from r_frame_rate
	local fps_match = result:match('"r_frame_rate": "(%d+)/(%d+)"')
	if fps_match then
		local num, den = result:match('"r_frame_rate": "(%d+)/(%d+)"')
		if num and den and tonumber(den) > 0 then
			info.fps = tonumber(num) / tonumber(den)
		end
	end

	return info
end

local function get_preset_names()
	local names = {}
	for name, _ in pairs(presets) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

local function calculate_bitrate_for_size(duration, target_size_mb, audio_bitrate)
	local target_size_bits = target_size_mb * 8 * 1024 * 1024
	local audio_bitrate_num = tonumber(audio_bitrate:match("(%d+)")) * 1000
	local total_audio_bits = audio_bitrate_num * duration
	local available_video_bits = target_size_bits - total_audio_bits
	local video_bitrate = math.floor(available_video_bits / duration * 0.95)

	return math.max(video_bitrate, 100000)
end

local function detect_hwaccel()
	-- Try to detect available hardware acceleration
	local function command_exists(cmd)
		local handle = io.popen("which " .. cmd .. " 2>/dev/null")
		if handle == nil then
			print("Could not run cmd: " + cmd)
			return
		end
		local result = handle:read("*a")
		handle:close()
		return result ~= ""
	end

	if command_exists("nvidia-smi") then
		return "nvenc"
	elseif command_exists("vainfo") then
		return "vaapi"
	elseif os.execute("uname -s | grep -q Darwin") == 0 then
		return "videotoolbox"
	else
		return nil
	end
end

local function get_hwaccel_codec(base_codec, api)
	if not config.use_hwaccel then
		return base_codec
	end

	if api == "auto" then
		api = detect_hwaccel()
		if not api then
			return base_codec
		end
	end

	local codec_map = {
		libx264 = {
			nvenc = "h264_nvenc",
			vaapi = "h264_vaapi",
			qsv = "h264_qsv",
			videotoolbox = "h264_videotoolbox",
		},
		libx265 = {
			nvenc = "hevc_nvenc",
			vaapi = "hevc_vaapi",
			qsv = "hevc_qsv",
			videotoolbox = "hevc_videotoolbox",
		},
	}

	if codec_map[base_codec] and codec_map[base_codec][api] then
		return codec_map[base_codec][api]
	end

	return base_codec
end

local function generate_output_filename(input_file, preset_name, preset)
	local dir = input_file:match("(.*/)")
	local filename = input_file:match("([^/]+)$")
	local name_part = filename:match("(.+)%..+") or filename

	local output_name = string.format("%s%s_%s.%s", name_part, config.output_suffix, preset_name, preset.format)

	return (dir or "") .. output_name
end

local function build_ffmpeg_command(input_file, output_file, preset, video_info)
	local cmd = { "ffmpeg", "-hide_banner" }

	if not config.verbose then
		table.insert(cmd, "-loglevel")
		table.insert(cmd, "warning")
	end

	table.insert(cmd, "-i")
	table.insert(cmd, string.format('"%s"', input_file))

	-- Video codec
	local video_codec = get_hwaccel_codec(preset.video_codec, config.hwaccel_api)
	table.insert(cmd, "-c:v")
	table.insert(cmd, video_codec)

	-- Video size
	if preset.width ~= "source" and preset.height ~= "source" then
		if config.preserve_aspect_ratio then
			table.insert(cmd, "-vf")
			table.insert(
				cmd,
				string.format(
					'"scale=%d:%d:force_original_aspect_ratio=decrease,pad=%d:%d:(ow-iw)/2:(oh-ih)/2"',
					preset.width,
					preset.height,
					preset.width,
					preset.height
				)
			)
		else
			table.insert(cmd, "-s")
			table.insert(cmd, string.format("%dx%d", preset.width, preset.height))
		end
	end

	-- Framerate
	if preset.framerate ~= "source" then
		table.insert(cmd, "-r")
		table.insert(cmd, tostring(preset.framerate))
	end

	-- Video quality
	if preset.target_size_mb and video_info.duration > 0 then
		local video_bitrate =
			calculate_bitrate_for_size(video_info.duration, preset.target_size_mb, preset.audio_bitrate)
		table.insert(cmd, "-b:v")
		table.insert(cmd, tostring(video_bitrate))
		print(
			string.format("  Calculated video bitrate: %d bps for %d MB target", video_bitrate, preset.target_size_mb)
		)
	elseif preset.video_bitrate then
		table.insert(cmd, "-b:v")
		table.insert(cmd, preset.video_bitrate)
	elseif preset.video_crf then
		table.insert(cmd, "-crf")
		table.insert(cmd, preset.video_crf)
	end

	-- Audio settings
	table.insert(cmd, "-c:a")
	table.insert(cmd, preset.audio_codec)
	table.insert(cmd, "-b:a")
	table.insert(cmd, preset.audio_bitrate)

	-- Duration limit
	if preset.max_duration and video_info.duration > preset.max_duration then
		table.insert(cmd, "-t")
		table.insert(cmd, tostring(preset.max_duration))
		print(string.format("  Limiting duration to %d seconds", preset.max_duration))
	end

	-- Format specific options
	if preset.format == "mp4" then
		table.insert(cmd, "-movflags")
		table.insert(cmd, "+faststart")
	end

	-- Hardware specific options
	if video_codec:find("nvenc") then
		table.insert(cmd, "-preset")
		table.insert(cmd, "p4")
	end

	-- Output file
	table.insert(cmd, "-y")
	table.insert(cmd, string.format('"%s"', output_file))

	return table.concat(cmd, " ")
end

local function convert_video(input_file, preset_name)
	if not file_exists(input_file) then
		print("Error: Input file does not exist: " .. input_file)
		return false
	end

	local preset = presets[preset_name]
	if not preset then
		print("Error: Unknown preset: " .. preset_name)
		print("Available presets: " .. table.concat(get_preset_names(), ", "))
		return false
	end

	print(string.format("\nConverting to %s format...", preset.name))
	print("  " .. preset.note)

	-- Get video info
	print("\nAnalyzing input file...")
	local video_info = get_video_info(input_file)

	if video_info == nil then
		return
	end
	print(string.format("  Duration: %.1f seconds", video_info.duration))
	print(string.format("  Resolution: %dx%d", video_info.width, video_info.height))
	print(string.format("  FPS: %.2f", video_info.fps))

	-- Generate output filename
	local output_file = generate_output_filename(input_file, preset_name, preset)

	-- Build and run ffmpeg command
	local ffmpeg_cmd = build_ffmpeg_command(input_file, output_file, preset, video_info)

	if config.verbose then
		print("\nFFmpeg command:")
		print(ffmpeg_cmd)
	end

	print("\nConverting...")
	local start_time = os.time()
	local success = os.execute(ffmpeg_cmd)
	local elapsed = os.time() - start_time

	if success == 0 or success == true then
		print(string.format("\nSuccess! Conversion completed in %d seconds", elapsed))
		print("Output file: " .. output_file)

		-- Show file size
		local cmd =
			string.format('stat -f%%z "%s" 2>/dev/null || stat -c%%s "%s" 2>/dev/null', output_file, output_file)
		local handle = io.popen(cmd)
		if handle == nil then
			print("Could not run cmd: " + cmd)
			return
		end
		local size = handle:read("*a")
		handle:close()
		local size_mb = tonumber(size) / 1024 / 1024
		if size_mb then
			print(string.format("File size: %.1f MB", size_mb))
		end

		return true
	else
		print("\nError: Conversion failed!")
		return false
	end
end

local function print_help()
	print([[
Video Converter - Convert videos for social media and web

Usage:
  lua convert-video.lua <input_file> <preset> [options]
  lua convert-video.lua --help
  lua convert-video.lua --list

Presets:
  twitter       - Twitter/X (720p, 2:20 max)
  instagram     - Instagram Feed (1:1 square, 60s max)
  reel          - Instagram Reel (9:16 vertical, 90s max)
  youtube       - YouTube (1080p high quality)
  discord       - Discord (8MB limit)
  discord_nitro - Discord Nitro (50MB limit)
  whatsapp      - WhatsApp (16MB limit)
  web           - Web standard (720p balanced)
  compress      - Compressed (H.265, smaller size)

Options:
  --no-hwaccel     Disable hardware acceleration
  --no-aspect      Don't preserve aspect ratio
  --suffix <text>  Output filename suffix (default: _converted)
  --verbose        Show detailed output

Examples:
  lua convert-video.lua video.mp4 twitter
  lua convert-video.lua video.mp4 discord --no-hwaccel
  lua convert-video.lua video.mp4 compress --suffix _small

Environment Variables:
  VIDEO_CONVERTER_HWACCEL=nvenc|vaapi|qsv|videotoolbox|off
  VIDEO_CONVERTER_VERBOSE=1
]])
end

local function parse_args(args)
	local input_file = nil
	local preset_name = nil
	local i = 1

	while i <= #args do
		local arg = args[i]

		if arg == "--help" or arg == "-h" then
			print_help()
			os.exit(0)
		elseif arg == "--list" then
			print("Available presets:")
			for _, name in ipairs(get_preset_names()) do
				print("  " .. name .. " - " .. presets[name].note)
			end
			os.exit(0)
		elseif arg == "--no-hwaccel" then
			config.use_hwaccel = false
		elseif arg == "--no-aspect" then
			config.preserve_aspect_ratio = false
		elseif arg == "--verbose" or arg == "-v" then
			config.verbose = true
		elseif arg == "--suffix" and i < #args then
			i = i + 1
			config.output_suffix = args[i]
		elseif not input_file then
			input_file = arg
		elseif not preset_name then
			preset_name = arg
		end

		i = i + 1
	end

	return input_file, preset_name
end

-- Main function
local function main(args)
	-- Check environment variables
	local env_hwaccel = os.getenv("VIDEO_CONVERTER_HWACCEL")
	if env_hwaccel then
		if env_hwaccel == "off" then
			config.use_hwaccel = false
		else
			config.hwaccel_api = env_hwaccel
		end
	end

	if os.getenv("VIDEO_CONVERTER_VERBOSE") == "1" then
		config.verbose = true
	end

	-- Parse command line arguments
	local input_file, preset_name = parse_args(args)

	if not input_file or not preset_name then
		print("Error: Missing required arguments")
		print("Usage: lua convert-video.lua <input_file> <preset>")
		print("Try 'lua convert-video.lua --help' for more information")
		os.exit(1)
	end

	-- Detect hardware acceleration
	if config.use_hwaccel and config.hwaccel_api == "auto" then
		local detected = detect_hwaccel()
		if detected then
			print("Detected hardware acceleration: " .. detected)
		else
			print("No hardware acceleration detected, using software encoding")
		end
	end

	-- Convert the video
	local success = convert_video(input_file, preset_name)
	os.exit(success and 0 or 1)
end

-- Run main function
main(arg)
