# thesis testing bed

> please delete the `orchestrator` plugin from the list of addons, it breaks Dialogue Manager for some reason; thank you.

> [!IMPORTANT]
> **Is this complete?**
>
> (do please read the fucking codebase also)
>
> A lot of it, yes, though at this point I'd prefer someone else finish the battle system continuing from where I've started.
>
> The [Gesture Recognizer](https://github.com/Pecesitooo/Gesture-Recognizer-Godot) library does all the heavy lifting for recognizing drawings, of particular importance are the `gesture.classify()` and the `await gesture.gesture_name` APIs.
>
> The main battle UI is located in `res://scenes/screens/battles/battle_screen/battle_screen.tscn`. Needs some work to integrate with Dialogue Manager where the dialog is based on the current action ongoing (e.g: player selecting their move, enemy attacked, etc.).
>
> **IF THE PLAYER CHOOSES TO `ACT`, THEY DRAW; THEY DO NOT SELECT FROM A LIST OF OPTIONS.**
>
> The adaptive AI algorithm has already been implemented based, familiarize yourself with the LimboAI library.

> [!CAUTION]
> **Please, do me a favor and avoid cuck coding.**
>
> (and again, read the codebase don't just instantly reach out for ChatCBT and reinvent everything from scratch)
>
> “The act of watching AI fuck your codebase to death without being able to understand what it's doing to it in the same vein of watching yourself get cucked in your cuck chair”
>
> May God help you if you're a programmer and you're too reliant on ~~cuck coding~~ vibe coding (especially now that the stock market has crashed after AI bubble is deflating in **trillions** of dollars worth of losses).
>
> That last combat system had way too many unnecessary autoloads, unclear deeply nested logic, and putting ***all** data into nodes where it didn't belong that it felt like trying to defuse a bomb.

## FAQ

> [!NOTE]
> **Where's the addons?**
>
> Here's the [Google Drive link]()
>
> I've sent the password on FB Messenger.

---

> [!NOTE]
> **Save system?**
>
> Look into `res://save`. The file `slot.gd` defines a save slot and everything else there so far's save data with extra measures taken to avoid hacks.
>
> You can save a slot with `ResourceSaver` and load with `ResourceLoader`

---

> [!NOTE]
> **Map design / level editing tools?**
>
> For level geometry itself use [CSG Blockout](https://youtu.be/hPN2TpN3FSs) inside of a scene where the root node is `Node3D`. You don't have to open up Blender nor manually add collisions by yourself when the addon does it for you.
>
> Spreading props without doing it manually can be done with something like [Proton Scatter](https://store.godotengine.org/asset/hungryproton/protonscatter) or your preferred choice of alternative if that's broken.
>
> For adding interactivity into the scene, it should be simplified with the `GoAction` nodes with [Area3D](https://docs.godotengine.org/en/stable/classes/class_area3d.html) for anything involving the player being within the proximity of an object.

---

> [!NOTE]
> **Is it dark and grimy?**
>
> I don't know how many times I've got to send these links as examples
>
> - https://www.youtube.com/results?search_query=paper+mario
> - https://www.youtube.com/results?search_query=bug+fables
>
> In other words, no it's not your [Fallout](https://en.wikipedia.org/wiki/Fallout_(franchise)) fantasy nor is this the game to insert something nasty like a racist stereotype or whatever yee-yee ass bullshit (seriously, surprising us by demonizing the homeless is **not** in good taste it just makes you look like a [misanthropic](https://en.wikipedia.org/wiki/Misanthropy) asshole fkn hell)

## Additional Notes

> I need a damned break
>
> — [`@gekkotadev`](https://github.com/GekkotaDev)
