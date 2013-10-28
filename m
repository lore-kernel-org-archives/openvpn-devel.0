Message-ID: <526E6949.3070803@...515...>
Date: Mon, 28 Oct 2013 15:40:25 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New 2.3.2 Debian packages available in a temporary
	apt testing repository
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

Hi,

OpenVPN 2.3.2 is now available in _temporary_ test repositories for a
wider variety of Debian-based operating systems:

debian squeeze i386
debian squeeze amd64
debian wheezy i386
debian wheezy amd64
ubuntu lucid i386
ubuntu lucid amd64
ubuntu precise i386
ubuntu precise amd64
ubuntu saucy i386
ubuntu saucy amd64
ubuntu raring i386
ubuntu raring amd64

The new build/packaging system is based on sbuild[1] which makes adding
support for new variants trivial. If your favourite Debian-based
distribution is missing from the list shoot me an email. I have
personally tested only two of the above packages and they seem to work ok:

- Ubuntu Raring (13.04) 64-bit
- Debian Wheezy (7.x) 64-bit

Any help with testing the packages and the apt repository is be much
appreciated! I will migrate this test repository to it's final
destination probably early next week.

Here are instructions for using these test packages:

IMPORTING THE PUBLIC GPG KEY

These Debian packages and associated repository files have been signed with=
 GPG.=20
Therefore, you need to import proper public key or you get warnings when up=
dating=20
software catalogs (e.g. when doing apt-get update):

$ wget -O - http://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -


ADDING THE REPOSITORY FILE

Create a new repository file, e.g. /etc/apt/sources.list.d/testbuild.list w=
ith
content like this:

deb http://build.openvpn.net/repos <oscodename> main

Where <oscodename> is wheezy, raring, or something similar. For a full list=
 look above.

INSTALLING PACKAGES

In most cases, this is as simple as

$ apt-get update && apt-get install <packagename>


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


