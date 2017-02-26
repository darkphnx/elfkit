# Elfkit

Elfkit is a gift exchange management application. Originally written to manage
the annual office Secret Santa, though it could be easilly reskinned to be less
festive.

See a working version at [elfk.it](https://elfk.it).

The app is Rails 5 with the frontend written with SASS, Haml and Coffeescript.
Background jobs (such as matching) are taken care of with ActiveJob and
DelayedJob.

The participant matching code is probably the most interesting, and can be
found at `lib/elfkit/matchmaker.rb`, with a corresponding set of tests at
`spec/lib/matchmaker_spec.rb`.

![Screenshot 1](http://i.imgur.com/b3Zhn2b.png)
![Screenshot 2](http://i.imgur.com/loO7iQV.png)