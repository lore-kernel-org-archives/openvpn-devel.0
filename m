From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <Pine.LNX.4.60.0407080941160.5287@...210...> <200407081043.25501.jim@...41...>
In-Reply-To: <200407081043.25501.jim@...41...>
MIME-Version: 1.0
Message-Id: <200407082328.32017.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jul  8 13:36:08 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net
Cc: Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>, upsdev@...251..., rkroll@...252...

> > >> 1. On Windows, if the the service wrapper has started some openvpn
> > >> processes before our gui agent is started, how should find out about
> > >> those processes?
> > >>
> > >> I can think of the following ways:
> > >>
> > >> 1a. Ask the service wrapper via the socket interface that I'm working
> > >> on right now. This will require the service wrapper not only start the
> > >> processes, but keep a table over running processes.
> > >
> > > I think it's an important point worth some discussion on whether to (a)
> > > put all the "intelligence" in the GUI applet and have the service
> > > wrapper just be a basic proxy to an admin-privileged CreateProcess, or
> > > (b) write a portable service wrapper that's designed to run on all the
> > > OSes which OpenVPN currently supports, and which would do all the
> > > "under-the-hood" work in starting/stopping/managing of different
> > > OpenVPN processes, and the GUI applet would do nothing more than export
> > > the control interface of the portable service wrapper to a
> > > platform-specific, lightweight GUI.

(b) already exists. It's daemontools. (Does not exist on NT, though).
Daemontools' license is not open enough, but there is a opensource clone
at http://smarden.org/runit/.

> > > (a) is probably simpler to develop, but (b) may be a better solution
> > > long-term because it handles the management interface in a portable
> > > way, and makes the GUI itself (which probably needs a separate admin
> > > module for Win32, YaST, X, http, etc.) as lightweight and stateless as
> > > possible.

Let me hijack your attention for a moment.

Once I bought an UPS. I googled for UNIX UPS tools and found package
named NUT. I downloaded and installed it. It consists of low-level UPS
drivers, UPS-monitoring daemons, servers listening on TCP and clients
which can talk to these servers. And maybe something else, I forgot.
A bunch of config files is used to configure things like how are UPSes
connected, which users can do what to which UPS, etc, etc, etc.

After an hour spent figuring out how to organize it, I managed to start
it. Or shall I say 'them', because I needed to run several processes.
I ended up with 2 Mbites of RSS spent for UPS monitoring.

I didn't like it. I didn't like it at all. I didn't like multiple
config files. I didn't like additional user auth and crypto (who can
connect to my UPS daemon, passwords, encryption of TCP protocol used
to talk with it....). Why do I need Yet Another TCP Server, Auth, Crypto,
Logging, Etc when ssh/ssl and daemontools already exist and
is well debugged?

I took NUT apart. I chainsawed away the cruft, all 99% of it,
and made smallish daemon which connects to serial port
and can (1) poll UPS about it's state and (2) can command
UPS to e.g. test battery, shutdown, etc. I put it under
daemontools. I don't need to control it over the net
or from another user account, but if I'll need to,
I will do it using existing tools like ssh.
For example, ability to stop/restart daemon by user
is controlled via chmod/chown'ing daemontools' control file.
Daemontools are very elegant. Instead of reinventing
ACLs, they _use_ ACLs already designed for filesystem
access control. Cool, isn't it?

When compiled against dietlibc, my ups daemon consumes 32 _kilobytes_
of RAM:

PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
884 root      15   0    32   32    24 S     0.0  0.0   0:01   0 powermust

What I am trying to say? I am very happy that you guys are actively
working on openvpn. Really.

Just please do not OVERdesign it.

Maybe it's better to try to port daemontools to Windows
and run openvpn daemon(s) under it.

> All of this of course represents a lot of development effort, so I think it
> makes a lot of sense to "evolve" towards these goals in small incremental
> steps.

Exactly what I meant. It's counterproductive to
reinvent the wheel. NUT folks wrote a ton of code duplicated
in ssh et al, and they need to debug it also. Nnd then it
just sits there wasting RAM. Ugly.
--
vda


