Message-ID: <4C2B07C1.9050500@...515...>
Date: Wed, 30 Jun 2010 12:00:49 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Packaging OpenVPN for various platforms?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

As some of you may know, I've been building a Buildbot
(http://buildbot.net/trac) instance for us. In a nutshell, Buildbot
provides several services:

- continous integration: inform devs about build failures with arbitrary
number of build OSes / configurations
- automated packaging: create source tarballs and packages (e.g. Debian,
Redhat) from each build, every night etc.
- publishing the latest tarballs and packages with help from external
apps (apache, yum/apt/ports)

I got the basic build process (autoreconf -vi && ./configure && make)
working in BuildBot already. Now I'd need help with packaging OpenVPN
for various OSes. If you package OpenVPN I'd appreciate a lot if could
contact me. My plan is this:

- write packaging instructions to our Trac wiki
(https://community.openvpn.net/openvpn/wiki)
- convert the instructions into BuildBot code (BuildSteps)

After this is done, we can provide the latest version of OpenVPN for
various platforms with minimal manual effort. This helps developers as
well as users: having the development code in wider circulation helps
spot problems faster resulting in faster release cycle.

Thanks in advance,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


