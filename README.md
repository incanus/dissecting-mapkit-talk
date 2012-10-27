This is a talk I gave at CocoaConf PDX in October 2012 in Portland, Oregon. Here's the talk blurb: 

> Dissecting the "Kit" in MapKit
> 
> You may or may not have experience working with Apple's MapKit, but have you ever considered what goes into building it from scratch? I have, because I've helped do just that. This session will go over the high-level components of MapKit -- things like the map view, annotations, annotation views, and user location services -- and talk about what they do, but also how they can be -- and have been -- duplicated. We will compare and contrast with the MapBox iOS SDK, which is a completely open source implementation of MapKit, not a subclass derivative, and see all the complex bits and bobs that go into it, including tile-based layers, annotation recycling, complex interaction delegate callbacks, map tile cache management, and scalable vector drawing, to name a few. 

Slides are in the repo as PDF. 

Be sure to deep clone the repo to get the submodules (e.g. `git clone --recursive`). 