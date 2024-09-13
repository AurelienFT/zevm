const std = @import("std");

pub const Stack = struct {
    data: []u256 = undefined,
    top: usize = 0,
    pub fn init(allocator: *std.mem.Allocator, capacity: usize) !Stack {
        return Stack{ .data = try allocator.alloc(u256, capacity) };
    }
    pub fn push(self: *Stack, value: u256) !void {
        self.data[self.top] = value;
        self.top += 1;
    }
    pub fn pop(self: *Stack) !u256 {
        if (self.top == 0) {
            return std.debug.panic("Stack underflow", .{});
        }
        self.top -= 1;
        return self.data[self.top];
    }
    pub fn deinit(self: *Stack) void {
        _ = self;
    }
};
