const std = @import("std");
const Interpreter = @import("interpreter.zig").Interpreter;

pub fn main() !void {
    const str_bytecode = "620101016201010101";
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    var ac = arena.allocator();
    defer _ = arena.deinit();

    // Decode the bytecode that is in hex format
    const bytecode_size = str_bytecode.len / 2;
    var bytecode = try ac.alloc(u8, bytecode_size);
    defer ac.free(bytecode);
    bytecode = try std.fmt.hexToBytes(bytecode, str_bytecode);

    var interp = try Interpreter.init(bytecode, 1024, &ac);
    defer interp.deinit();

    try interp.run();
    const last_value = try interp.stack.pop();
    std.debug.print("Last value: {}\n", .{last_value});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
