<p align="center" >
<img src="https://github.com/igormatyushkin014/DataKit/blob/master/Images/logo-1024-300.png" alt="DataKit" title="DataKit">
</p>

# At a Glance

`DataKit` is an extremely fast in-memory database with intuitive and powerful internal language. It's developed with keeping in mind main troubles that iOS developer encounter with traditional databases like CoreData. To simplify development process, `DataKit` is based on several axioms:

1. **No contexts.** Really. Who need those different contexts for each thread in CoreData? Everybody tired of them. This is a useless waste of time to write a code for retrieveing the same object from another context in another thread. `DataKit` uses one context and it's hidden from developer.
2. **Never freeze UI queue.** `DataKit` uses its own queue for all operations. They are performed asynchronously and never stop UI updates.
3. **Be relational.** You can work with classes like with tables in SQL database. No more to say here.
4. **Self-learning.** Yes, `DataKit` has a self-learning algorithm. More requests to database you make, faster you get results.

**Documentation and framework are currently in development. Will be published soon :)**

# License

`DataKit` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
