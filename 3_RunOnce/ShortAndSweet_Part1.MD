# Short And Sweet

```
final class RunOnce {
	private var hasRun: Bool = false

	typealias ActionClosure = () -> ()

	func run(action: ActionClosure) {
		guard UserDefaults.standard.bool(forKey: "Onboarding") == false else {
			return
		}
		action() // set UserDefaults Onboarding key to true
		hasRun = true
	}
}
```

A few things to note:

- The class is prefixed with final
- UserDefaults is just an example, in the original tweet, @onmyway133 mentions a good use for this scenario is to run an expensive block of code and ensures this code is executed only once
- Enabling private on the hasRun instance variable, enforces the scope of the variable to be limited within the class itself. This simple use of the private declaration makes this an elegant solution, without any external classes interfering with the variable at all.
- Is it thread safe? No. To make this thread safe (@sliwinskilukas)[https://twitter.com/sliwinskilukas/status/1262296254379429889] mentions that using static var within a struct will make it thread safe as an inner struct is created once. I've seen this implmentation before with a Singleton pattern on stackoverflow 
