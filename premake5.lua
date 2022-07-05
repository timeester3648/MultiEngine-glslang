include "../../premake/common_premake_defines.lua"

project "glslang"
	kind "StaticLib"
	language "C++"
	cppdialect "C++latest"
	cdialect "C17"
	targetname "%{prj.name}"
	inlining "Auto"

	includedirs {
		"%{IncludeDir.glslang}",
		"%{IncludeDir.spirv_tools}/spirv_tools",

		"./glslang/Include"
	}

	defines {
		"ENABLE_OPT",
		"ENABLE_HLSL"
	}

	files {
		"./**.h",
		"./**.cpp"
	}

 	filter "system:windows"
		disablewarnings { "4146" }
		defines { "GLSLANG_OSINCLUDE_WIN32" }
		excludes { "./glslang/OSDependent/Unix/ossource.cpp" }

 	filter "configurations:Debug"
		defines { "MLE_DEBUG_BUILD", "DEBUG" }
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines { "MLE_RELEASE_BUILD", "NDEBUG" }
		flags { "LinkTimeOptimization" }
		runtime "Release"
		optimize "speed"
		intrinsics "on"

	filter "configurations:Distribution"
		defines {  "MLE_DISTRIBUTION_BUILD", "NDEBUG" }
		flags { "LinkTimeOptimization" }
		runtime "Release"
		optimize "speed"
		intrinsics "on"