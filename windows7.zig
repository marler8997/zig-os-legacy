const builtin = @import("builtin");
const std = @import("std");

comptime {
    if (builtin.os.tag != .windows) @compileError("windows7 os only compatible if compiling for Windows");
}

pub const system = struct {
    // TODO: actually create the correct declarations
    pub usingnamespace std.c;
};
