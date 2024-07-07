void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("glslang");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./LICENSE.txt");

	properties.include_directories({
		"spirv_tools",
	});

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"."
	});

	properties.files({
		"./OGLCompilersDLL/**.h",
		"./OGLCompilersDLL/**.cpp",

		"./SPIRV/**.h",
		"./SPIRV/**.hpp",
		"./SPIRV/**.cpp",

		"./glslang/**.h",
		"./glslang/**.cpp"
	});

	properties.defines({
		"ENABLE_OPT=true",
		"ENABLE_HLSL=true"
	});

	{
		MultiBuild::ScopedFilter _(workspace, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4146", "4267", "4996" });
	}

	{
		MultiBuild::ScopedFilter _(workspace, "config.platform:Windows");

		properties.defines("GLSLANG_OSINCLUDE_WIN32");

		properties.excluded_files({
			"./glslang/OSDependent/Windows/main.cpp",
			"./glslang/OSDependent/Unix/ossource.cpp",
			"./glslang/OSDependent/Web/glslang.js.cpp"
		});
	}
}