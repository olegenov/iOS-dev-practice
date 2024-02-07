#  Task questions

* *Question: What issues prevent us from using storyboards in real projects?*
There are several issues in using storyboards. Some of them are:
1. As soon as storyboard is an XML file it is difficult to review and solve conflicts;
2. There are difficulties with development scaling;
3. Storyboards are not such flexible as straight code.

* *Question: What does the code on lines 25 and 29 do?*
```
25. title.translatesAutoresizingMaskIntoConstraints = false
29. view.addSubview(title)
```
By setting translatesAutoresizingMaskIntoConstraints to false, you indicate that you will be providing explicit Auto Layout constraints for the view rather than relying on the autoresizing.
The view.addSubview(title) line adds a subview to a parent container view.

* *Question: What is a safe area layout guide?*

The safe area layout guide helps to adapt to various screen sizes. The safe area represents the part of the screen that doesnt conflict with system-provided elements.

* *Question: What is [weak self] on line 23 and why it is important?*

```
sliderRed.valueChanged = { [weak self] value in
```
By using this, you help prevent retain cycles and potential memory leaks, ensuring that objects can be deallocated when they are no longer needed.

* *Question: What does clipsToBounds mean?*

The property determines whether subviews that extend beyond the bounds of the view should be visible or not.

* *Question: What is the valueChanged type? What is Void and what is Double?*
It is UIControl event, such as those related to UI components like sliders, switches, and other. The valueChanged event is triggered when the user interacts with the control and changes its value. Void and Double are types)
