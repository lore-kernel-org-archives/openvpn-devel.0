From: Mike Auty <mike.auty@...277...>
Message-ID: <567EA6B5.9040108@...277...>
Date: Sat, 26 Dec 2015 14:39:49 +0000
MIME-Version: 1.0
Subject: [Openvpn-devel] Fabian Knittel's 802.1q/VLAN tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...2108...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

It's been a long time since I contributed to OpenVPN, but I've used it
on and off since 2004.  I recently wanted to have a single instance of
OpenVPN support multiple clients, segregated into separate VLANs based
on their credentials.  After a little research I found that Fabian
Knittel (CCed) had a set of patches from 2010 living in a feature
branch that never got merged [1], and that there was an outstanding
ticket from 2012 [2] to get these patches into the main release.

Contacting the author (and another member of OpenVPN from [2], also
CCed) I found out that he'd been keeping the patches reasonably
up-to-date [3] and been using them for a university server for several
years.  I've both read through, rebased and built the patches and they
seem quite straight forward and comprehensible (and having set up a
small test rig, they work too!).  5:)  There are, however, 22 of them
as created by git format-patch.

Given I didn't author most of these patches (I fixed up a tiny bit of
documentation at the end), I was wondering how best to supply these so
that they could be considered for inclusion in the main tree?  Should
I submit a pull request from my repo with all the patches applied [4],
or post the git format-patches to this mailing list, or is there
another method I should be using?

I'm keen to get this added so that a single OpenVPN instance can
appropriately segregate traffic without requiring multiple
configurations.  I'm happy to try and make any changes required
(although since my C skills are limited, I'm also hoping the original
author may be able to help out).  Please just let me know how best to
proceed...

Mike  5:)

[1]
http://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/cover.1270
060247.git.fabian.knittel@...1338.../
[2] https://community.openvpn.net/openvpn/ticket/6
[3] https://github.com/fknittel/openvpn/tree/feat_vlan
[4] https://github.com/ikelos/openvpn/commits/master
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iKYEARECAGYFAlZ+pq5fFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldEZGQjEyM0ZDRDBCRjcwREE1MzA0MjNBREJC
QkFENkEyNkMyMDE1N0EACgkQu7rWomwgFXr7TgCfZ7bGRcv3Ho+gno+TFAWW5Pwn
VuMAoI69rY3epjRdLaj51wWJmxkqnwbh
=hSPC
-----END PGP SIGNATURE-----

