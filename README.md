# ip-address-sort

This project provides a class that collects IP addresses and delivers the top 100 IP address results.

## Running the code

1. Clone this rep
2. Run `ruby ip_address_sort.rb`
3. Examine the output

## Questions

### What would you do differently if you had more time?

I would build an actual web service. If this was a
real-world example, I would also look at multi-threading so that each request could
be handled by its own thread, thus not blocking any attempts to save an IP address.

### What is the runtime complexity of each function?

1. `request_handled` - O(n)
2. `top100` - O(n log n)
3. `clear` - O(1)

### How does your code work?

I chose to build a hash with this structure:

```
{
  10: ["1.1.1.1", "2.2.2.2", "3.3.3.3",
  9: ["4.4.4.4"],
  ...
}
```

The key is the number of times an IP address has been seen. The value is an array
of the IP addresses that have been seen that number of times.

I determine the top 100 by checking that a key is in the range of the existing top 100.
I then access the hash by the top 100 counts and start inserting the IP addresses
into a rankings array. 

### What other approaches did you decide not to pursue?

I chose not iterate or sort by all count keys in the counts hash. Rather, I do
a comparison of the 100 counts and drop the lowest count key, which limits the number of count keys to 100.

### How would you test this?

I included a test example in my code. Basically, I do this:

1. Generate IP addresses.
2. Pass each address into the `request_handled` function
3. Execute `top100`. Measure the execution time. Confirm that the returned object
actually contains the top100 IP addresses.

