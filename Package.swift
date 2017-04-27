import PackageDescription

let package = Package(
    name: "JSONStructGen",
    dependencies: [
        .Package(url: "git@github.com:kylef/Commander.git", majorVersion: 0),
        .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 3)
    ]
)
