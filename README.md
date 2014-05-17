Crittertrader
=============

Trade your critters!

Crittertrader is a client program used to swap critters evolved with the awesome Critterding
program written by Bob Winckelmans: http://critterding.sourceforge.net

Evolving critters with Critterding takes a lot of processing power. Just to find something that can
eat and reproduce can take a few hours worth of churning away. If we can take everyone else's 
precomputed best critters and improve those, we can work together to produce the best possible
critters.

Crittertrader has a server program so you can run a server if you like, or use the default server
which should be live and swapping critters right now. To run a server, see the server project
here: https://github.com/lesliev/crittertrader

Dependencies
------------
I've only tried running the client on (Ubuntu) Linux - but it doesn't have too many dependencies -
basically only the Faraday gem. If you have Ruby (probably > 1.9.3) and can install bundler, 
you should be able to get up and running fairly easily with the commands below.

The client does use quite a few command line programs though:
bzip2, bunzip2, md5sum, rm, mv

You'll need git and gem to install.


Running the client
------------------

You'll need Ruby, probably any version after 1.9.3 would work. I've been testing with 2.1.1 though.

```
ruby --version       # should probably be v1.9.3 or higher
gem install bundler
git clone https://github.com/lesliev/crittertrader.git
cd crittertrader
bundle install
bundle exec ./crittertrader
```

Now crittertrader should upload and download a critter about every 10 minutes.


Configuring Critterding
-----------------------

Crittertrader swaps critters in and out of the default autoexchange directory:
~/.critterding/save/exchange

For Critterding to save and load critters from there, you need to enable 'autoexchange'.
I do that like this:

1. Run critterding
2. Press 's' to save a configuration profile
3. Find the profile that was saved (look in the terminal for the filename) and edit it
4. Set the autoexchange interval to something like 5 minutes
5. You probably also want to load and save automatically, to continue previous critters

So these are my settings:

```
critter_autoexchangeinterval 300
autoloadlastsaved 1
critter_autosaveinterval 300
```

Then make sure you always start critterding with that configuration file:

```
critterding --profile <profile-file>
```

