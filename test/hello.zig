const std = @import("std");

pub const os = @import("oslegacy");

pub fn main() !void {
    try std.io.getStdOut().writer().writeAll("Hello");
}
