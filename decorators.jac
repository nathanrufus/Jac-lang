import time;

# Timing decorator to measure function performance
def timing_decorator(func: callable) -> callable {
    def wrapper(*args: any, **kwargs: any) -> any {
        start_time = time.time();
        result = func(*args, **kwargs);
        end_time = time.time();
        execution_time = end_time - start_time;
        print(f"{func.__name__} executed in {execution_time} seconds");
        return result;
    }
    return wrapper;
}

# Caching decorator for expensive computations
def cache_decorator(func: callable) -> callable {
    cache: dict[str, any] = {};

    def wrapper(*args: any) -> any {
        # Create a simple cache key from arguments
        cache_key = str(args);

        if cache_key in cache {
            print(f"Cache hit for {func.__name__}{args}");
            return cache[cache_key];
        }

        print(f"Computing {func.__name__}{args}");
        result = func(*args);
        cache[cache_key] = result;
        return result;
    }
    return wrapper;
}

# Combine timing and caching decorators
@timing_decorator
@cache_decorator
def optimized_fibonacci(n: int) -> int {
    if n <= 1 {
        return n;
    }
    return optimized_fibonacci(n - 1) + optimized_fibonacci(n - 2);
}

@timing_decorator
@cache_decorator
def expensive_calculation(n: int) -> int {
    # Simulate expensive computation
    result = 0;
    for i in range(n * 1000) {
        result += i;
    }
    return result;
}

with entry {
    print("=== Cached Functions Demo ===");

    # First call - computed and cached
    result1 = optimized_fibonacci(3);
    print(f"Fibonacci(3) = {result1}");

    # Second call - retrieved from cache
    result2 = optimized_fibonacci(3);
    print(f"Fibonacci(3) again = {result2}");

    # Expensive calculation test
    result3 = expensive_calculation(10);
    print(f"Expensive calculation result: {result3}");

    # Second call to expensive calculation
    result4 = expensive_calculation(10);
    print(f"Expensive calculation again: {result4}");
}