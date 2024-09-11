const std = @import("std");
const Stack = @import("stack.zig").Stack;

pub const Interpreter = struct {
    bytecode: []u8,
    pc: usize = 0,
    stack: Stack,
    pub fn init(bytecode: []u8, stack_capacity: usize, allocator: *std.mem.Allocator) !Interpreter {
        return Interpreter{
            .bytecode = bytecode,
            .stack = try Stack.init(allocator, stack_capacity),
        };
    }
    pub fn run(self: *Interpreter) !void {
        while (self.pc < self.bytecode.len) {
            const opcode = self.bytecode[self.pc];
            switch (opcode) {
                // Implement your opcodes here
                else => {
                    return std.debug.panic("Unknown opcode: {d}", .{opcode});
                },
            }
            self.pc += 1;
        }
    }

    pub fn deinit(self: *Interpreter) void {
        self.stack.deinit();
    }
};
