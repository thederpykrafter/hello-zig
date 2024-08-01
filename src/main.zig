const std = @import("std");

fn color(fg: *const [5:0]u8, bg: *const [6:0]u8, text: *const [13:0]u8) !void {
    std.debug.print("{s}", .{fg});
    std.debug.print("{s}", .{bg});
    std.debug.print("{s}", .{text});
    std.debug.print("{s}", .{"\x1b[m"});
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("\x1b[{s}m are belong to us.\x1b[m\n", .{"94"});

    // stdout is for the actual output of your application
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
    try color("\x1b[34m", "\x1b[104m", "Hello, world!");
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
