# PREVIEW CHANGELOG

## [1.1.0][] - xxxx-xx-xx

### Improved Modules

#### logging

- **Error Tracking**: Added tracking of messages with the "ERROR" level by automatically retrieving details of the execution environment (file directory, exact line of code, and tracebacks). This improves debugging, saves time in identifying the source of errors, and makes logs more readable.
- **Dynamic Debug Configuration**: Introduced `setAutoDebugMode`, `setDebugMessagesEnabled`, and `setDebugLevel` functions to configure debug settings dynamically. These functions allow developers to enable or disable debug modes and set the level of debug messages at runtime.
- **Enhanced Logging**: Enhanced the `log` function to handle debug messages more effectively and include caller information for error logs. This enhancement ensures that logs contain detailed context about where and why an error occurred.

#### rbxdss

- **Caching Mechanism**: Added a caching mechanism for DataStore operations to improve performance. This feature reduces the number of direct calls to the DataStore service by caching frequently accessed data.
- **Dynamic Cache Configuration**: Introduced `setCacheEnabled` function to enable or disable caching dynamically. This function allows developers to control caching behavior at runtime based on their application's needs.
- **Improved Error Handling**: Improved error handling and logging for DataStore operations. This improvement ensures that errors are logged with detailed information, making it easier to diagnose and fix issues related to DataStore interactions.
- **Remove Async**: Added the `RemoveAsync` function to be able to delete a player's data in the data stores.

[1.1.0]: https://github.com/blockguard-sf/BLuau/releases/tag/v1.1.0