From: Daniel Hunsaker <dan@...515...>
Date: Sun, 11 Sep 2016 19:45:23 +0000
Message-ID: <1473623122450.44102@...515...>
References: <20160911185153.GS78279@...1296...>
In-Reply-To: <20160911185153.GS78279@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] help wanted: OpenSolaris building
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Gert -

You're looking for OpenIndiana.

The Access Server QA system is currently only looking at the officially-sup=
ported Linux servers, with Ubuntu 12.04+, Windows 7+, and OSX/macOS 10+ cli=
ents.  Eventually, however, once everything is stable enough to start devot=
ing focus to it, I'm planning to add other OSes for testing at least the cl=
ient side, though hopefully also server, and chief among these is Solaris a=
nd its variants.  I have ISOs standing by for OpenIndiana (forked from Open=
Solaris right before the Oracle takeover, and their subsequent shutdown of =
OpenSolaris itself, and the current "de facto" replacement for it), Dyson (=
essentially Debian with the OpenIndiana kernel, illumos), and SmartOS (a fa=
irly popular fork that focuses on Solaris Zones, which are similar to LXC, =
and BSD Jails, as you may already be aware), as well as Solaris 11.3 itself=
 (which I'm not seeing any pricing info for on their site, so wonder if an =
account would even be needed - will have to install a VM and find out).

Hope that helps!

Daniel Hunsaker
QA / Automation
OpenVPN Technologies, Inc

irc://irc.freenode.net: danhunsaker

________________________________________
From: Gert Doering <gert@...1296...>
Sent: Sunday, September 11, 2016 12:51
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] help wanted: OpenSolaris building

Hi,

as you might know, we try to build everything we commit to git on all
supported platforms (using buildbot).  This works quite well and has
helped us keep things consistently working across all platforms, at least
as far as we have tests for each feature...

One of my problem childs is (Open)Solaris, though.  I have a VM that is
fairly old and has the GNU toolchain on it, but we have no access to
a current system, using the Sun/Oracle C compiler.

So, I'm looking for pointers :-)

 - is there an (easy to install and maintain) OpenSource variant of
   "Solaris" still around?

 - is there a developer program at Oracle, where one can get access to
   a current Solaris version plus Oracle C compiler, free of charge
   (a hosted build environment is only partially usable, because we
   run VM tests from buildbot, and those need root access...)

 - ... other ideas?

(I admit I'm lazy, and have not done much research on this - I just hope
someone has the answer already, while I go and finish a new OpenBSD 6.0,
NetBSD 7.0.1 and FreeBSD 10.3 builslave :-) )

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...
