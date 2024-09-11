const std = @import("std");

pub const Stack = struct {
    data: []u32 = undefined,
    pub fn init(allocator: *std.mem.Allocator, capacity: usize) !Stack {
        return Stack{ .data = try allocator.alloc(u32, capacity) };
    }
    pub fn deinit(self: *Stack) void {
        _ = self;
    }
};
