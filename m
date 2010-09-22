Message-ID: <4C99F1A6.2060500@...515...>
Date: Wed, 22 Sep 2010 15:08:06 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Debian/Ubuntu snapshot packages for OpenVPN
	available
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
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

As some of you may know, I've been working on integrating Debian
packaging into our Buildbot CI server. Now I got the first _very rough_
debs out there:

<http://build.openvpn.net/downloads>

NOTE: I have not yet tested these packages _at all_, although
superficially they seem ok. I'd be very interested to know if these
packages work for you (or not) and where they could be improved.

Packages are currently being built from two branches ("beta22" and
"allmerged") and for 4 OS/platform combinations:

Ubuntu 10.04 i386/amd64
Debian 5 (Lenny) i386/amd64

When Debian 6 (Squeeze) and Ubuntu 10.10 will be released, I will setup
4 additional VMs to handle those, too. My intention is to automatically
rebuild and publish these packages every time a commit is made to the
Git repository. I also intend to setup an apt repository which people
can use to  conveniently run the latest and greatest OpenVPN code. When
I've got Debian-based distributions covered, I intend to move to the
RPM-based ones.

As you can see, having a wide architectural coverage consumes a
surprisingly large amount of VMs. The best way to have snapshot packages
(and build testing) for your OS/architecture of choice is to allocate a
small VM or two for the project's use; 400MB memory and 2GB disk space
should be enough. Root access makes things much easier, but is not an
absolute requirement if you can setup the buildbot + openvpn build
dependencies yourself.

Besides offering dedicated 24/7 VMs you can help the project by running
a buildslave on your personal workstation. It does not have to be
accessible 24/7, as the Buildbot server (buildmaster) queues work
targeted at offline buildslaves. This allows us to make sure latest
OpenVPN code builds properly on the OS your workstation is using. There
are some instructions for setting up an openvpn buildslave here:

<https://community.openvpn.net/openvpn/wiki/SettingUpBuildslave>

Please contact me for further details.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



