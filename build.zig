const std = @import("std");

const Os = enum {
    windows7,
    macos_high_sierra,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    inline for (std.meta.fields(Os)) |os| {
        const mod = b.addModule(os.name, .{
            .source_file = .{ .path = os.name ++ ".zig" },
        });
        
        const exe = b.addExecutable(.{
            .name = "hello-" ++ os.name,
            .root_source_file = .{ .path = "test/hello.zig" },
            .target = target,
            .optimize = optimize,
        });
        b.step("build-hello-" ++ os.name, "Build 'hello' for os " ++ os.name).dependOn(&exe.step);

        exe.addModule("oslegacy", mod);
    
        const run_cmd = b.addRunArtifact(exe);
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }
        const run_step = b.step("run-hello-" ++ os.name, "Run 'hello' for os " ++ os.name);
        run_step.dependOn(&run_cmd.step);
    }
}
