package pte.security

# =========================
# DEFAULT DENY
# =========================
default allow = false

# =========================
# MAIN RULE
# =========================
allow {
    not deny[_]
}

# =========================
# DENY RULES
# =========================

# ❌ Block if security scan not passed
deny[msg] {
    input.security_scan_passed != true
    msg := "❌ Security scan not passed"
}

# ❌ Block if performance test not passed
deny[msg] {
    input.performance_test_passed != true
    msg := "❌ Performance tests not passed"
}

# ❌ Block if CPU limit missing
deny[msg] {
    not input.resources.limits.cpu
    msg := "❌ CPU limit not defined"
}

# ❌ Block if memory limit missing
deny[msg] {
    not input.resources.limits.memory
    msg := "❌ Memory limit not defined"
}

# ❌ Block if CPU too low (performance env)
deny[msg] {
    cpu := input.resources.limits.cpu
    to_number(trim_suffix(cpu, "m")) < 500
    msg := "❌ CPU limit too low for performance environment"
}

# ❌ Block if memory too low
deny[msg] {
    mem := input.resources.limits.memory
    to_number(trim_suffix(mem, "Mi")) < 512
    msg := "❌ Memory limit too low for performance environment"
}
