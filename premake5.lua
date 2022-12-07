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
		"ENABLE_OPT=true",
		"ENABLE_HLSL=true"
	}

	files {
		"./OGLCompilersDLL/**.h",
		"./OGLCompilersDLL/**.cpp",

		"./SPIRV/**.h",
		"./SPIRV/**.hpp",
		"./SPIRV/**.cpp",

		"./glslang/**.h",
		"./glslang/**.cpp"
	}

	filter "action:vs*"
		disablewarnings { "4146", "4267" }

 	filter "system:windows"
		defines { "GLSLANG_OSINCLUDE_WIN32" }
		excludes { "./glslang/OSDependent/Windows/main.cpp",
				   "./glslang/OSDependent/Unix/ossource.cpp",
				   "./glslang/OSDependent/Web/glslang.js.cpp" }