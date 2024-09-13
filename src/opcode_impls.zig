const Stack = @import("stack.zig").Stack;

pub fn add(a: u256, b: u256) u256 {
    return a + b;
}

pub fn mul(a: u256, b: u256) u256 {
    return a * b;
}

pub fn sub(a: u256, b: u256) u256 {
    return a - b;
}

pub fn div(a: u256, b: u256) u256 {
    return a / b;
}
