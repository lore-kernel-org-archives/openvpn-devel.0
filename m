Message-ID: <5006C3D5.8000508@...1114...>
Date: Wed, 18 Jul 2012 16:10:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
	<CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
In-Reply-To: <CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] plugin: load plugin relative to
	plugindir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/07/12 14:44, Jonathan K. Bullard wrote:
> On Tue, Jun 26, 2012 at 1:05 PM, Alon Bar-Lev
> <alon.barlev@...277... <mailto:alon.barlev@...277...>> wrote:
> 
> Currently openvpn requires/endorses specifying full path in plugin 
> parameter. As build system already aware of plugin location, it is 
> possible to load plugin relative to this directory, so full path is
> not required nor more secured.
> 
> Windows is a little more complex as user may change installation 
> directory at install time, so we read plugindir location from the 
> registry, installer will set this value.
> 
> 
> (Sorry Alon, I must have overlooked this when it was first
> posted.)
> 
> I do not understand the privilege escalation risk:
> 
> * A protected (not writable by an unprivileged user) part of 
> Tunnelblick controls the options sent to any instance of OpenVPN 
> that runs as a privileged user, so it sends only acceptable paths. 
> (A computer administrator is the only one who can modify a 
> configuration file, which is the other means of specifying a
> plugin path.) * If a user runs an instance of OpenVPN from the
> OpenVPN binary inside of Tunnelblick, it runs as the user. So it's
> not very different form running it from the command line.
> 
> Aren't other installations of OpenVPN similarly protected? Or are
> you trying to protect against poorly-protected installations?
> 
> Or can the server "push" a plugin path? If allowed (I don't think
> it should be) that is a much bigger problem.

I was about to write about how this can slightly enhance the security
on a system, avoiding random plug-ins to abuse the plug-in interface
to gain control over a system ... until I realised, we already ship
code which can do that.  All you need to do is to have
openvpn-down-root.so available and a shell script which it can use.

So the attack vector is:

* A unprivileged user writes a little script which requires root access
* The computer is configured to allow OpenVPN to run without root
  password
* Configuration file is modified (or command line executing openvpn is
  extended) to add --plugin openvpn-down-root.so with a pointer to his
  script
* This external plug-in openvpn_plugin_open_v*() function in
  openvpn-down-root.so  will be executed with root privileges when
  openvpn is started.
* OpenVPN is closed
* Script runs with root privileges

What the down-root plug-in does, is to fork out a process while
openvpn is still running as root, and wait until the OpenVPN is
closing down loaded plug-ins.  At this point the code script will be
run, with root privileges.  Which makes it a perfectly good jail-break
approach.

This is possible as OpenVPN normally needs root privileges to
configure the network, like TUN/TAP adapter and modifying the routing
table.

A I see to avoid this is to completely run OpenVPN unprivileged and
use OS dependent APIs.

 - Linux:
   NetworkManager has a DBUS interface useful to configure the network,
   or you can use sudo together with iproute2 wrapper scripts.

 - Android have a special API which must be used to get access to a
   tun device and to configure the network

 - A Windows solution is in the works, which tries to provide a
   privilege separation possibility

But I don't know what possibilities *BSDs or OSX may provide, except
the sudo approach.

With an improved privilege separation solutions in place, the need for
the down-root plugin goes away too, which often is used to restore
/etc/resolv.conf changes on *nix platforms.


Okay, enough ramblings for now ...


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGw9MACgkQDC186MBRfrrTGwCeNvIZ7+5ICsiM++JuAhzaC+Fg
jwoAn2HNMoPPNcrumiOci+MN21FwnWMo
=Znxo
-----END PGP SIGNATURE-----

