Message-ID: <4DB88287.7070006@...1114...>
Date: Wed, 27 Apr 2011 22:54:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4DB864E0.4060207@...515...>
In-Reply-To: <4DB864E0.4060207@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2.0 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: OpenVPN Users <Openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/04/11 20:48, Samuli Sepp=E4nen wrote:
|
| Note that we've recently switched to using a different Git repository:
|
| <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>

Just to follow up this one a little bit with more details.

For me personally, the 2.2 release is a remarkable release for the OpenVPN
community.  This is probably the release with the most visible patches from
the community.  If I've counted correctly, there are 23 different patch
authors in addition to the work of James Yonan.  Over 100 patches have been
contributed and have been implemented.  So I want to thank all of you who h=
ave
contributed with fixes, new features, documentation and other improvements.

To mark that we now are officially using git as the official source
repository, all releases and the approved patches will now go into the new
openvpn.git tree, as announced.  This tree will also have release branches,
one for each major release, like 2.1, 2.2 and the coming 2.3.  All major and
minor releases (2.1.x, 2.2.x, etc) are in addition tagged.

For more information about the code repositories, please have a look at our=
 wiki:
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Coderepo=
sitories>


We have for about a year used the openvpn-testing.git tree.  The future of
this tree will be discussed in the near future.  Right now, this tree will =
be
available.  The master branch in this tree and in the openvpn.git tree will=
 be
kept in sync, and all approved feature branches will be merged into allmerg=
ed
together with the master branch when they are considered stable enough.  Ri=
ght
now, it is not much new things in the allmerged branch, as the last
outstanding and approved feature branches was the IPv6 branches.

As you now understand, the OpenVPN 2.3 will have IPv6 as one of the more
important features.  Both feat_ipv6_transport (connecting/listening to IPv6
addresses between OpenVPN client and server) and feat_ipv6_payload
(transporting IPv6 traffic inside the tunnel) have been available in the
allmerged branch for about a year, so it is considered safe and stable enou=
gh
to be merged into the master branch.  So everyone who wants to begin to look
at what OpenVPN 2.3 really will bring, grab the a master branch.


So to summarise it quickly:  openvpn.git is the main git repository, where =
all
that has been released and will be released in the coming OpenVPN releases =
can
be found.  The openvpn-testing.git repository contains now experimental code
which needs a lot of testing and possibly much more development.  And the
master branch in both trees will stay in sync.  What is in found the master
branch will make it into a coming release.

Again thanks to all support and contributions.  They are indeed very much
appreciated!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk24gocACgkQDC186MBRfrpyjQCeLPDjeQIUhj1S2QU68lbGtVrh
k9AAn3lEsLkrPIfhyOwjyd189vu+QzFU
=3DtA5S
-----END PGP SIGNATURE-----

