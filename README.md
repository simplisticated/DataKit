<p align="center" >
<img src="https://github.com/igormatyushkin014/DataKit/blob/master/Images/logo-1024-300.png" alt="DataKit" title="DataKit">
</p>

<p align="center">
<a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat"></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/v/DataKit.svg?maxAge=2592000"></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/dt/DataKit.svg?maxAge=2592000"></a>
<a href="https://tldrlegal.com/license/mit-license"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat"></a>
</p>

# At a Glance

`DataKit` is an extremely fast in-memory database with intuitive and powerful internal language. It's developed with keeping in mind main troubles that iOS developer encounter with traditional databases like CoreData. To simplify development process, `DataKit` is based on several axioms:

1. **No contexts.** Really. Who need those different contexts for each thread in CoreData? Everybody tired of them. This is a useless waste of time to write a code for retrieveing the same object from another context in another thread. `DataKit` uses one context and it's hidden from developer.
2. **Never freeze UI queue.** `DataKit` uses its own queue for all operations. They are performed asynchronously and never stop UI updates.
3. **Be relational.** You can work with classes like with tables in SQL database. No more to say here.
4. **Self-learning.** Yes, `DataKit` has a self-learning algorithm. More requests to database you make, faster you get results.

# How To Get Started

- Copy content of `DataKit` folder to your project.

or

- Use `DataKit` cocoapod

**Note**: For Swift 2.x use `DataKit v0.2.2`. For Swift 3.0 use `DataKit v3.0`.

# Requirements

* iOS 8 and later
* Xcode 7 and later

# Usage

`DataKit` is designed to work with any types of data subclassed from `NSObject`.

**More documentation will be published very soon...**

# License

`DataKit` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
