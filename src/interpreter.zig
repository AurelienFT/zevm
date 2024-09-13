const std = @import("std");
const Stack = @import("stack.zig").Stack;
const Opcode = @import("opcode.zig").Opcode;
const OpcodeImpls = @import("opcode_impls.zig");

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
            const opcode: Opcode = @enumFromInt(self.bytecode[self.pc]);
            self.pc += 1;

            std.debug.print("Executing opcode: {s}\n", .{@tagName(opcode)});

            switch (opcode) {
                Opcode.STOP => {
                    return;
                },
                Opcode.ADD => {
                    const a = try self.stack.pop();
                    const b = try self.stack.pop();
                    try self.stack.push(OpcodeImpls.add(a, b));
                },
                Opcode.MUL => {
                    const a = try self.stack.pop();
                    const b = try self.stack.pop();
                    try self.stack.push(OpcodeImpls.mul(a, b));
                },
                Opcode.SUB => {
                    const a = try self.stack.pop();
                    const b = try self.stack.pop();
                    try self.stack.push(OpcodeImpls.sub(a, b));
                },
                Opcode.DIV => {
                    const a = try self.stack.pop();
                    const b = try self.stack.pop();
                    try self.stack.push(OpcodeImpls.div(a, b));
                },
                Opcode.PUSH1 => {
                    const value = self.bytecode[self.pc];
                    self.pc += 1;
                    try self.stack.push(value);
                },
                Opcode.PUSH2 => {
                    const value = std.mem.readInt(u16, self.bytecode[self.pc..][0..2], .big);
                    self.pc += 2;
                    try self.stack.push(value);
                },
                Opcode.PUSH3 => {
                    const value = std.mem.readInt(u24, self.bytecode[self.pc..][0..3], .big);
                    self.pc += 3;
                    try self.stack.push(value);
                },
                Opcode.PUSH4 => {
                    const value = std.mem.readInt(u32, self.bytecode[self.pc..][0..4], .big);
                    self.pc += 4;
                    try self.stack.push(value);
                },
                Opcode.PUSH5 => {
                    const value = std.mem.readInt(u40, self.bytecode[self.pc..][0..5], .big);
                    self.pc += 5;
                    try self.stack.push(value);
                },
                Opcode.PUSH6 => {
                    const value = std.mem.readInt(u48, self.bytecode[self.pc..][0..6], .big);
                    self.pc += 6;
                    try self.stack.push(value);
                },
                else => {
                    return std.debug.panic("Unknown opcode: {s}", .{@tagName(opcode)});
                },
            }
        }
    }

    pub fn deinit(self: *Interpreter) void {
        self.stack.deinit();
    }
};
